set encoding=utf-8
scriptencoding utf-8

if has('vim_starting')
    if &compatible
        set nocompatible
    endif
endif

set packpath^=~/vimfiles
filetype plugin indent on

function! s:isWsl()
    return filereadable('/proc/sys/fs/binfmt_misc/WSLInterop')
endfunction

""" vim-geeknote
"let g:GeeknoteFormat = "markdown"
"let g:GeeknoteScratchDirectory = $HOME . '/vimfiles/tmp'
"autocmd FileType geeknote setlocal nonumber
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
    \ 'dir':  '\v[\/](\.(git|hg|svn)|__pycache__|node_modules|vendor)$',
    \ 'file': '\v\.(exe|so|dll|jar|class)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
"""""""""""""""""""""""""""""

""" previm
let g:previm_open_cmd = 'open -a firefox' " TODO: linux and windows.
"""""""""""""""""""""""""""""

syntax on
set list
"set listchars=tab:»\ ,eol:$,trail:_,extends:>,precedes:<
set listchars=tab:»\ ,trail:_,extends:>,precedes:<
set backspace=indent,eol,start

""" QuickFix
augroup quickFix
    autocmd!
    autocmd QuickFixCmdPost *grep* cwindow
augroup END
:packadd! vim-submode
let g:submode_timeoutlen = 30000
call submode#enter_with('quickfix', 'n', '', 'qj', ':cnext<CR>')
call submode#enter_with('quickfix', 'n', '', 'qk', ':cprevious<CR>')
call submode#map('quickfix', 'n', '', 'j', ':cnext<CR>')
call submode#map('quickfix', 'n', '', 'k', ':cprevious<CR>')

let mapleader="\<Space>"
noremap j gj
noremap k gk
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>
nnoremap <Leader><Leader> za
noremap x "_x
noremap s "_s
nnoremap t gt
nnoremap T gT

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
    autocmd FileType xml,ruby,eruby setlocal tabstop=2 shiftwidth=2 softtabstop=0
augroup END

function! MyFoldText()
    let linecount = v:foldend - v:foldstart + 1
    let indent = repeat(' ', v:foldlevel * shiftwidth())
    return indent . '\__  (' . linecount . ' lines)  '
endfunction
set foldtext=MyFoldText()
set foldmethod=indent
set foldcolumn=2
set nocursorline

augroup colorScheme
    autocmd!
    autocmd ColorScheme * highlight SpecialKey
        \ cterm=bold
        \ ctermfg=227
        \ guifg=yellow
        \ ctermbg=NONE
        \ guibg=NONE
    autocmd ColorScheme * highlight Search
        \ ctermfg=21
        \ guifg=blue
        \ ctermbg=230
        \ guibg=lightyellow
    autocmd ColorScheme * highlight IncSearch
        \ ctermfg=127
        \ guifg=darkmagenta
    "autocmd ColorScheme * highlight CursorLine
    "    \ cterm=None
    "    \ ctermbg=236
    "autocmd ColorScheme * highlight CursorLineNr
    "    \ term=bold
    "    \ ctermfg=227
    autocmd ColorScheme * highlight Terminal
        \ ctermbg=16
        \ guibg=black
    autocmd InsertEnter,InsertLeave * set cursorline!
augroup END
colorscheme zenburn

set number
set ignorecase
set wrapscan
set hlsearch
set incsearch
set laststatus=2
set statusline=\ %f%m%r%h%w%=\ %Y\ %{&ff}\ %{&fenc}\ [%l/%L][%c][%02.2B]

if has('mac') && executable('swim')
    augroup insertLeave
        autocmd!
        autocmd InsertLeave * :call system('swim use com.apple.keyboardlayout.all')
    augroup END
elseif s:isWsl() && executable('AutoHotkeyU64.exe')
    augroup insertLeave
        autocmd!
        " TODO:
        "   Replace 'AutoHotkeyU64.exe "C:\tool\ImDisable.ahk"' to
        "   'AutoHotkeyU64.exe `wslpath -m "~/dotfiles/ImDisable.ahk"`'
        "   if `wslpath` command is available.
        autocmd InsertLeave * :call system('AutoHotkeyU64.exe "C:\tool\ImDisable.ahk"')
    augroup END
endif

" TypeScript
if executable('typescript-language-server')
    augroup lsp_setup
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'typescript-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
            \ 'whitelist': ['typescript', 'typescript.jsx'],
            \ })
    augroup END
endif
let g:lsp_async_completion = 1
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/vim-lsp.log')
let g:asyncomplete_auto_popup = 0
augroup Typescript
    autocmd!
    autocmd FileType typescript setlocal omnifunc=lsp#complete
    autocmd FileType typescript setlocal tabstop=2 shiftwidth=2 softtabstop=0
    autocmd FileType typescript.jsx setlocal tabstop=2 shiftwidth=2 softtabstop=0
    autocmd FileType typescript.jsx highlight xmlTagName
        \ guifg=#59ACE5
        \ ctermfg=39
    autocmd FileType typescript.jsx highlight xmlTag
        \ guifg=#59ACE5
        \ ctermfg=39
    autocmd FileType typescript.jsx highlight xmlEndTag
        \ guifg=#2974a1
        \ ctermfg=26
    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx
augroup END
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
imap <C-space> <Plug>(asyncomplete_force_refresh)

" swap file (.swp)
set directory=~/vimfiles/tmp

" backup file (~)
set backupdir=~/vimfiles/tmp

" viminfo file (.viminfo)
set viminfo+=n~/vimfiles/tmp/viminfo.txt

" undo file (.un~)
set undodir=~/vimfiles/tmp/

