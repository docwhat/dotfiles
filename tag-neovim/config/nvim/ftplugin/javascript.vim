" Must be at the start
if exists('b:did_ftplugin_javascript')
  finish
endif

if has_key(g:plugs, 'ale')
  let b:ale_fix_on_save = 1
  let s:buffer = bufnr('%')

  let b:ale_fixers = ['importjs']
  if filereadable(ale#fixers#prettier_eslint#GetExecutable(s:buffer))
    let b:ale_fixers += ['prettier-eslint']
  elseif filereadable(ale#fixers#prettier_standard#GetExecutable(s:buffer))
    let b:ale_fixers += ['prettier-standard']
  else
    let b:ale_fixers += ['prettier', 'eslint']
  endif
  let b:ale_fixers += ['remove_trailing_lines']
endif

" Jest
if has_key(g:plugs, 'coverage.vim')
  let g:coverage_json_report_path='coverage/coverage-final.json'
  let g:coverage_show_covered=0
  let g:coverage_show_uncovered=1
endif

" Must be last
let b:did_ftplugin_javascript = 1
