" Rubocop auto correction of lint
" We can't use '--stdin -' because it still emits crap.
function! RubocopAutocorrect()
  let l:curw = winsaveview()

  let l:buf = getline(1, '$')

  let l:tempfile = tempname()
  call writefile(l:buf, l:tempfile)

  if HasFiletype('chef') && executable('cookstyle')
    let l:cmd = 'cookstyle'
  else
    let l:cmd = 'rubocop'
  endif
  let l:cmd .= ' --auto-correct ' . l:tempfile
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
