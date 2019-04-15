" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_json' | if exists(s:guard) | finish | endif

if has_key(g:plugs, 'ale')
  let b:ale_fix_on_save = 0

  " Prettier will fix syntax errors (like trailing commas).
  let b:ale_fixers = ['prettier', 'fixjson']
endif

let {s:guard} = 1 " EOF
