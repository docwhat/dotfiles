" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_chef' | if exists(s:guard) | finish | endif

if has_key(g:plugs, 'ale')
  let b:ale_ruby_rubocop_executable = 'cookstyle'
endif

let {s:guard} = 1 " EOF
