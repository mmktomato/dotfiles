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
NeoBundle 'neilagabriel/vim-geeknote'
 
call neobundle#end()
 
filetype plugin indent on
 
NeoBundleCheck
"""""""""""""""""""""""""""""

""" vim-geeknote
let g:GeeknoteFormat = "markdown"
let g:GeeknoteScratchDirectory = $HOME . '/.vim/tmp'
autocmd FileType geeknote setlocal nonumber
"""""""""""""""""""""""""""""

noremap j gj
noremap k gk
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>
colorscheme zenburn
set clipboard+=unnamed
set number
syntax on
set wrapscan
set laststatus=2
set statusline=\ %f%m%r%h%w%=\ %Y\ %{&ff}\ %{&fenc}\ [%l/%L][%c][%02.2B]

" swap file (.swp)
set directory=~/.vim/tmp

" backup file (~)
set backupdir=~/.vim/tmp

" viminfo file (.viminfo)
set viminfo+=n~/.vim/tmp/viminfo.txt

" undo file (.un~)
set undodir=~/.vim/tmp/

