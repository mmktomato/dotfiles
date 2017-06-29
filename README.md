my dotfiles.

# INSTALL

## Bash

Add following snippet to `~/.bashrc`.

```bash:~/.bashrc
if [ -f ~/dotfiles/mybashrc ] ; then
  . ~/dotfiles/mybashrc
fi
```

Make sure that `~/.bash_profile` exists and it loads `~/.bashrc`.

Run following commands.

```bash
# in *nix
ln -s dotfiles/inputrc .inputrc
mkdir .mytrash

# in Windows
mklink ".inputrc" dotfiles\inputrc
```

## Emacs

Run following commands.

```bash
# in *nix
ln -s dotfiles/emacs.d .emacs.d

# in Windows
mklink /D ".emacs.d" dotfiles\emacs.d
```

```bash
emacs -Q --script dotfiles/emacs.d/install.el
cp dotfiles/emacs.d/lisp/myfont.sample.el dotfiles/emacs.d/lisp/myfont.el
```

And adjust `dotfiles/emacs.d/lisp/myfont.el`. (This file is `.gitignore` d.)

# Vim

Run following commands.

```bash
# in *nix
. dotfiles/vim-plugins.sh
mkdir -p vimfiles/tmp
ln -s dotfiles/vimrc .vimrc
ln -s dotfiles/gvimrc .gvimrc
cp dotfiles/font.sample.vim dotfiles/font.vim

# in Windows
dotfiles\vim-plugins.bat
mkdir vimfiles\tmp
mklink .vimrc dotfiles\vimrc
mklink .gvimrc dotfiles\gvimrc
copy dotfiles\font.sample.vim dotfiles\font.vim
```

And adjust `dotfiles/font.vim`. (This file is `.gitignore` d.)

## Geeknote

Install `geeknote`.

[geeknote](http://www.geeknote.me/)

And run following commands.

```bash
geeknote login
geeknote settings --editor vim # or mvim -f, emacsclient, etc...
```

