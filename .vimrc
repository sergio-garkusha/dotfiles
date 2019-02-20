" General
set fileformats=unix,dos
set ruler
set hlsearch
set laststatus=2

set nocompatible " Enter the current Millenium
set softtabstop=2 " number of space chars a tab counts for
set shiftwidth=2 " number of space chars for indentation
" set expandtab " insert space characters whenever the tab key is pressed
set tabstop=2 " space chars inserted when tab key is pressed (In honor of C!)
set smarttab
set noerrorbells visualbell t_vb= " turn off bells
" set nowrap
set showmatch " set show matching parenthesis

" Indent
set autoindent
set copyindent

" Insert mode with paste
set paste

" Fuzzy Finder feature
    filetype plugin on

    set path+=** " adds $CWD to the search path
    set wildmenu " enables wildcards for completion (menus, buffers, files...)
"END

" Higlight column #n with color
set colorcolumn=80
" Show line numbers
set number
" Highlight the line with a cursor
set cursorline

" Detect encoding
set ffs=unix
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

" Python syntax highlight
let python_highlight_all = 1

" If it's macOS, adds command that fix backspace behaviour
" for the Insert Mode
if $OSTYPE =~ 'darwin'
    set backspace=indent,eol,start
endif

"Undo
set undodir=~/.vim/undo
set undofile
set undolevels=1000 " maximum number of changes that can be undone
set undoreload=10000 " maximum number lines to save for undo on a buffer reload

"Backup and *.swp
set backupdir=~/.vim/tmp,
set directory=~/.vim/tmp,

"Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"The above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

"This means that you can have unwritten changes to a file and open a new file
"using :e, without being forced to write or undo your changes first. Also,
"undo buffers and marks are preserved while the buffer is open
set hidden

"Color
syntax enable
" colorscheme solarized
set t_Co=256
" colorscheme bvemu
" colorscheme autumn
colorscheme Monokai
" colorscheme railscasts
" colorscheme bubblegum-256-dark
" colorscheme bubblegum-256-light
" colorscheme burnttoast256
" colorscheme lapis256
" colorscheme last256
" colorscheme lizard256
" colorscheme seoul256-light
" colorscheme summerfruit256
" colorscheme wasabi256
" colorscheme 256-grayvim
" colorscheme woju
" colorscheme wolfpack
" colorscheme wombat256mod
" colorscheme zenburn

highlight Cursor guibg=Green guifg=NONE

" Netrw
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

" vim-session
let g:session_autoload="yes"
let g:session_autosave="yes"
let g:session_default_to_last="yes"


"================================[ Bundler block: Plug ]=======================
" On a first launch, it autoloads Plug & installs all required plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" all about surroundings: parentheses, brackets, quotes
" Plug 'surround.vim'

" Collection of snippets
" Bundle 'snipMate'

" Comments/Uncomments line/visual block with \c
Plug 'tomtom/tcomment_vim'

" Support of .editorconfig
Plug 'editorconfig/editorconfig-vim'

" Emmet completions
Plug 'mattn/emmet-vim'

" File system explorer
Plug 'scrooloose/nerdtree'

" NERDTree panel, independent of tabs
Plug 'jistr/vim-nerdtree-tabs'

" Neat Status Line //github.com/Cu7ious/vim-neatstatus
Plug 'Cu7ious/vim-neatstatus'

" Drags selected blocks with arrow keys in VISUAL mode
Plug 'gavinbeatty/dragvisuals.vim'

" Colorschemes //github.com/flazz/vim-colorschemes
Plug 'flazz/vim-colorschemes'

" Automatic closing of quotes parenthesis brackets etc.
Plug 'Raimondi/delimitMate'

" Syntax highlighting and improved indentation of .js, .jsx & .tsx files
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" :saves <newfile> then rms old filename on disk
Plug 'wojtekmach/vim-rename'
" Opens header files automatically
Plug 'vim-scripts/a.vim'

" Error checking: shows the offending line next to the line numbers
" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'

" ----- Working with Git ----------------------------------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Man pages right in vim
" Plug 'jez/vim-superman'

" ----- Python --------------------------------------------------------
" Pep8 auto formatter
" Plugin 'tell-k/vim-autopep8'

" Initialize plugin system
call plug#end()

let b:ale_linters = {'typescript': ['tslint']}
let g:EditorConfig_core_mode = 'python_external'

"==============================[ HOTKEYS BLOCK ]===============================
" Turns off the ruler and line numbers to make it ready for copy/paste
command CPMode :call CPModeToggle()
function! CPModeToggle()
		if IsNerdTreeEnabled()
			:call C7NERDTreeTabsToggle()
		endif

    if &number
        set nonumber | set colorcolumn=0 | set cursorline!
				execute 'GitGutterToggle'
    else
        set number | set colorcolumn=80 | set cursorline
				execute 'GitGutterToggle'
    endif
endfunction

command Paste :call PasteToggle()
function! PasteToggle()
    if &paste
        set paste
    else
        set nopaste
    endif
endfunction

" Comment toggle. Requires tComment plugin
map <leader>c <c-_><c-_>

" Emmet
let g:user_emmet_settings = {
\  'javascript.jsx': {
\      'extends': 'jsx',
\      'quote_char': "'"
\  },
\}
let g:user_emmet_install_global = 0
autocmd FileType html,jsx,css EmmetInstall

" NEDRTree Tabs Toggle. Requires nerdtree & vim-nerdtree-tabs plugins
" map <leader>t :NERDTreeTabsToggle<CR>
map <leader>t :call C7NERDTreeTabsToggle()<CR>

function! C7NERDTreeTabsToggle()
	NERDTreeTabsToggle
	:call ToggleStatusLine()
endfunction

function! IsNerdTreeEnabled()
  return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction

function! ToggleStatusLine()
	if IsNerdTreeEnabled()
		set ls=0
	else
		set ls=2
	endif
endfunction

"====[ Make the 81st column stand out ]====================

    " EITHER just the 81st column of wide lines...
    " highlight ColorColumn ctermbg=magenta
    " call matchadd('ColorColumn', '\%81v', 100)


"=====[ Highlight matches when jumping to next ]=============

    " This rewires n and N to do the highlighing...
    nnoremap <silent> n   n:call HLNext(0.1)<cr>
    nnoremap <silent> N   N:call HLNext(0.1)<cr>

    " EITHER blink the line containing the match...
    function! HLNext (blinktime)
        set invcursorline
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        set invcursorline
        redraw
    endfunction


"====[ Always turn on syntax highlighting for diffs ]=========================

    " EITHER select by the file-suffix directly...
    augroup PatchDiffHighlight
        autocmd!
        autocmd BufEnter  *.patch,*.rej,*.diff   syntax enable
    augroup END

    " OR ELSE use the filetype mechanism to select automatically...
    filetype on
    augroup PatchDiffHighlight
        autocmd!
        autocmd FileType  diff   syntax enable
    augroup END


"====[ Drag Visual Blocks"]====================================================
	runtime plugin/dragvisuals.vim

	vmap  <expr>  <LEFT>   DVB_Drag('left')
	vmap  <expr>  <RIGHT>  DVB_Drag('right')
	vmap  <expr>  <DOWN>   DVB_Drag('down')
	vmap  <expr>  <UP>     DVB_Drag('up')
	vmap  <expr>  D        DVB_Duplicate()

	" Remove any introduced trailing whitespace after moving...
	let g:DVB_TrimWS = 1


"====[ Swap v and CTRL-V, because Block mode is more useful than Visual mode ]=

    nnoremap    v   <C-V>
    nnoremap <C-V>     v

    vnoremap    v   <C-V>
    vnoremap <C-V>     v

"===========================[ Syntastic Settings  ]============================
 " We need this for plugins like Syntastic and vim-gitgutter which put symbols
 " in the sign column.
"  hi clear SignColumn
"
"  " Checks file when it's open
"  let g:syntastic_check_on_open = 1
"
"  " C++
"  let g:syntastic_cpp_compiler = 'g++'
"  let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
"
"  " Python3
"  let g:syntastic_python_python_exec = '/usr/local/bin/python3'
"
"  " JavaScript
"  let g:syntastic_javascript_checkers = ['standard']
"  let g:syntastic_javascript_standard_exec = 'semistandard'
"
"  set statusline+=%#warningmsg#
"  set statusline+=%{SyntasticStatuslineFlag()}
"  set statusline+=%*
"
"  augroup mySyntastic
"    au!
"    au FileType tex let b:syntastic_mode = 'passive'
"  augroup END


"================================[ Syntastic ]=================================
" better man page support
noremap K :SuperMan <cword><CR>
