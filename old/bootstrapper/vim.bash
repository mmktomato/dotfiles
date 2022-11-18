#!/bin/bash

function bootstrap_vim() {
    local DOTFILES=${1:-~/dotfiles}

    mkdir -p ~/vimfiles/tmp

    ln -s $DOTFILES/vimrc ~/.vimrc
    ln -s $DOTFILES/gvimrc ~/.gvimrc

    cp $DOTFILES/font.sample.vim $DOTFILES/font.vim
    . $DOTFILES/vim-plugins.bash
}

bootstrap_vim

