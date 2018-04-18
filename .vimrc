"General
set fileformats=unix,dos
set ruler
set number
set hlsearch
set laststatus=2

set nocompatible "Filetype detection doesn't work well in compatible mode
set softtabstop=2 "number of space chars a tab counts for
set shiftwidth=8 "number of space chars for indentation
" set expandtab "insert space characters whenever the tab key is pressed
set tabstop=8 "space chars inserted when tab key is pressed
set smarttab
set noerrorbells visualbell t_vb= "turn off annoying bells
" set nowrap
set showmatch " set show matching parenthesis

" Indent
set autoindent
set copyindent

" Insert mode with paste
set paste

" Higlight column #n with color
set colorcolumn=80

" Highlight the line with a cursor
set cursorline

"Detect encoding
set ffs=unix
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

"Python syntax highlight
let python_highlight_all = 1

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

" Filetype plugins
" filetype plugin indent on

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

" vim-session
let g:session_autoload="yes"
let g:session_autosave="yes"
let g:session_default_to_last="yes"


"================================[ VUNDLE BLOCK"]==============================
filetype off  "required!

set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#rc()

call vundle#begin()

" vim/scripts repos
" all about surroundings: parentheses, brackets, quotes
Bundle 'surround.vim'
" Bundle 'snipMate'
" Comments/Uncomments line/visual block with \c
Bundle 'tComment'

" github repos
" Emmet completions
" Bundle 'mattn/emmet-vim'
" File system explorer
Bundle 'scrooloose/nerdtree'
" NERDTree panel, independent of tabs
Bundle 'jistr/vim-nerdtree-tabs'
" Neat Status Line //github.com/Cu7ious/vim-neatstatus
Bundle 'Cu7ious/vim-neatstatus'
" Drags selected blocks with arrow keys in VISUAL mode
Bundle 'gavinbeatty/dragvisuals.vim'
" Colorschemes //github.com/flazz/vim-colorschemes
Bundle 'flazz/vim-colorschemes'
" Automatic closing of quotes parenthesis brackets etc.
Bundle 'Raimondi/delimitMate'
" Syntax highlighting and improved indentation
Plugin 'pangloss/vim-javascript'
" :saveas <newfile> then rms old filename on disk
Plugin 'wojtekmach/vim-rename'
" Fuzyy finder
Plugin 'ctrlpvim/ctrlp.vim'
" Opens header files automatically
Plugin 'vim-scripts/a.vim'
" Error checking: shows the offending line next to the line numbers
Plugin 'vim-syntastic/syntastic'
" ----- Working with Git ----------------------------------------------
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
" Man pages right in vim
Plugin 'jez/vim-superman'
" ----- Python --------------------------------------------------------
" Pep8 auto formatter
Plugin 'tell-k/vim-autopep8'


call vundle#end()

filetype plugin indent on


"==============================[ HOTKEYS BLOCK ]===============================
" Turns off the ruler and line numbers to make it ready for copy/paste
command CPMode :call CPModeToggle()
function! CPModeToggle()
    if &number
        set nonumber | set colorcolumn=0
    else
        set number | set colorcolumn=80
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

let g:user_emmet_mode='i'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" NEDRTree Tabs Toggle. Requires nerdtree & vim-nerdtree-tabs plugins
map <leader>t :NERDTreeTabsToggle<CR>

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
 hi clear SignColumn

 let g:syntastic_check_on_open = 1

 let g:syntastic_cpp_compiler = 'g++'
 let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

 let g:syntastic_python_python_exec = '/usr/bin/python3'

 set statusline+=%#warningmsg#
 set statusline+=%{SyntasticStatuslineFlag()}
 set statusline+=%*

 augroup mySyntastic
   au!
   au FileType tex let b:syntastic_mode = "passive"
 augroup END


"================================[ Syntastic ]=================================
" better man page support
noremap K :SuperMan <cword><CR>
