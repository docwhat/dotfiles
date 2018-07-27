" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_yaml' | if exists(s:guard) | finish | endif

setlocal tabstop=2

if has_key(g:plugs, 'ale')
  let b:ale_fixers = [
        \ 'remove_trailing_lines',
        \ 'trim_whitespace'
        \ ]
  let b:ale_fix_on_save = 1
endif

let {s:guard} = 1 " EOF
