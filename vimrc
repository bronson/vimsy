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

set hidden " no need to save before hiding, http://items.sjbach.com/319/configuring-vim-right

" make ' jump to saved line & column rather than just line.
" http://items.sjbach.com/319/configuring-vim-right
nnoremap ' `
nnoremap ` '

" \ is a pinky stretch and usually in weird places.  , is better.
let mapleader = ","

" hm, not sure if this is a good idea or not
set mouse=a            " make the mouse work in consoles
set ttymouse=xterm2    " console protocol to use
set selectmode=mouse
set visualbell         " no beep mess even if the os is set wrong

set guioptions-=T      " hide toolbar
" set guioptions-=m    " hide menu bar
" set guifont=Inconsolata\ Medium\ 10
" set guifont=* to bring up a font selector, set guifont? to see result
colorscheme desert


" Just use PageUp and PageDown to scroll?
"nnoremap <C-B> :BufExplorer<cr>
"nnoremap <C-F> :FuzzyFinderTextMate<CR>

" http://eigenclass.org/hiki/Ruby+block+conversion+macros+for+Vim
source $HOME/.vim/ruby-block-conv.vim

" Not sure if these are a good idea...
" set formatoptions-=o "dont continue comments when pushing o/O
" let g:syntastic_enable_signs=1 "mark syntax errors with :signs

" to rebuild help after installing a plugin
" (maybe we should just do this on every startup?)
" :helptags ~/.vim/doc


" Hm, xmllint kind of sucks.  And isn't there a reformat-entire-buffer command?
" To reformat an XML buffer, hit :prettyxml
function! DoPrettyXML()
  1,$!xmllint --format --recover -
endfunction
command! PrettyXML call DoPrettyXML()
" and HTML, less pedantic than XML
function! DoPrettyHTML()
  1,$!xmllint --format --recover --html -
endfunction
command! PrettyHTML call DoPrettyHTML()


" This makes * and # work on visual mode too.
" http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>
