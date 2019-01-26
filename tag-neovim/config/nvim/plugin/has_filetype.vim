function! HasFiletype(ftype)
  let l:regexp = '\(^\|\.\)' . a:ftype .'\(\.\|$\)'
  if &filetype =~# l:regexp
    return 1
  else
    return 0
  endif
endfunction
