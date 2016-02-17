""" NeoBundle
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
 
call neobundle#begin(expand('~/.vim/bundle'))
 
" NeoBundleのバージョンをNeoBundle自身で管理する
NeoBundleFetch 'Shougo/neobundle.vim'
 
NeoBundle 'vim-scripts/Zenburn'
 
call neobundle#end()
 
filetype plugin indent on
 
NeoBundleCheck
"""""""""""""""""""""""""""""

colorscheme zenburn
set clipboard+=unnamed
set number
syntax on
set wrapscan
set laststatus=2

" swap file (.swp)
set directory=~/.vim/tmp

" backup file (~)
set backupdir=~/.vim/tmp

" viminfo file (.viminfo)
set viminfo+=n~/.vim/tmp/viminfo.txt

" undo file (.un~)
set undodir=~/.vim/tmp/

