autocmd ColorScheme * highlight SpecialKey guibg=NONE guifg=yellow
autocmd ColorScheme * highlight Search guibg=lightyellow guifg=blue
autocmd ColorScheme * highlight IncSearch guifg=darkmagenta
colorscheme zenburn

set guioptions-=m
set guioptions-=T

" Font
if filereadable(expand('~/dotfiles/font.vim'))
	source ~/dotfiles/font.vim
endif
