" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_graphql' | if exists(s:guard) | finish | endif

if has_key(g:plugs, 'ale')
  let b:ale_fix_on_save = 1

  let b:ale_fixers = ['prettier']
  let b:ale_linters = get(b:, 'ale_linters', {})
  let b:ale_linters['graphql'] = ['gqlint']
endif

let {s:guard} = 1 " EOF
