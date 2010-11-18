" vimsy's .vimrc
"
" Don't use abbreviations!  Spelling things out makes grepping easy.

" Let Pathogen bring in all the plugins
filetype on
filetype off
call pathogen#runtime_append_all_bundles()

filetype indent plugin on
syntax on

" Bundle: git://github.com/bronson/vim-common.git

" Store swapfiles in a single directory.
set directory=~/.vim/swap,~/tmp,/var/tmp/,tmp

" Make the escape key bigger, keyboards move it all over.
" TODO: why doesn't this work?
map <F1> <Esc>
imap <F1> <Esc>

" add a keybinding to toggle paste mode
nnoremap <leader>p :set paste!<CR>:set paste?<CR>

" make ' jump to saved line & column rather than just line.
" http://items.sjbach.com/319/configuring-vim-right
nnoremap ' `
nnoremap ` '

" make Y yank to the end of the line (like C and D).  Use yy to yank the entire line.
" Upside: feels more natural.  Downside: not stock vi/vim.
nmap Y y$

" Make the quickfix window wrap no matter the setting of nowrap
au BufWinEnter * if &buftype == 'quickfix' | setl wrap | endif


" Make Control-direction switch between windows (like C-W h, etc)
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>


" color schemes

" desert is too low contrast
" slate is great except comments are horrible
" adaryn is very close to the solaris/emacs I used at OpenTV
" nice: breeze, evening, navajo-night
colorscheme evening


" Plugins:

" BUNDLE: git://github.com/scrooloose/nerdtree.git
nmap <leader>d :NERDTreeToggle<cr>
nmap <leader>D :NERDTreeFind<cr>


" BUNDLE: git://github.com/scrooloose/nerdcommenter.git
let NERDSpaceDelims=1    " add a space between the comment delimiter and text

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


" BUNDLE: git://github.com/tpope/vim-surround.git
" tell surround not to break the visual s keystroke (:help vs)
xmap S <Plug>Vsurround


" BUNDLE: http://github.com/vim-scripts/taglist.vim.git
nmap <leader>l :TlistToggle<cr>

" BUNDLE: http://github.com/vim-scripts/bufexplorer.zip.git

" BUNDLE: git://git.wincent.com/command-t.git
" ensure we compile with the system ruby if rvm is installed
" BUNDLE-COMMAND: if which rvm >/dev/null 2>&1; then rvm system exec rake make; else rake make; fi
nmap <silent> <C-Space> :CommandT<CR>
nmap <silent> <C-@> :CommandT<CR>
" let g:CommandTCancelMap = ['<C-c>', '<Esc>', '<C-Space>', '<C-@>']
" let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>', '<Up>', '<ESC>OA']
" let g:CommandTSelectNextMap = ['<C-n>', '<C-j>', '<Down>', '<ESC>OB']
let g:CommandTMatchWindowAtTop = 1

" BUNDLE: git://github.com/bronson/vim-closebuffer.git
" BUNDLE: git://github.com/vim-ruby/vim-ruby.git
" BUNDLE: git://github.com/tpope/vim-rails.git
" BUNDLE: git://github.com/tpope/vim-rake.git
" BUNDLE: git://github.com/vim-scripts/a.vim.git
" BUNDLE: git://github.com/msanders/snipmate.vim.git
" BUNDLE: git://github.com/scrooloose/snipmate-snippets.git
" BUNDLE: git://github.com/vim-scripts/IndexedSearch.git
" BUNDLE: git://github.com/bronson/vim-ruby-block-conv.git

" BUNDLE: git://github.com/janx/vim-rubytest.git
" taglist currently uses \l. TODO: this will need to be resolved.
map <unique> <Leader>. <Plug>RubyTestRunLast
let g:rubytest_in_quickfix = 1

" BUNDLE: git://github.com/tsaleh/vim-align.git
" The Align plugin declares a TON of maps, few of which are useful
" and some of which conflict with other mappings (like \w and \m).
let g:loaded_AlignMapsPlugin = "v41"

" BUNDLE: git://github.com/tpope/vim-endwise.git
" BUNDLE: git://github.com/tpope/vim-repeat.git

" BUNDLE: git://github.com/tpope/vim-fugitive.git
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" BUNDLE: http://github.com/ervandew/supertab.git
" BUNDLE: git://github.com/bronson/vim-visual-star-search.git
" BUNDLE: git://github.com/bronson/vim-trailing-whitespace.git
" BUNDLE: git://github.com/bronson/vim-toggle-wrap.git

" BUNDLE: git://github.com/Raimondi/YAIFA.git
" verbosity=1 allows you to check YAIFA's results by running :messages
let g:yaifa_verbosity = 0
" yaifa's default produces a 2 second delay when loading huge files.  If you
" can't figure it out in 2048 lines there's no need to churn thru 14000 more.
let g:yaifa_max_lines = 2048

" BUNDLE: http://github.com/vim-scripts/AutoTag.git

" Syntax Files:
" BUNDLE: git://github.com/vim-scripts/jQuery.git
" BUNDLE: git://github.com/tsaleh/vim-shoulda.git
" BUNDLE: git://github.com/tpope/vim-git.git
" BUNDLE: git://github.com/tpope/vim-cucumber.git
" BUNDLE: git://github.com/tpope/vim-haml.git
" BUNDLE: git://github.com/tpope/vim-markdown.git
" BUNDLE: git://github.com/timcharper/textile.vim.git
" BUNDLE: git://github.com/kchmck/vim-coffee-script.git
" Color Schemes:
" BUNDLE: git://github.com/tpope/vim-vividchalk.git
"
" # vim-ruby-debugger's directory layout doesn't work with pathogen.
" # http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen#comment_348
" # :BUNDLE git://github.com/astashov/vim-ruby-debugger.git

" neat idea but I don't use it
" # BUNDLE: git://github.com/rson/vim-conque.git
