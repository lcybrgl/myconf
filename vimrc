set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'flazz/vim-colorschemes'
Plugin 'rhysd/vim-color-spring-night'
call vundle#end()

set t_Co=256
set background=light

"colorscheme termschool
colorscheme PaperColor
syntax on
filetype indent on
filetype plugin on
let mapleader = "'"
let g:mapleader = "'"

""""""""""""""""""""""""""""""""
" Set some mappings here
""""""""""""""""""""""""""""""""

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Useful mappings for managing tabs
map <leader>nt :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>tt :tabnext<cr>
map <leader>tT :tabprev<cr>
map <leader>a :NERDTree<cr>
map <leader>ff :bdelete!<cr>
map <leader>bb :bnext!<cr>
map <leader>bB :bprev!<cr>

" Russian input support
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
highlight NonText ctermbg=none
""""
set autoread
set wildmenu
set showcmd
set laststatus=2
set confirm
set visualbell
set mouse=a
set cmdheight=2
set number
set ruler
set notimeout ttimeout ttimeoutlen=200
set shiftwidth=4
set softtabstop=4
set expandtab
set showmatch
set encoding=utf8

" Add a bit extra margin to the left
set foldcolumn=1

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
set nowritebackup
set viminfo=

let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

if &term =~ '256color'
" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

au VimLeave * :!clear
