#!/bin/bash

function bootstrap_vim() {
    local CLONE_DIR=dotfiles

    mkdir -p vimfiles/tmp

    ln -s $CLONE_DIR/vimrc .vimrc
    ln -s $CLONE_DIR/gvimrc .gvimrc

    cp $CLONE_DIR/font.sample.vim $CLONE_DIR/font.vim
    . $CLONE_DIR/vim-plugins.bash
}

cd ~
bootstrap_vim
cd - > /dev/null 2>&1

