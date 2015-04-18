my dotfiles.

# INSTALL

Add following snippet to `~/.bashrc`.

```bash:~/.bashrc
if [ -f ~/dotfiles/mybashrc ] ; then
  . ~/dotfiles/mybashrc
fi
```

Run following commands.

```bash
ln -s dotfiles/inputrc .inputrc
ln -s dotfiles/emacs.d .emacs.d
emacs -Q --script dotfiles/emacs.d/install.el
cp dotfiles/emacs.d/lisp/myfont.sample.el dotfiles/emacs.d/lisp/myfont.el
```

### geeknote

Install `geeknote`.

(geeknote)[http://www.geeknote.me/]

And adjust `dotfiles/emacs.d/lisp/myfont.el`. (This file is `.gitignore` d.)
