" not sure what these do...?
set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search 
set hlsearch    "hilight searches by default
set nowrap      "dont wrap lines
set linebreak   "wrap lines at convenient points

" make Y consistent with C and D
nnoremap Y y$

set shiftwidth=2
set softtabstop=2
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

" looks like this is not so good, it screws up the ability to cut and paste
" set mouse=a            " make the mouse work in consoles
" set ttymouse=xterm2    " console protocol to use
" this feels funky and everything seems to work fine without it
" set selectmode=mouse

" visualbell is bad because vim is frozen the whole time the bell is going.
" it can cause 1/2 sec or more delays.
" set visualbell         " no beep mess even if the os is set wrong

set guioptions-=T      " hide toolbar
" set guioptions-=m    " hide menu bar
" set guifont=Inconsolata\ Medium\ 10
" set guifont=* to bring up a font selector, set guifont? to see result
" desert is too low contrast
" slate is great except comments are horrible
" adaryn is very close to the emacs I used a decade ago at OpenTV
" nice: breeze, evening, navajo-night
colorscheme evening


" Just use PageUp and PageDown to scroll?
"nnoremap <C-B> :BufExplorer<cr>
"nnoremap <C-F> :FuzzyFinderTextMate<CR>

" http://eigenclass.org/hiki/Ruby+block+conversion+macros+for+Vim
source $HOME/.vim/ruby-block-conv.vim

" Not sure if these are a good idea...
" set formatoptions-=o "dont continue comments when pushing o/O
" let g:syntastic_enable_signs=1 "mark syntax errors with :signs

" search for a tags file recursively from cwd to /
set tags=.tags,tags;/

" Make ,* search for the word under the cursor in all files
map <leader>* :execute "noautocmd vimgrep /\\<" . expand("<cword>") . "\\>/gj **/*.*" <Bar> cw<CR> 5


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


" http://got-ravings.blogspot.com/2009/02/vim-pr0n-jamis-buck-must-die.html
" map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
nnoremap <leader>d :NERDTreeToggle<cr>

" Use Control-J to bring up the bufexplorer
nnoremap <C-J> :BufExplorer<CR>
" Use Control-K to bring up the fuzzy finder
nnoremap <C-K> :FuzzyFinderTextMate<CR>
" Use Control-/ to toggle comments (why the heck doesn't this work in gvim??)
nnoremap <C-/> :call NERDComment(0, "toggle")<CR>
vnoremap <C-/> <ESC>:call NERDComment(1, "toggle")<CR>
" but that doesn't work in the terminal and, for some reason, this does:
nnoremap <C-_> :call NERDComment(0, "toggle")<CR>
vnoremap <C-_> <ESC>:call NERDComment(1, "toggle")<CR>
" So make ,c toggle comments always.  Sigh
map <leader>c  :call NERDComment(0, "toggle")<ESC>
" Why on earth does ,c take forever to run but ,C goes instantly?
map <leader>C  :call NERDComment(0, "toggle")<CR>


" Make the quickfix window wrap no matter the setting of nowrap
au BufWinEnter * if &buftype == 'quickfix' | setl wrap | endif

" ------   rSpec stuff

" Run rspec using a formatter meant for quickfix display
" Uses ~/.vim/ruby/vim_spec_formatter.rb to populate the quickfix window
" Slightly modified from https://wincent.com/blog/running-rspec-specs-from-inside-vim
function! RunSpec(command)
  if a:command == ''
    let dir = 'spec'
  else
    let dir = a:command
  endif
  cexpr system("spec -r ~/.vim/ruby/vim_spec_formatter.rb -f Spec::Runner::Formatter::VimSpecFormatter " . dir)"a:command)
  cw
endfunction

" have :Spec run rspecs (args with pathname completion, :Spec spec/views)
command! -nargs=? -complete=file Spec call RunSpec(<q-args>)

" Make ,s run Spec for ultra convenience
map <leader>s :Spec<space>

" -------

