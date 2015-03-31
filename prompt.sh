function __mk5_git_pwd {
  # Get git base directory
  local gitbase=$(git rev-parse --show-toplevel 2>/dev/null)

  if [[ $gitbase ]]; then
    # Strip git base directory
    echo "$(basename $gitbase)${PWD##$gitbase}"
  else
    # Replace home with ~
    echo $PWD | sed "s|^$HOME|~|"
  fi
}

function __mk5_git_branch {
  # Grab status code first
  git symbolic-ref HEAD > /dev/null 2>&1
  local last_status=$?

  local branch="$(git symbolic-ref HEAD 2>/dev/null)"

  if [[ $last_status == 0 ]]; then
    echo $branch | sed "s|^refs/heads/||"
  else # detached head
    echo "$(git rev-parse --short HEAD 2>/dev/null)"
  fi
}

function __mk5_git_dirty {
  echo "$(git status -s --ignore-submodules=dirty 2>/dev/null | wc -l)"
}

function __mk5_git_outgoing {
  echo "$(git log origin/HEAD..HEAD | grep '^commit' | wc -l)"
}

function __mk5_git_incoming {
  echo "$(git log HEAD..origin/HEAD | grep '^commit' | wc -l)"
}

function __mk5_set_prompt {
  # Grab status code first
  local last_status=$?

  local normal='\[\e[0m\]'
  local white='\[\e[0;37m\]'
  local green='\[\e[0;32m\]'
  local b_green='\[\e[1;32m\]'
  local b_yellow='\[\e[1;33m\]'
  local b_red='\[\e[1;31m\]'

  local dirty_char=$(echo -e '\xc2\xb1\x0a')
  local incoming_char=$(echo -e '\xe2\xac\x87\x0a')
  local outgoing_char=$(echo -e '\xe2\xac\x86\x0a')
  local chev_char=$(echo -e '\xe2\x9d\xb1\x0a')

  local chevcolor
  if [[ $last_status == 0 ]]; then
    chevcolor="$b_green"
  else
    chevcolor="$b_red"
  fi

  local chev
  if [[ $USER == 'root' ]]; then
    chev="$chev_char$chev_char$chev_char"
  else
    chev="$chev_char"
  fi

  local git_info
  if [[ $(__mk5_git_branch) ]]; then
    git_info="$white($(__mk5_git_branch)"

    if [[ $(__mk5_git_dirty) != 0 ]]; then
      git_info="$git_info $b_yellow$(__mk5_git_dirty)$dirty_char"
    fi

    if [[ $(__mk5_git_incoming) != 0 ]]; then
      git_info="$git_info $b_red$(__mk5_git_incoming)$incoming_char"
    fi

    if [[ $(__mk5_git_outgoing) != 0 ]]; then
      git_info="$git_info $b_blue$(__mk5_git_outgoing)$outgoing_char"
    fi

    git_info="$git_info$white) "
  fi

  PS1="$git_info$green$(__mk5_git_pwd) $chevcolor$chev$normal "
}

PROMPT_COMMAND=__mk5_set_prompt
