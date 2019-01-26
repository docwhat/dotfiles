" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_vim' | if exists(s:guard) | finish | endif

setlocal expandtab
setlocal colorcolumn=80

setlocal formatoptions=croql
" Continue \ lines after one is found.
setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",b:\\

let b:ale_fixers = ['remove_trailing_lines']

let {s:guard} = 1 " EOF
