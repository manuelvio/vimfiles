filetype off

call pathogen#infect()

runtime! initializers/*

set nocompatible
:colorscheme zenburn
set guifont=Ubuntu\ Mono\ 9
let mapleader=","
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set nobackup
set noswapfile
set title

set encoding=utf-8
set hidden
" Set the status line the way i like it
set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B] 

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

set visualbell                  " don't beep
set noerrorbells                " don't beep
:set vb t_vb=
autocmd VimEnter * set vb t_vb= 

:set ts=4
:set nolist
set wildignore+=*.class,.git,.hg,.svn,target/**
" Mappatura per switch buffer
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
filetype plugin indent on

" nmap <silent> <leader>xx  :w!<CR>ggdG|:r!tidy -quiet -xml -indent --indent-spaces 4 --wrap 90 % <CR>ggdd:w!<CR>
" nmap <silent> <leader>xc :cex system('tidy -errors -xml -indent --indent-spaces 4 --wrap 90 ' . expand("%"))<CR>
set shiftwidth=4  " number of spaces to use for autoindenting

inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1
