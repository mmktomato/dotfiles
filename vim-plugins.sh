#!/bin/sh

function fetch_vim_plugins() {
    local github=https://github.com
    local gui=~/vimfiles/pack/gui
    local cui=~/vimfiles/pack/cui

    mkdir -p $gui/start
    mkdir -p $gui/opt
    mkdir -p $cui/start
    mkdir -p $cui/opt

    git clone $github/vim-scripts/Zenburn.git $gui/start/Zenburn
    git clone $github/thinca/vim-fontzoom.git $gui/start/vim-fontzoom
    git clone $github/ctrlpvim/ctrlp.vim.git $cui/start/ctrlp.vim
    git clone $github/junegunn/vim-easy-align.git $cui/start/vim-easy-align
    git clone $github/PProvost/vim-ps1.git $cui/start/vim-ps1
    git clone $github/kannokanno/previm.git $cui/start/previm
    git clone $github/kana/vim-submode.git $cui/start/vim-submode
    git clone $github/leafgarland/typescript-vim $cui/start/typescript-vim
    git clone $github/prabirshrestha/async.vim $cui/start/async.vim
    git clone $github/prabirshrestha/vim-lsp $cui/start/vim-lsp
    git clone $github/prabirshrestha/asyncomplete.vim $cui/start/asyncomplete.vim
    git clone $github/prabirshrestha/asyncomplete-lsp.vim $cui/start/asyncomplete-lsp.vim
}
fetch_vim_plugins

