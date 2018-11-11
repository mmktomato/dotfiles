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
    git_clone $github/thinca/vim-fontzoom.git $gui/start/vim-fontzoom
    git_clone $github/ctrlpvim/ctrlp.vim.git $cui/start/ctrlp.vim
    git_clone $github/junegunn/vim-easy-align.git $cui/start/vim-easy-align
    git_clone $github/PProvost/vim-ps1.git $cui/start/vim-ps1
    git_clone $github/kannokanno/previm.git $cui/start/previm
    git_clone $github/kana/vim-submode.git $cui/start/vim-submode
    git_clone $github/leafgarland/typescript-vim $cui/start/typescript-vim
    git_clone $github/prabirshrestha/async.vim $cui/start/async.vim
    git_clone $github/prabirshrestha/vim-lsp $cui/start/vim-lsp
    git_clone $github/prabirshrestha/asyncomplete.vim $cui/start/asyncomplete.vim
    git_clone $github/prabirshrestha/asyncomplete-lsp.vim $cui/start/asyncomplete-lsp.vim
    git_clone $github/peitalin/vim-jsx-typescript $cui/start/vim-jsx-typescript
    git_clone $github/cocopon/vaffle.vim $cui/start/vaffle.vim
    git_clone $github/sourcegraph/go-langserver $cui/start/go-langserver
}
fetch_vim_plugins

