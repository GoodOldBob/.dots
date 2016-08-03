local C = require('consts')

-- Curry wrapper to resolve functional dependencies
local c = function(func)
  return function(...)
    return func:curry(...)
  end
end

-- Tables+
function T(t)
  return setmetatable(t or {}, {__index = table})
end
setmetatable(table, {
  __index = {
    -- Shallow copy
    copy = c(function(self)
      local copied = T{}
      for k, v in ipairs(self) do
        copied[k] = v
      end
      return copied
    end),

    -- Apply a function over each element
    -- function signature is (value, key) since values are more useful
    map = c(function(self, func)
      local mapped = self:copy()
      for k, v in ipairs(self) do
        mapped[k] = func(v, k)
      end
      return mapped
    end),

    -- Return the x in self s.t. func(x) is truthy
    -- function signature is (value, key) since values are more useful
    filter = c(function(self, func)
      local filtered = T{}
      for k, v in ipairs(self) do
        if func(v, k) then
          filtered[#filtered + 1] = v
        end
      end
      return filtered
    end),

    -- Combine tables
    merge = c(function(self, arr, ...)
      local merged = self:copy()
      for _, t in ipairs({arr, ...}) do
        for k, v in pairs(t) do
          merged[k] = v
        end
      end
      return merged
    end),

    -- Concatenate arrays
    extend = c(function(self, arr, ...)
      local extended = self:copy()
      for _, t in ipairs({arr, ...}) do
        for _, v in ipairs(t) do
          extended[#extended + 1] = v
        end
      end
      return extended
    end),
  },
})

-- Functions+
debug.setmetatable(function() end, {
    -- Arity (http://stackoverflow.com/a/20177245)
    __len = function(self)
        return debug.getinfo(self, 'u').nparams
    end,

    __index = {
      -- Single-time partial application
      later = function(self, ...)
        local args = T{...}
        return function()
          return self(args:unpack())
        end
      end,

      -- Arity-based partial application
      curry = function(self, ...)
        local args = T{...}

        -- If arity reached, call
        if #args >= #self then
          return self(...)
        end

        -- Else, defer to next call
        return function(...)
          return self:curry(args:extend({...}):unpack())
        end
      end,

      -- Call with packed arguments
      withPacked = c(function(self, args)
        return self(T(args):unpack())
      end),

      -- Call over each element in each array in ..., position-wise
      map = c(function(self, arr, ...)
        local args = T{arr, ...}

        -- Get # of items to map
        local nargs = math.max(args:map(function(list)
          return #list
        end):unpack())

        local mapped = T{}
        for i = 1, nargs do
          -- Call on with ith arg of each arg list
          mapped[i] = self(args:map(function(list)
            return list[i]
          end):unpack(1, #args))
        end
        return mapped
      end),

      -- Return the x in arr s.t. self(x) is truthy
      filter = c(function(self, arr)
        return table.filter(arr, self)
      end),
    },
})

-- Scala-style switch(case) {...}
local switch = (function(case, caseTable)
  local x = caseTable[case]
  return x == nil and caseTable[C.DEFAULT] or x
end):curry()

-- Configurable modules from function
-- exporter can either take nil for default arguments,
-- or a table for named arguments.
local export = (function(exporter)
  return setmetatable(exporter(), {__call = function(_, ...)
    return exporter(...)
  end})
end)

return {
  T = T,
  switch = switch,
  export = export,
}
