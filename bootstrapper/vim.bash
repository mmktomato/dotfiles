#!/bin/bash

function bootstrap_vim() {
    local DOTFILES=${1:-~/dotfiles}

    mkdir -p ~/vimfiles/tmp

    ln -s $DOTFILES/vimrc ~/.vimrc

    . $DOTFILES/vim-plugins.bash
}

bootstrap_vim

