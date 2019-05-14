" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_javascript' | if exists(s:guard) | finish | endif

try
  if has_key(g:plugs, 'ale')
    let b:ale_fix_on_save = 1
    let s:buffer = bufnr('%')

    let b:ale_fixers = ['importjs']
    let s:prettier_eslint = ale#fixers#prettier_eslint#GetExecutable(s:buffer)
    let s:prettier_standard = ale#fixers#prettier_standard#GetExecutable(s:buffer)

    if !empty(s:prettier_eslint) && executable(s:prettier_eslint)
      let b:ale_fixers += ['prettier-eslint']
    elseif !empty(s:prettier_standard) && executable(s:prettier_standard)
      let b:ale_fixers += ['prettier-standard']
    else
      let b:ale_fixers += ['prettier']
    endif
    let b:ale_fixers += ['remove_trailing_lines']

    let s:enabled_linters = deepcopy(ale#linter#Get('javascript'))
    let s:enabled_names = map(copy(s:enabled_linters), 'v:val[''name'']')

    let b:ale_linters = get(b:, 'ale_linters', {})
    let b:ale_linters['javascript'] = s:enabled_names

    call filter(b:ale_linters['javascript'], { idx, val -> val != 'tsserver' })
    " Dead project
    call filter(b:ale_linters['javascript'], { idx, val -> val != 'flow-language-server' })
  endif

  " Jest
  if has_key(g:plugs, 'coverage.vim')
    let g:coverage_json_report_path='coverage/coverage-final.json'
    let g:coverage_show_covered=0
    let g:coverage_show_uncovered=1
  endif
catch
  Decho('ftplugin javascript: ' . v:exception)
endtry

let {s:guard} = 1 " EOF
