if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'Shougo/neocomplete.vim'
Plug 'tomasr/molokai'
Plug 'fatih/vim-go'
Plug 'udalov/kotlin-vim'
Plug 'tpope/vim-fugitive'
Plug 'kchmck/vim-coffee-script'
call plug#end()

" Basics
set backspace=indent,eol,start
set directory=~/tmp,/var/tmp,/tmp
set hlsearch
set ruler
set whichwrap=b,s,h,l,<,>,~,[,]

" Indents
set shiftwidth=4
set tabstop=4

" neocomplete.vim
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1

" molokai
colorscheme molokai

" vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
