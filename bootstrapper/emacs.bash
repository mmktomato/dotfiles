#!/bin/bash

function bootstrap_emacs() {
    local CLONE_DIR=dotfiles

    ln -s $CLONE_DIR/emacs.d .emacs.d

    emacs -Q --script $CLONE_DIR/emacs.d/install.el
    cp $CLONE_DIR/emacs.d/lisp/myfont.sample.el $CLONE_DIR/emacs.d/lisp/myfont.el
}

cd ~
bootstrap_emacs
cd - > /dev/null 2>&1

