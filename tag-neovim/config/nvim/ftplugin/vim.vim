setlocal expandtab
setlocal colorcolumn=80

setlocal formatoptions=croql
" Continue \ lines after one is found.
setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",b:\\

if has_key(g:plugs, 'ale')
  let b:ale_fix_on_save = 1
  let b:ale_fixers = [
        \ 'remove_trailing_lines',
        \ 'trim_whitespace',
        \ ]
endif
