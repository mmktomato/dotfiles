@echo off
setlocal

cd /d %~dp0
cd ..

set github=https://github.com
set gui=vimfiles\pack\gui
set cui=vimfiles\pack\cui

mkdir %gui%\start
mkdir %gui%\opt
mkdir %cui%\start
mkdir %cui%\opt

git clone %github%/vim-scripts/Zenburn.git %gui%\start\Zenburn
git clone %github%/thinca/vim-fontzoom.git %gui%\start\vim-fontzoom
git clone %github%/ctrlpvim/ctrlp.vim.git %cui%\start\ctrlp.vim
git clone %github%/junegunn/vim-easy-align.git %cui%\start\vim-easy-align
git clone %github%/PProvost/vim-ps1.git %cui%\start\vim-ps1
git clone %github%/kannokanno/previm.git %cui%\start\previm
git clone %github%/kana/vim-submode.git %cui%\start\vim-submode
git clone %github%/leafgarland/typescript-vim %cui%\start\typescript-vim

endlocal

