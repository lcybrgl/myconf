set nocompatible
filetype off
set rtp+=~/.vim/bundle/vim-colorschemes
set rtp+=~/.vim/bundle/awesome-vim-colorschemes
set rtp+=~/.vim/bundle/vim-airline
set rtp+=~/.vim/bundle/vim-airline-themes
set rtp+=~/.vim/bundle/nerdtree
set rtp+=~/.vim/bundle/vim-surround
set rtp+=~/.vim/bundle/vim-repeat
set rtp+=~/.vim/bundle/vim-trailing-whitespace
syntax enable
colorscheme PaperColor
set background=light
"""" Misc
"set backspace=indent,eol,start
set clipboard=unnamed
"""" Leader Shortcuts
let mapleader="'"
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"""" Some mappings
nmap bl :bnext!<cr>
nmap bh :bprev!<cr>
nmap <leader>b :bdelete!<cr>
nmap <leader>nn :e ~/.vimrc<cr>
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>
nmap <leader>a :NERDTree<cr>
map <leader>s :source ~/.vimrc<CR>
" Russian input support
set keymap=russian-jcukenwin
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
"set autoindent
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
let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"nnoremap W :execute ':silent w !sudo tee % > /dev/null' | :edit!

if &term =~ '256color'
" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

au VimLeave * :!clear
