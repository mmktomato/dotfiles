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

function! s:disableIme()
    if has('mac')
        if executable('swim')
            call job_start(['swim', 'use', 'com.apple.keylayout.US'],
                        \ {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
        else
            call job_start(['osascript', '-e', 'tell application "System Events" to key code {102}'],
                        \ {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
        endif
    elseif s:isWsl() && executable('AutoHotkeyU64.exe') && filereadable('/mnt/c/tool/ImDisable.ahk')
        call job_start('AutoHotkeyU64.exe "C:\tool\ImDisable.ahk"',
                    \ {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
    endif
endfunction

""" ctrlp
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_lazy_update = 1
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_prompt_mappings = {
    \ 'PrtBS()': ['<c-h>', '<bs>'],
    \ 'PrtCurLeft()': ['<left>'],
    \ }
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|__pycache__|node_modules|vendor|bin|dist|build)$',
    \ 'file': '\v\.(exe|so|dll|jar|class)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
"""""""""""""""""""""""""""""

syntax on
set list
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

imap <Nul> <C-Space>

let mapleader="\<Space>"
noremap j gj
noremap k gk
inoremap <silent> jj <ESC>
inoremap <silent> っj <C-o>:call <SID>disableIme()<CR><ESC>
nnoremap <Leader><Leader> za
noremap x "_x
noremap s "_s
nnoremap t gt
nnoremap T gT
set termwinkey=<C-l>
tnoremap <C-j> <C-l>N

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
set nocursorline

augroup colorScheme
    autocmd!
    autocmd ColorScheme * highlight SpecialKey
        \ cterm=bold
        \ ctermfg=34
        \ guifg=green
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
    autocmd ColorScheme * highlight Terminal
        \ ctermbg=16
        \ guibg=black
    autocmd ColorScheme * highlight Visual
        \ ctermbg=85
    autocmd InsertEnter,InsertLeave * set cursorline!
augroup END
colorscheme zenburn

" Folding
function! MyFoldText()
    let linecount = v:foldend - v:foldstart + 1
    let indent = repeat(' ', v:foldlevel * shiftwidth())
    return indent . '\__  (' . linecount . ' lines)  '
endfunction
set foldtext=MyFoldText()
set foldmethod=indent

" Markdown folding
function! MarkdownFoldLevel(lnum)
    let line = getline(a:lnum)

    " Lines starting with '#': level = (number of # - 1)
    if line =~ '^#'
        let level = len(matchstr(line, '^#\+'))
        return '>' . (level - 1)
    endif

    " Indented lines: base level + indent level
    if line =~ '^\s\+\S'
        let indent = indent(a:lnum)
        let sw = shiftwidth()
        let indent_level = indent / sw

        " Search for the previous '#' heading
        let lnum = a:lnum - 1
        while lnum > 0
            let l = getline(lnum)
            if l =~ '^#'
                let base_level = len(matchstr(l, '^#\+'))
                return base_level + indent_level
            endif
            let lnum -= 1
        endwhile

        " If no heading found, use indent level only
        return indent_level
    endif

    " Normal lines: use the number of '#' from the previous heading as the level
    let lnum = a:lnum - 1
    while lnum > 0
        let l = getline(lnum)
        if l =~ '^#'
            let base_level = len(matchstr(l, '^#\+'))
            return base_level
        endif
        let lnum -= 1
    endwhile

    " If no heading found, level is 0
    return 0
endfunction

augroup markdown
    autocmd!
    autocmd FileType markdown setlocal foldmethod=expr
    autocmd FileType markdown setlocal foldexpr=MarkdownFoldLevel(v:lnum)
augroup END

set number
set ignorecase
set wrapscan
set hlsearch
set incsearch
set laststatus=2
set statusline=\ %f%m%r%h%w%=\ %Y\ %{&ff}\ %{&fenc}\ [%l/%L][%c][%02.2B]

" open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" open-backlog-issue.vim
let g:open_backlog_issue_prefix = $BACKLOG_PREFIX
nmap gbx <Plug>(open-backlog-issue)

" swap file (.swp)
set directory=~/vimfiles/tmp

" backup file (~)
set backupdir=~/vimfiles/tmp

" viminfo file (.viminfo)
set viminfo+=n~/vimfiles/tmp/viminfo.txt

" undo file (.un~)
set undodir=~/vimfiles/tmp/
