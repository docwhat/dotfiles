" A wrapper function to restore the cursor position, window position,
" and last search after running a command.
function! Preserve(command)
  " Save the last search
  let l:last_search=@/
  " Save the current cursor position
  let l:save_cursor = getpos('.')
  " Save the window position
  normal! H
  let l:save_window = getpos('.')
  call setpos('.', l:save_cursor)

  " Do the business:
  execute a:command

  " Restore the last_search
  let @/=l:last_search
  " Restore the window position
  call setpos('.', l:save_window)
  normal! zt
  " Restore the cursor position
  call setpos('.', l:save_cursor)
endfunction

" Rubocop auto correction of lint
" We can't use '--stdin -' because it still emits crap.
function! RubocopAutocorrect()
  let l:curw = winsaveview()

  let l:buf = getline(1, '$')

  let l:tempfile = tempname()
  call writefile(l:buf, l:tempfile)

  let l:cmd = 'rubocop --auto-correct ' . l:tempfile
  call system(l:cmd)

  let l:output = readfile(l:tempfile)
  % delete _
  call setline(1, l:output)

  call winrestview(l:curw)
endfunction
command! RubyDelint call RubocopAutocorrect()

augroup RubocopAutocorrect
  autocmd!
  autocmd BufEnter nested term://rubocop* startinsert
augroup END
