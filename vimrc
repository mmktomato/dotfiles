set encoding=utf-8
scriptencoding utf-8

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
endif

set packpath^=~/vimfiles
filetype plugin indent on

""" vim-geeknote
let g:GeeknoteFormat = "markdown"
let g:GeeknoteScratchDirectory = $HOME . '/vimfiles/tmp'
autocmd FileType geeknote setlocal nonumber
"""""""""""""""""""""""""""""

""" ctrlp
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_lazy_update = 1
let g:ctrlp_prompt_mappings = {
    \ 'PrtBS()': ['<c-h>', '<bs>'],
    \ 'PrtCurLeft()': ['<left>'],
    \ }
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|__pycache__)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
"""""""""""""""""""""""""""""

syntax on
set list
set listchars=tab:»\ ,eol:$,trail:_,extends:>,precedes:<

autocmd QuickFixCmdPost *grep* cwindow

let mapleader="\<Space>"
noremap j gj
noremap k gk
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>
nnoremap qn :cnext<CR>
nnoremap qp :cprevious<CR>

if has('unix') && !has('mac')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

if has('win32') && has('directx')
    set renderoptions=type:directx
endif

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0 " same as tabstop

augroup fileTypeIndent
    autocmd!
    autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 softtabstop=0
augroup END

set foldmethod=indent
set foldcolumn=2

set number
set ignorecase
set wrapscan
set hlsearch
set incsearch
set laststatus=2
set statusline=\ %f%m%r%h%w%=\ %Y\ %{&ff}\ %{&fenc}\ [%l/%L][%c][%02.2B]

" swap file (.swp)
set directory=~/vimfiles/tmp

" backup file (~)
set backupdir=~/vimfiles/tmp

" viminfo file (.viminfo)
set viminfo+=n~/vimfiles/tmp/viminfo.txt

" undo file (.un~)
set undodir=~/vimfiles/tmp/

