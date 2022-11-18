#!/bin/bash

function git_clone() {
    local url=$1
    local dir=$2

    if [ -d $dir ]; then
        echo "-- SKIPPED ($url)"
    else
        git clone $url $dir
    fi
}

function fetch_vim_plugins() {
    local github=https://github.com
    local gui=~/vimfiles/pack/gui
    local cui=~/vimfiles/pack/cui

    mkdir -p $gui/start
    mkdir -p $gui/opt
    mkdir -p $cui/start
    mkdir -p $cui/opt

    git_clone $github/vim-scripts/Zenburn.git $gui/start/Zenburn
    git_clone $github/ctrlpvim/ctrlp.vim.git $cui/start/ctrlp.vim
    git_clone $github/junegunn/vim-easy-align.git $cui/start/vim-easy-align
    git_clone $github/kana/vim-submode.git $cui/start/vim-submode
    git_clone $github/cocopon/vaffle.vim $cui/start/vaffle.vim
    git_clone $github/tyru/open-browser.vim $cui/start/open-browser.vim
    git_clone $github/mmktomato/open-backlog-issue.vim $cui/start/open-backlog-issue.vim
    git_clone $github/thinca/vim-themis $cui/start/vim-themis
}
fetch_vim_plugins

