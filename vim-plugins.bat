@echo off
setlocal

cd /d %~dp0
cd ..

set github=https://github.com
set gui=.vim\pack\gui
set cui=.vim\pack\cui

mkdir %gui%\start
mkdir %gui%\opt
mkdir %cui%\start
mkdir %cui%\opt

git clone %github%/vim-scripts/Zenburn.git %gui%\start\Zenburn
git clone %github%/thinca/vim-fontzoom.git %gui%\start\vim-fontzoom
git clone %github%/ctrlpvim/ctrlp.vim.git %cui%\start\ctrlp.vim

endlocal

