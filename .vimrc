"General
set fileformats=unix,dos
set ruler
set number
set hlsearch
set laststatus=2

set nocompatible "Filetype detection doesn't work well in compatible mode
set softtabstop=2 "number of space chars a tab counts for
set shiftwidth=2 "number of space chars for indentation
set expandtab "insert space characters whenever the tab key is pressed
set tabstop=2 "space chars inserted when tab key is pressed
set autoindent
set expandtab
set smarttab
set noerrorbells visualbell t_vb= "turn off annoying bells
" set nowrap
set showmatch " set show matching parenthesis

"Indent
set autoindent
set copyindent

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
colorscheme autumn
" colorscheme Monokai
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
Bundle 'surround.vim'
Bundle 'tComment'

" github repos
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'maciakl/vim-neatstatus'
Bundle 'gavinbeatty/dragvisuals.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'Raimondi/delimitMate'
Plugin 'wojtekmach/vim-rename'
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()

filetype plugin indent on

"==============================[ JSX BLOCK ]===============================
let g:jsx_pragma_required = 1

"==============================[ HOTKEYS BLOCK ]===============================
" Comment toggle. Requires tComment plugin
map <leader>c <c-_><c-_>

let g:user_emmet_mode='i'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" NEDRTree Tabs Toggle. Requires nerdtree & vim-nerdtree-tabs plugins
map <leader>t :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 1

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


"====[ Swap v and CTRL-V, because Block mode is more useful that Visual mode ]=

    nnoremap    v   <C-V>
    nnoremap <C-V>     v

    vnoremap    v   <C-V>
    vnoremap <C-V>     v

