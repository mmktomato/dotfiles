my dotfiles.

**NOTE: If you use Windows, use WSL.**

# INSTALL

Clone this repository to home directory.

```bash
cd ~
git clone https://github.com/mmktomato/dotfiles.git
```

## Bash or Zsh

Add following snippet to `~/.bashrc` or `~/.zshrc`. Make sure `~/.bash_profile` or `~/.zprofile` exists and it loads `~/.bashrc` or `~/.zshrc`.

```bash:~/.bashrc or ~/.zshrc
if [ -f ~/dotfiles/shrc ] ; then
  . ~/dotfiles/shrc
fi
```

If you use macOS, install `coreutils` via Homebrew.

```bash
brew install coreutils
```

Run bootstrap script.

```bash
. bootstrapper/shell.bash
```

## VSCode

Install [VSCodeVim](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim).

Copy the content of `vscode.settings.json` to VSCode's settings.json.

## Zed

- Copy the content of `zed.settings.json` to Zed's settings.json.
- Copy the content of `zed.keymap.json` to Zed's keymap.json.

## Vim

Run bootstrap script.

```bash
. bootstrapper/vim.bash
```

### Disable Input Method
#### macOS

Install [swim](https://github.com/mitsuse/swim) and link it to `~/bin`. (This directory is included in $PATH. Start bash again if necessary.)
Make sure that `ABC`(`com.apple.keyboardlayout.all`) exists as input source.

#### WSL

```bash
$ cp ImDisable.ahk /mnt/c/tool/
```

Download [AutoHotkey](https://autohotkey.com/) and make sure `AutoHotkeyU64.exe` is in Windows' $PATH.
