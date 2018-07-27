" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_help' | if exists(s:guard) | finish | endif

if has_key(g:plugs, 'ale')
  let b:ale_fixers =  [ 'align_help_tags' ]
endif

let {s:guard} = 1 " EOF
