my dotfiles.

# INSTALL

add following snippet to `~/.bashrc`.

```bash:~/.bashrc
if [ -f ~/dotfiles/mybashrc ] ; then
  . ~/dotfiles/mybashrc
fi
```

run following commands.

```bash
ln -s dotfiles/inputrc .inputrc
ln -s dotfiles/emacs.d .emacs.d
emacs -Q --script dotfiles/emacs.d/install.el
mv dotfiles/emacs.d/lisp/myfont.sample.el dotfiles/emacs.d/lisp/myfont.el
```
