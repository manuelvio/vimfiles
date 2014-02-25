        " put this line first in ~/.vimrc
        set nocompatible | filetype indent plugin on | syn on

        fun! EnsureVamIsOnDisk(vam_install_path)
          " windows users may want to use http://mawercer.de/~marc/vam/index.php
          " to fetch VAM, VAM-known-repositories and the listed plugins
          " without having to install curl, 7-zip and git tools first
          " -> BUG [4] (git-less installation)
          let is_installed_c = "isdirectory(a:vam_install_path.'/vim-addon-manager/autoload')"
          if eval(is_installed_c)
            return 1
          else
            if 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
              " I'm sorry having to add this reminder. Eventually it'll pay off.
              call confirm("Remind yourself that most plugins ship with ".
                          \"documentation (README*, doc/*.txt). It is your ".
                          \"first source of knowledge. If you can't find ".
                          \"the info you're looking for in reasonable ".
                          \"time ask maintainers to improve documentation")
              call mkdir(a:vam_install_path, 'p')
              execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
              " VAM runs helptags automatically when you install or update 
              " plugins
              exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
            endif
            return eval(is_installed_c)
          endif
        endfun

        fun! SetupVAM()
          " Set advanced options like this:
          " let g:vim_addon_manager = {}
          " let g:vim_addon_manager['key'] = value
          "     Pipe all output into a buffer which gets written to disk
          " let g:vim_addon_manager['log_to_buf'] =1

          " Example: drop git sources unless git is in PATH. Same plugins can
          " be installed from www.vim.org. Lookup MergeSources to get more control
          " let g:vim_addon_manager['drop_git_sources'] = !executable('git')
          " let g:vim_addon_manager.debug_activation = 1

          " VAM install location:
          let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
          if !EnsureVamIsOnDisk(vam_install_path)
            echohl ErrorMsg | echomsg "No VAM found!" | echohl NONE
            return
          endif
          exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

          " Tell VAM which plugins to fetch & load:
          call vam#ActivateAddons(['Colour_Sampler_Pack','github:scrooloose/nerdtree','AutoClose%2009','vim-addon-mw-utils','github:scrooloose/nerdcommenter','fugitive'], {'auto_install' : -3})
          call vam#ActivateAddons(['camelcasemotion'], {'auto_install' : -1})
          call vam#ActivateAddons(['github:jlanzarotta/bufexplorer'], {'auto_install' : -1})
          call vam#ActivateAddons(['css_color'], {'auto_install' : -1})
          call vam#ActivateAddons(['endwise'], {'auto_install' : -1})
          call vam#ActivateAddons(['Gundo'], {'auto_install' : -1})
          call vam#ActivateAddons(['matchit.zip'], {'auto_install' : -2})
          call vam#ActivateAddons(['ragtag'], {'auto_install' : -2})
          " call vam#ActivateAddons(['replace'], {'auto_install' : -2})
          call vam#ActivateAddons(['surround'], {'auto_install' : -2})
          call vam#ActivateAddons(['taglist-plus'], {'auto_install' : -3})
          call vam#ActivateAddons(['Textile_for_VIM'], {'auto_install' : -3})
          call vam#ActivateAddons(['vim-less'], {'auto_install' : -3})
          call vam#ActivateAddons(['github:scrooloose/syntastic'], {'auto_install' : -3})
          call vam#ActivateAddons(['ctrlp'], {'auto_install' : -3})
          call vam#ActivateAddons(['neocomplcache'], {'auto_install' : -3})
          "call vam#ActivateAddons(['snipmate'], {'auto_install' : -3})
          call vam#ActivateAddons(['vim-snippets'], {'auto_install' : -3})
          call vam#ActivateAddons(['github:aaronbieber/quicktask.git'], {'auto_install' : -4})
          call vam#ActivateAddons(['VimOutliner'], {'auto_install' : -3})
          call vam#ActivateAddons(['github:dagwieers/asciidoc-vim'], {'auto_install' : -6})
          "call vam#ActivateAddons(['powerline'])
          call vam#ActivateAddons(['EasyGrep'], {'auto_install' : -6})
          "call vam#ActivateAddons(['vim-gitgutter'])
          call vam#ActivateAddons(['github:bling/vim-airline'], {'auto_install' : -6})
          call vam#ActivateAddons(['breeze'], {'auto_install' : -6})
          call vam#ActivateAddons(['WebAPI'], {'auto_install' : -6})
          call vam#ActivateAddons(['Gist'], {'auto_install' : -6})
          
          call vam#ActivateAddons(['neosnippet'] , { 'auto_install' : -6 })
          call vam#ActivateAddons(['github:Shougo/neosnippet-snippets'], { 'auto_install' : -6 })
          
          call vam#ActivateAddons(['github:xolox/vim-misc'], { 'auto_install' : -6 })
          call vam#ActivateAddons(['github:xolox/vim-notes'], {'auto_install' : -6})
          call vam#ActivateAddons(['Solarized'], {'auto_install' : -6})
          " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})

          " Addons are put into vam_install_path/plugin-name directory
          " unless those directories exist. Then they are activated.
          " Activating means adding addon dirs to rtp and do some additional
          " magic

          " How to find addon names?
          " - look up source from pool
          " - (<c-x><c-p> complete plugin names):
          " You can use name rewritings to point to sources:
          "    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
          "    ..ActivateAddons(["github:user/repo", .. => github://user/repo
          " Also see section "2.2. names of addons and addon sources" in VAM's documentation
        endfun
        call SetupVAM()
        " experimental [E1]: load plugins lazily depending on filetype, See
        " NOTES
        " experimental [E2]: run after gui has been started (gvim) [3]
        " option1:  au VimEnter * call SetupVAM()
        " option2:  au GUIEnter * call SetupVAM()
        " See BUGS sections below [*]
        " Vim 7.0 users see BUGS section [3]


runtime! initializers/*

set nocompatible

set background=dark
":colorscheme solarized
:colorscheme zenburn

set guifont=Ubuntu\ Mono\ 9
let mapleader=","
" Quickly edit/reload the vimrc file



nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


"nmap <leader>,xx :w!<CR>ggdG|:r!tidy -quiet -xml -indent --indent-spaces 4 --wrap 90 % <CR>ggdd:w!<CR>
"nmap <leader>,xc :cex system('tidy -errors -xml -indent --indent-spaces 4 --wrap 90 ' . expand("%"))<CR>

"map <F12> :%!tidy -q --tidy-mark 0 2>/dev/null<CR>
map <F12> :w!<CR>ggdG<CR>:%!tidy -quiet -xml -indent --indent-spaces 4 --wrap 90 % 

"|:%!tidy -quiet -xml -indent --indent-spaces 4 --wrap 90 % <CR>ggdd:w!<CR>

set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set noexpandtab
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

nmap <silent> <leader>t :noautocmd vimgrep /TODO/j **/*<CR>:cw<CR>

:set spl=it
" :set spell
syntax on

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vmap <leader>z <Esc>:%s/<c-r>=GetVisual()<cr>/


nmap <silent> <A-5> :BreezeMatchTag<CR>

let g:EasyGrepFileAssociations='/home/manuel/vimfiles/vim-addons/EasyGrep/plugin/EasyGrepFileAssociations'
let g:EasyGrepMode=0
let g:EasyGrepCommand=1
let g:EasyGrepRecursive=1
let g:EasyGrepSearchCurrentBufferDir=0
let g:EasyGrepIgnoreCase=0
let g:EasyGrepHidden=0
let g:EasyGrepFilesToExclude=''
let g:EasyGrepAllOptionsInExplorer=1
let g:EasyGrepWindow=0
let g:EasyGrepReplaceWindowMode=2
let g:EasyGrepOpenWindowOnMatch=1
let g:EasyGrepEveryMatch=0
let g:EasyGrepJumpToMatch=1
let g:EasyGrepInvertWholeWord=0
let g:EasyGrepFileAssociationsInExplorer=0
let g:EasyGrepExtraWarnings=1
let g:EasyGrepOptionPrefix='<leader>vy'
let g:EasyGrepReplaceAllPerFile=0

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

let g:airline_theme='zenburn'

au BufRead,BufNewFile *.gsp set ft=jsp
"let g:syntastic_jsp_checkers=['tidy']


let g:syntastic_filetype_map = { 'latex': 'tex', 'gsp': 'hxtml', 'gentoo-metadata': 'xml' }
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0 " don't check on :wq and :x
let g:syntastic_enable_signs = 1 " errors on left side
let g:syntastic_auto_loc_list = 2 " only show window when I ask
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_no_include_search = 1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jshint_conf = '$HOME/.jshintrc'
let g:syntastic_html_jshint_conf = '$HOME/.jshintrc'
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
if has('unix')
	let g:syntastic_error_symbol = '★'
	let g:syntastic_style_error_symbol = '>'
	let g:syntastic_warning_symbol = '⚠'
	let g:syntastic_style_warning_symbol = '>'
else
	let g:syntastic_error_symbol = '!'
	let g:syntastic_style_error_symbol = '>'
	let g:syntastic_warning_symbol = '.'
	let g:syntastic_style_warning_symbol = '>'
endif

if version >= 702
	if has('gui_running')
		let g:indent_guides_enable_on_vim_startup = 1
		let g:indent_guides_start_level = 2
		let g:indent_guides_guide_size = 1
	endif
endif

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

nnoremap <silent> <Leader>df :call DiffToggle()<CR>

function! DiffToggle()
    if &diff
        diffoff
    else
        diffthis
    endif
:endfunction

:let g:notes_directories = ['~/.vim/misc/notes/user']

nnoremap    <F2> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>
