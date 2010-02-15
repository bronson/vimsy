" not sure what these do...?
set nocompatible  " tends to make things work better
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
set nostartofline     " don't jump to start of line as a side effect (i.e. <<)
set showmatch         " briefly jump to matching }] when typing

set scrolloff=3       " lines to keep visible before and after cursor
set sidescrolloff=7   " columns to keep visible before and after cursor
set sidescroll=1      " continuous horizontal scroll rather than jumpy

set laststatus=2      " always display status line even if only one window is visible.
" set confirm         " prompt user what to do instead of just failing (i.e. unsaved files)

" \ is a pinky stretch and usually in weird places.  , is better.
let mapleader = ","



" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" the above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/


" Remove end of line white space.  TODO: change this to :FixWhitespace?
noremap <leader>r ma:%s/\s\+$//e<CR>`a


" Map <C-L> also turns off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

filetype indent plugin on
syntax on

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

" looks like this is not so good, it screws up the ability to cut and paste
" set mouse=a            " make the mouse work in consoles
" set ttymouse=xterm2    " console protocol to use
" this feels funky and everything seems to work fine without it
" set selectmode=mouse

set visualbell      " don't beep constantly, it's annoying.
set t_vb=           " and don't flash the screen either.

set guioptions-=T      " hide toolbar
" set guioptions-=m    " hide menu bar
" set guifont=Inconsolata\ Medium\ 10
" set guifont=* to bring up a font selector, set guifont? to see result
" desert is too low contrast
" slate is great except comments are horrible
" adaryn is very close to the emacs I used a decade ago at OpenTV
" nice: breeze, evening, navajo-night
colorscheme evening


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

" Make Control-Space perform completion
inoremap <Nul> <C-x><C-o>
inoremap <C-Space> <C-x><C-o>

" Make the quickfix window wrap no matter the setting of nowrap
au BufWinEnter * if &buftype == 'quickfix' | setl wrap | endif
" Make ,w toggle wrapping on and off
map <leader>w :set nowrap!<CR><CR>

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


" ------- replace vim's grep with ack
" embed ack since most distros haven't caught up to the --column option

set grepprg=$HOME/.vim/bin/ack-standalone\ --column
set grepformat=%f:%l:%c:%m

