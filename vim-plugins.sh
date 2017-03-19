#/bin/sh

function fetch_vim_plugins() {
    local github=https://github.com
    local gui=~/.vim/pack/gui
    local cui=~/.vim/pack/cui

    mkdir -p $gui/start
    mkdir -p $gui/opt
    mkdir -p $cui/start
    mkdir -p $cui/opt

    git clone $github/vim-scripts/Zenburn.git $gui/start/Zenburn
    git clone $github/thinca/vim-fontzoom.git $gui/start/vim-fontzoom
    git clone $github/ctrlpvim/ctrlp.vim.git $cui/start/ctrlp.vim
}
fetch_vim_plugins

