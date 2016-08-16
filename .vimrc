" Vundle Settings
set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'Shougo/vinarise.vim'
Plugin 'lambdalisue/vim-manpager'

call vundle#end()
filetype plugin on

" Color Settings
set t_Co=256
set background=dark
colorscheme CandyPaper
syntax enable

" Space & Tab Settings
set tabstop=2
set softtabstop=2
set expandtab

" UI Settings
set number
set showcmd
set cursorline
filetype indent on
set wildmenu
set lazyredraw
set showmatch
set ruler

" allow cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Search Settings
set incsearch
set hlsearch

