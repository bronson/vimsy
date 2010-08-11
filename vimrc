" vimsy's .vimrc
"
" Don't use abbreviations!  Spelling things out makes grepping easy.

" Let Pathogen bring in all the plugins
filetype off
call pathogen#runtime_append_all_bundles()

filetype indent plugin on
syntax on



" basics

set nocompatible      " tends to make things work better
set showcmd           " show incomplete cmds down the bottom
set showmode          " show current mode down the bottom

set incsearch         " find the next match as we type the search
set hlsearch          " hilight searches by default
set nowrap            " by default, dont wrap lines (see <leader>w)
set showmatch         " briefly jump to matching }] when typing
set nostartofline     " don't jump to start of line as a side effect (i.e. <<)

set scrolloff=3       " lines to keep visible before and after cursor
set sidescrolloff=7   " columns to keep visible before and after cursor
set sidescroll=1      " continuous horizontal scroll rather than jumpy

set laststatus=2      " always display status line even if only one window is visible.
set updatetime=1000   " reduce updatetime so current tag in taglist is highlighted faster
set autoread          " suppress warnings when git,etc. changes files on disk.

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set backspace=indent,eol,start "allow backspacing over everything in insert mode
set history=1000               "store lots of :cmdline history

set hidden " no need to save before hiding, http://items.sjbach.com/319/configuring-vim-right

set visualbell      " don't beep constantly, it's annoying.
set t_vb=           " and don't flash the screen either (terminal anyway...
set guioptions-=T   " hide gvim's toolbar by default
" set guifont=Inconsolata\ Medium\ 10
" set guifont=* to bring up a font selector, set guifont? to see result

" search for a tags file recursively from cwd to /
set tags=.tags,tags;/

" Store swapfiles in a single directory.
set directory=~/.vim/swap,~/tmp,/var/tmp/,tmp



" indenting, languages

set expandtab         " use spaces instead of tabstops
set smarttab          " use shiftwidth when hitting tab instead of sts (?)
set autoindent        " try to put the right amount of space at the beginning of a new line
set shiftwidth=2
set softtabstop=2

" autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2
" ruby includes ! and ? in method names (array.empty?)
autocmd FileType ruby setlocal iskeyword+=!,?



" fixes

" <C-L> redraws the screen and also turns off highlighting the current search
nnoremap <C-L> :nohl<CR><C-L>

" make ' jump to saved line & column rather than just line.
" http://items.sjbach.com/319/configuring-vim-right
nnoremap ' `
nnoremap ` '

" make Y yank to the end of the line (like C and D).  Use yy to yank the entire line.
" Upside: feels more natural.  Downside: not stock vi/vim.
nmap Y y$

" Add a binding to search for the word under the cursor in all files
map <leader>* :execute "noautocmd grep -rw " . expand("<cword>") . " ."<CR>

" Make the quickfix window wrap no matter the setting of nowrap
au BufWinEnter * if &buftype == 'quickfix' | setl wrap | endif



" color schemes

" desert is too low contrast
" slate is great except comments are horrible
" adaryn is very close to the solaris/emacs I used at OpenTV
" nice: breeze, evening, navajo-night
colorscheme evening


" Plugins:

runtime macros/matchit.vim  " enable vim's built-in matchit script (make % bounce between tags, begin/end, etc)


" --- BUNDLE: git://github.com/scrooloose/nerdtree.git
nmap <leader>d :NERDTreeToggle<cr>
nmap <leader>D :NERDTreeFind<cr>


" --- BUNDLE: git://github.com/scrooloose/nerdcommenter.git

" add a space between the comment delimiter and text
let NERDSpaceDelims=1

" Use Control-/ to toggle comments
nmap <C-/> :call NERDComment(0, "toggle")<CR>
vmap <C-/> <ESC>:call NERDComment(1, "toggle")<CR>
" but most vim implementations produce Control-_ instead of Control-/:
nmap <C-_> :call NERDComment(0, "toggle")<CR>
vmap <C-_> <ESC>:call NERDComment(1, "toggle")<CR>
" and vim-gtk and vim-gnome are broken (:help vimsy-control-/)
" you can use <leader>/ to do the same things.
nmap <leader>/ :call NERDComment(0, "toggle")<CR>
vmap <leader>/ <ESC>:call NERDComment(1, "toggle")<CR>
" but maybe <leader>C is nicer to type?
nmap <leader>C  :call NERDComment(0, "toggle")<CR>
vmap <leader>C <ESC>:call NERDComment(1, "toggle")<CR>


" --- BUNDLE: git://github.com/tpope/vim-surround.git
" tell surround not to break the visual s keystroke (:help vs)
xmap S <Plug>Vsurround


" --- BUNDLE: git://github.com/bronson/vim-taglist.git
nmap <leader>l :TlistToggle<cr>

" --- BUNDLE: git://github.com/bronson/vim-bufexplorer.git
" --- BUNDLE: git://git.wincent.com/command-t.git
" --- BUNDLE: git://github.com/bronson/vim-closebuffer.git
" --- BUNDLE: git://github.com/vim-ruby/vim-ruby.git
" --- BUNDLE: git://github.com/tpope/vim-rails.git
" --- BUNDLE: git://github.com/msanders/snipmate.vim.git
" --- BUNDLE: git://github.com/scrooloose/snipmate-snippets.git
" --- BUNDLE: git://github.com/bronson/vim-indexedsearch.git
" --- BUNDLE: git://github.com/bronson/vim-ruby-block-conv.git
" --- BUNDLE: git://github.com/tsaleh/vim-align.git
" --- BUNDLE: git://github.com/tpope/vim-endwise.git
" --- BUNDLE: git://github.com/tpope/vim-repeat.git
" --- BUNDLE: git://github.com/tsaleh/vim-supertab.git
" --- BUNDLE: git://github.com/mikezackles/Bisect.git
" --- BUNDLE: git://github.com/rson/vim-conque.git
" --- BUNDLE: git://github.com/bronson/vim-scrollcolors.git
" Syntax Files:
" --- BUNDLE: git://github.com/bronson/vim-jquery.git
" --- BUNDLE: git://github.com/tsaleh/vim-shoulda.git
" --- BUNDLE: git://github.com/tpope/vim-git.git
" --- BUNDLE: git://github.com/tpope/vim-cucumber.git
" --- BUNDLE: git://github.com/tpope/vim-haml.git
" --- BUNDLE: git://github.com/tpope/vim-markdown.git
" --- BUNDLE: git://github.com/timcharper/textile.vim.git
" --- BUNDLE: git://github.com/kchmck/vim-coffee-script.git
" Color Schemes:
" --- BUNDLE: git://github.com/tpope/vim-vividchalk.git
"
" # dir layout doesn't work with pathogen, not sure if it's worth using anyway
" # http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen#comment_348
" # :BUNDLE git://github.com/astashov/vim-ruby-debugger.git


" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" the above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" Remove end of line white space.  TODO: change this to :FixWhitespace?
map <leader>r ma:%s/\s\+$//e<CR>`a



" This makes * and # work on visual mode too.
" http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vmap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vmap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


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


" -------

" Make \w toggle through the three wrapping modes.
" TODO: turn this into a plugin

:function ToggleWrap()
: if (&wrap == 1)
:   if (&linebreak == 0)
:     set linebreak
:   else
:     set nowrap
:   endif
: else
:   set wrap
:   set nolinebreak
: endif
:endfunction

map <leader>w :call ToggleWrap()<CR>

" The Align plugin declares a TON of maps, few of which are useful.
" Remove the ones which conflict with other uses (like \w for wrapping)
    " unmap <leader>w=
    " unmap <leader>m=
" hm, that didn't work.  turn them all off.
let g:loaded_AlignMapsPlugin = "v41"


" ------- replace vim's grep with ack
" Disabled by default because it's too different from stock vim behavior.
" Embed ack since most distros haven't caught up to the --column option.

" set grepprg=$HOME/.vim/bin/ack-standalone\ --column
" set grepformat=%f:%l:%c:%m

