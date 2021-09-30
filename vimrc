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

""" previm
let g:previm_open_cmd = 'open -a firefox' " TODO: linux and windows.
"""""""""""""""""""""""""""""

""" preview-markdown
let g:preview_markdown_auto_update = 1
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

augroup fileTypeIndent
    autocmd!
    autocmd FileType xml,ruby,eruby,yaml,scss setlocal tabstop=2 shiftwidth=2 softtabstop=0
augroup END

function! MyFoldText()
    let linecount = v:foldend - v:foldstart + 1
    let indent = repeat(' ', v:foldlevel * shiftwidth())
    return indent . '\__  (' . linecount . ' lines)  '
endfunction
set foldtext=MyFoldText()
set foldmethod=indent
"set foldcolumn=2
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

" LSP
let g:lsp_async_completion = 1
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/vim-lsp.log')
let g:asyncomplete_auto_popup = 0

" open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" open-backlog-issue
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:open_backlog_issue_prefix = $BACKLOG_PREFIX

function! s:find_backlog_issue_key(line, caret_pos) abort
    let search_pos = 0

    while -1 < search_pos
        let [issue_key, start, end] = matchstrpos(a:line, '\C[A-Z_]\+-[0-9]\+', search_pos)

        if start <= a:caret_pos && a:caret_pos <= (end - 1)
            return issue_key
        endif

        let search_pos = end
    endwhile

    return ''
endfunction

function! s:warn(msg) abort
    execute 'echohl' 'WarningMsg'
    try
        echomsg a:msg
    finally
        echohl None
    endtry
endfunction

" function! s:open_backlog_issue() abort
function! OpenBacklogIssue() abort
    if g:open_backlog_issue_prefix == ''
        call s:warn('g:open_backlog_issue_prefix is not set')
        return
    endif

    let issue_key = s:find_backlog_issue_key(getline('.'), col('.') - 1)

    if issue_key != ''
        let url = g:open_backlog_issue_prefix . '/view/' . issue_key
        call openbrowser#open(url)
    endif
endfunction

" command! OpenBacklogIssue :call s:open_backlog_issue()
" nnoremap <silent> <Plug>(open-backlog-issue) :call s:open_backlog_issue()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" nmap gbx <Plug>(open-backlog-issue)
nnoremap gbx :call OpenBacklogIssue()<CR>

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
imap <C-space> <Plug>(asyncomplete_force_refresh)

augroup LSP
    autocmd!
    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

augroup lsp_setup
    autocmd!

    " TypeScript
    if executable('typescript-language-server')
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'typescript',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
            \ 'allowlist': ['typescript', 'typescript.tsx'],
            \ })
    endif

    " Go
    if executable('gopls')
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'golang',
            \ 'cmd': {server_info->['gopls']},
            \ 'allowlist': ['go'],
            \ })
    endif
augroup END

" Javascript
augroup Javascript
    autocmd!
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=0
augroup END

" TypeScript
augroup Typescript
    autocmd!
    autocmd FileType typescript setlocal omnifunc=lsp#complete
    autocmd FileType typescript setlocal tabstop=2 shiftwidth=2 softtabstop=0
    autocmd FileType typescript.tsx setlocal tabstop=2 shiftwidth=2 softtabstop=0
    autocmd FileType typescript.tsx highlight xmlTagName
        \ guifg=#59ACE5
        \ ctermfg=39
    autocmd FileType typescript.tsx highlight xmlTag
        \ guifg=#59ACE5
        \ ctermfg=39
    autocmd FileType typescript.tsx highlight xmlEndTag
        \ guifg=#2974a1
        \ ctermfg=26
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
augroup END

" Go
augroup Go
    autocmd!
    autocmd FileType go setlocal noexpandtab
augroup END

" swap file (.swp)
set directory=~/vimfiles/tmp

" backup file (~)
set backupdir=~/vimfiles/tmp

" viminfo file (.viminfo)
set viminfo+=n~/vimfiles/tmp/viminfo.txt

" undo file (.un~)
set undodir=~/vimfiles/tmp/

