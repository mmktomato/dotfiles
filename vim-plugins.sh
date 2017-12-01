#/bin/sh

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
}
fetch_vim_plugins

