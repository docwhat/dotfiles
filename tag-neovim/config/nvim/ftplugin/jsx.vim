" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_jsx' | if exists(s:guard) | finish | endif

if has_key(g:plugs, 'ale')
  let b:ale_linter_aliases = ['css', 'javascript']
  let b:ale_linters = ['stylelint', 'eslint']
endif

let {s:guard} = 1 " EOF
