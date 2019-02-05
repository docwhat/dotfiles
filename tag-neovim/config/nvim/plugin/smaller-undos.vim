" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.

inoremap <C-U> <C-G>u<C-U>
inoremap <CR> <C-G>u<CR>
