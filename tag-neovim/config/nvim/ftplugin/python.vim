" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_python' | if exists(s:guard) | finish | endif

if has_key(g:plugs, 'ale')
  let b:ale_fixers = [
        \ 'remove_trailing_lines',
        \ 'isort',
        \ 'autopep8',
        \ 'black',
        \]

  let b:ale_completion_excluded_words = ['and', 'or', 'if']
  let b:ale_fix_on_save = 1
endif

let {s:guard} = 1 " EOF
