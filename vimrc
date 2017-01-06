set encoding=utf-8
scriptencoding utf-8

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
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'thinca/vim-fontzoom'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'OmniSharp/omnisharp-vim'
"
call neobundle#end()

filetype plugin indent on

NeoBundleCheck
"""""""""""""""""""""""""""""

""" vim-geeknote
let g:GeeknoteFormat = "markdown"
let g:GeeknoteScratchDirectory = $HOME . '/.vim/tmp'
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

""" OmniSharp
let g:Omnisharp_start_server = 0
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
autocmd FileType cs nnoremap <leader>gd :OmniSharpGotoDefinition<cr>
autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>

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

set number
set ignorecase
set wrapscan
set hlsearch
set incsearch
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

