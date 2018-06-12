call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'bronson/vim-trailing-whitespace'
call plug#end()
syntax enable
"colorscheme PaperColor
colorscheme OceanicNext
set background=dark
"""" Misc
"set backspace=indent,eol,start
set clipboard=unnamed
"""" Leader Shortcuts
let mapleader="'"
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
noremap bl :bnext!<cr>
noremap bh :bprev!<cr>
noremap <leader>b :bdelete!<cr>
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>
nmap <leader>a :NERDTree<cr>
nmap <leader>r :NERDTreeClose<cr>
map <leader>s :source ~/.config/nvim/init.vim<CR>
" Russian input support
"set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
highlight NonText ctermbg=none
"""" Spaces & Tabs
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
set modelines=1
filetype indent on
filetype plugin on
set autoindent
set list listchars=tab:»·,trail:· " show extra space characters
""""
set t_Co=256
set autoread
set shortmess=I
set wildmenu
set showcmd
set relativenumber
set laststatus=2
set confirm
set visualbell
set mouse=a
set cmdheight=2
set number
set ruler
set notimeout ttimeout ttimeoutlen=200
set showmatch
set encoding=utf8
" Add a bit extra margin to the left
set foldcolumn=1
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
""" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
set nowritebackup
set viminfo=
""" Airline config
"let g:airline_theme='papercolor'
let g:airline_theme='cool'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

au VimLeave * :!clear
