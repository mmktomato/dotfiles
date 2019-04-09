my dotfiles.

**NOTE: If you use Windows, use WSL.**

# INSTALL

Clone this repository to home directory.

```bash
cd ~
git clone https://github.com/mmktomato/dotfiles.git
```

## Bash

Add following snippet to `~/.bashrc`. Make sure that `~/.bash_profile` exists and it loads `~/.bashrc`.

```bash:~/.bashrc
if [ -f ~/dotfiles/bashrc ] ; then
  . ~/dotfiles/bashrc
fi
```

If you use macOS, install `coreutils` via Homebrew.

```bash
brew install coreutils
```

Run bootstrap script.

```bash
. bootstrapper/bash.bash
```

### git

```bash
$ git config user.name '<YOUR_NAME>'
$ git config user.email '<YOUR_EMAIL_ADDRESS>'
```

## Vim

Run bootstrap script.

```bash
. bootstrapper/vim.bash
```

Edit `dotfiles/font.vim`. (This file is `.gitignore` d.)

### Disable Input Method
#### macOS

Nothing to do.

#### WSL

```bash
$ cp ImDisable.ahk /mnt/c/tool/
```

Download [AutoHotkey](https://autohotkey.com/) and make sure `AutoHotkeyU64.exe` is in Windows' $PATH.

## Emacs

Run bootstrap script.

```bash
. bootstrapper/emacs.bash
```

Edit `dotfiles/emacs.d/lisp/myfont.el`. (This file is `.gitignore` d.)
