" not sure what these do...?
set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search 
set hlsearch    "hilight searches by default
set nowrap      "dont wrap lines
set linebreak   "wrap lines at convenient points

" make Y consistent with C and D
nnoremap Y y$

set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set showmatch         " briefly jump to matching }] when typing

set scrolloff=3       " lines to keep visible before and after cursor
set sidescrolloff=7   " columns to keep visible before and after cursor
set sidescroll=1      " continuous horizontal scroll rather than jumpy

filetype plugin on    " needed by matchit
filetype indent on

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set backspace=indent,eol,start "allow backspacing over everything in insert mode
set history=1000               "store lots of :cmdline history


" hm, not sure if this is a good idea or not
set mouse=a            " make the mouse work in consoles
set ttymouse=xterm2    " console protocol to use
set selectmode=mouse


set guioptions-=T      "hide toolbar
" set guifont=Inconsolata\ Medium\ 10
" set guifont=* to bring up a font selector, set guifont? to see result
colorscheme desert


" Just use PageUp and PageDown to scroll?
"nnoremap <C-B> :BufExplorer<cr>
"nnoremap <C-F> :FuzzyFinderTextMate<CR>

" http://eigenclass.org/hiki/Ruby+block+conversion+macros+for+Vim
source $HOME/.vim/ruby-block-conv.vim

" Not sure if these are a good idea...
" set hidden           " hide buffers...  good/bad?
" set formatoptions-=o "dont continue comments when pushing o/O
" let g:syntastic_enable_signs=1 "mark syntax errors with :signs

" to rebuild help after installing a plugin
" (maybe we should just do this on every startup?)
" :helptags ~/.vim/doc

