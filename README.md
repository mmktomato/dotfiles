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
. bootstrapper/bash.sh
```

## Vim

Run bootstrap script.

```bash
. bootstrapper/vim.sh
```

And edit `dotfiles/font.vim`. (This file is `.gitignore` d.)

If you use macOS, install [swim](https://github.com/mitsuse/swim)

## Emacs

Run bootstrap script.

```bash
. bootstrapper/emacs.sh
```

And edit `dotfiles/emacs.d/lisp/myfont.el`. (This file is `.gitignore` d.)
