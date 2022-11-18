#!/bin/bash

function bootstrap_emacs() {
    local DOTFILES=${1:-~/dotfiles}

    ln -s $DOTFILES/emacs.d ~/.emacs.d

    emacs -Q --script $DOTFILES/emacs.d/install.el
    cp $DOTFILES/emacs.d/lisp/myfont.sample.el $DOTFILES/emacs.d/lisp/myfont.el
}

bootstrap_emacs

