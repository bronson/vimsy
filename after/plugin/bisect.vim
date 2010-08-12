" I don't like the way bisect takes over the C-l command.
" Leave the vertical scrolling but turn off horizontal.

unmap <C-H>
unmap <C-L>

" and restore the vimrc setting: turn off search highlight when
" redrawing the screen.
nnoremap <C-L> :nohl<CR><C-L>

