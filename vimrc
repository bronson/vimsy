" vimsy's .vimrc
"
" Don't use abbreviations!  Spelling it out makes grepping easy.

" not sure what these do...?
set nocompatible  " tends to make things work better
set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search 
set hlsearch    "hilight searches by default
set nowrap      "dont wrap lines

" I find linebreak more hassle than it's worth.  It makes it very hard to copy
" n paste between vim windows due to the artificially inserted CRs, and it can
" hide errors that look OK due to wrapping.
" set linebreak   "wrap lines at convenient points

" make Y consistent with C and D
nnoremap Y y$

set shiftwidth=4
set softtabstop=4
" ruby code tends to use smaller tabs
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2
" ruby includes ! and ? in method names (array.empty?)
autocmd FileType ruby setlocal iskeyword+=!,?

set expandtab         " use spaces instead of tabstops
set smarttab          " use shiftwidth when hitting tab instead of sts (?)
set autoindent        " try to put the right amount of space at the beginning of a new line
set nostartofline     " don't jump to start of line as a side effect (i.e. <<)
set showmatch         " briefly jump to matching }] when typing

set scrolloff=3       " lines to keep visible before and after cursor
set sidescrolloff=7   " columns to keep visible before and after cursor
set sidescroll=1      " continuous horizontal scroll rather than jumpy

set laststatus=2      " always display status line even if only one window is visible.
" set confirm         " prompt user what to do instead of just failing (i.e. unsaved files)
set updatetime=1000   " reduce updatetime so current tag in taglist is highlighted faster
set autoread          " suppress warnings when git,etc. changes files on disk.

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
set t_vb=           " and don't flash the screen either (terminal anyway...

set guioptions-=T      " hide toolbar
" set guioptions-=m    " hide menu bar
" set guifont=Inconsolata\ Medium\ 10
" set guifont=* to bring up a font selector, set guifont? to see result
" desert is too low contrast
" slate is great except comments are horrible
" adaryn is very close to the emacs I used a decade ago at OpenTV
" nice: breeze, evening, navajo-night
colorscheme evening

" make status line include fugitive git info
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


" Not sure if these are a good idea...
" set formatoptions-=o "dont continue comments when pushing o/O
" let g:syntastic_enable_signs=1 "mark syntax errors with :signs

" search for a tags file recursively from cwd to /
set tags=.tags,tags;/

" Make ,* search for the word under the cursor in all files
map <leader>* :execute "noautocmd grep -rw " . expand("<cword>") . " ."<CR>


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


nnoremap <leader>d :NERDTreeToggle<cr>
nnoremap <leader>D :NERDTreeFind<cr>
nnoremap <leader>l :TlistToggle<cr>

nnoremap <C-J> :BufExplorer<CR>
nnoremap <C-K> :FuzzyFinderTextMate<CR>

" Use Control-/ to toggle comments
nnoremap <C-/> :call NERDComment(0, "toggle")<CR>
vnoremap <C-/> <ESC>:call NERDComment(1, "toggle")<CR>
" but most vim implementations produce Control-_ instead of Control-/:
" Mapping C-_ may surprise Hebrew and Farsi programmers...?
nnoremap <C-_> :call NERDComment(0, "toggle")<CR>
vnoremap <C-_> <ESC>:call NERDComment(1, "toggle")<CR>
" and vim-gtk and vim-gnome are broken (:help vimsy-control-/)
" you can use <leader>/ to do the same things.
nnoremap <leader>/ :call NERDComment(0, "toggle")<CR>
vnoremap <leader>/ <ESC>:call NERDComment(1, "toggle")<CR>
" but maybe <leader>C is nicer to type?
nnoremap <leader>C  :call NERDComment(0, "toggle")<CR>
vnoremap <leader>C <ESC>:call NERDComment(1, "toggle")<CR>

" add a space between the comment delimiter and text
let NERDSpaceDelims=1

" Make Control-Space perform completion
inoremap <Nul> <C-x><C-o>
inoremap <C-Space> <C-x><C-o>

" Close buffer but not window.  See close-buffer.vim
nmap <C-W>e     <Plug>Kwbd
nmap <C-W><C-E> <Plug>Kwbd

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

" tell surround not to break the visual s keystroke (:help vs)
xmap S <Plug>Vsurround


" ------- replace vim's grep with ack
" Disabled by default because it's too different from stock vim behavior.
" Embed ack since most distros haven't caught up to the --column option.

" set grepprg=$HOME/.vim/bin/ack-standalone\ --column
" set grepformat=%f:%l:%c:%m


" Make vim restore cursorpos & folding each time it loads a document
" No, just too unreliable.  It's always screwing up readonly and syntax highlighting.
" au BufWinLeave * mkview
" au BufWinEnter *.* silent loadview

" Store swapfiles in a single directory.
" Upside: makes mass deleting swapfiles easy, doesn't clutter project dirs
" Downside: you won't be notified if you start editing the same file as someone else.
set directory=~/.vim/swap,~/tmp,/var/tmp/,tmp
