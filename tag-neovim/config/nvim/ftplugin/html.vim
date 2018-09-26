" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_html' | if exists(s:guard) | finish | endif

if has_key(g:plugs, 'ale')
  let s:enabled_linters = deepcopy(ale#linter#Get('markdown'))
  let s:enabled_names = map(copy(s:enabled_linters), 'v:val[''name'']')

  let b:ale_linters = get(b:, 'ale_linters', {})
  let b:ale_linters['html'] = s:enabled_names

  if executable('vale')
    call filter(b:ale_linters['html'], { idx, val -> val != 'proselint' })
    call filter(b:ale_linters['html'], { idx, val -> val != 'writegood' })
    " let b:ale_linters['html'] += ['vale']
  endif
endif

let {s:guard} = 1 " EOF
