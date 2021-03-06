.dots
=====

All of my dotfiles.

![dtop](https://s.kirbi.es/dtop.png)

Here's what you'll need...

## Software

### All platforms

- GNU Stow
- metakirby5/zenbu
- metakirby5/scripts (somewhat optional)
- Packages from relevant managers (`~/.local/deps/*`)

### OS X

- Xcode
- brew
- metakirby5/Spice
- XVimProject/XVim (hopefully on brew soon)
- DrabWeb/iTerm2 (borderless + gaps + padding)

### Linux

- metakirby5/lemonblocks
- rxvt-unicode-256color
- tmux
- Airblader/i3-gaps
- krypt-n/bar
- gstk/siji
- acrisci/i3ipc-python
- eBrnd/i3lock-color
- xautolock
- chjj/compton
- melek/dmenu2
- enkore/j4-dmenu-desktop
- ffmpeg
- imagemagick
- jq
- dunst + dunstify
- notify-send
- feh
- conky
- mpd and/or mopidy
- mpc
- mpv
- ncmpcpp
- ranger
- scrot
- dropbox
- nmtui
- xflux
- unclutter
- actionless/oomox
- gtk-reload (from neeasade/autotheme.sh)
- devmon
- trash-cli
- eBrnd/i3lock-color

## Fonts

### OS X

- System fonts.

### Linux

- Calibri
- [PixelMPlus12](https://osdn.jp/projects/mix-mplus-ipa/releases/58930)
- [Source Code Pro](https://github.com/adobe-fonts/source-code-pro)
- [M+ 1p](http://mplus-fonts.osdn.jp/mplus-outline-fonts/download/)
- [Baekmuk Gulim](http://www.freekoreanfont.com/baekmuk-gulim-download/)

## Browsers

### Userscripts

- ccd0/4chan-x
- nebukazar/StyleChan

### Safari

Extensions in `_misc/osx/safari`.

### Chrome

Theme in `~/.local/zenbu/chrome_theme/`.

For OS X, use the system theme.

[Dark Red Dark](https://chrome.google.com/webstore/detail/dark-red-dark/blhnkflbilekjahkjkkjchfkkhgcnfjj) is another option.

## Installation

### All platforms

- Clone this repo into `~/.dots`.
- Add `source ~/.linker` to the appropriate files
  (`~/.bashrc` and `~/.bash_profile`)
- Follow platform-specific instructions.
- Install packages from language-specific managers.
  - You can also try using `install-leaves` instead.
- Install browser extensions/themes.
- If you want, copy over `_misc/shell/root_bashrc.sh` to your root's
  home directory (to the appropriate file) and symlink the `.vimrc`.
- Reboot.

### Language-specific package managers

- Python: `xargs pip install --upgrade < ~/.local/deps/pip`
- Node: `xargs npm install -g < ~/.local/deps/npm`
- Ruby: `xargs gem install < ~/.local/deps/gem`
- Lua: `xargs luarocks install < ~/.local/deps/luarocks`

### OS X

*EXPERIMENTAL:* Run `_setup/osx`.

-- or --

- Install Xcode from the App Store.
- Import the `Terminal.app` profile in `_misc/osx/Japanesque.terminal`.
- Install `brew` from [brew.sh](http://brew.sh/).
- Install `stow` using `brew`.
- `cd ~/.dots`
- `stow base osx`
- `brew bundle --file=- < ~/.local/deps/brew`
- [Set your shell to `brew`'s `bash`.](https://johndjameson.com/blog/updating-your-shell-with-homebrew/)
- `source ~/.bashrc`
- Install `zenbu` via `pip` and use it to choose a colorscheme.
- `yes | osx-set-defaults`
- Tweak whatever other settings you want in Preferences.app.

### Linux

- Install all the dependencies you need with your favorite package
  manager. You really need `stow` and `zenbu`.
- `cd ~/.dots`
- `stow base linux`
- If you are using i3:
  - `stow i3`
  - Ensure you are using `i3init` to start i3.
- `source ~/.bashrc`
- Ensure your profile is called `profile` so the templates in
  `~/.mozilla/firefox/profile` can render properly.
- Use `zenbu` and choose a colorscheme.
- Install *Stylish* for Chrome/Firefox and install the relevant userstyles
  from `~/.local/zenbu/userstyles`.
- Set up oomox and use the file in `~/.local/zenbu/oomox.sh`.

## Maintenance

- Regularly pull and `restow-dots` to keep up-to-date.
- Regularly `dump-leaves` to export dependencies.

## TODO

- [ ] Fix zenbu files to allow light colorschemes
- [ ] Stick XVimProject/XVim on brew
