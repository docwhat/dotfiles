" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_c' | if exists(s:guard) | finish | endif

if has_key(g:plugs, 'ale')
  let b:ale_fixers = [
        \ 'clang-format',
        \ 'remove_trailing_lines',
        \ 'trim_whitespace'
        \ ]
  let b:ale_fix_on_save = 1
endif

let {s:guard} = 1 " EOF
