if has_key(g:plugs, 'ale')
  let b:ale_fix_on_save = 1
  let s:buffer = bufnr('%')
  let b:ale_fixers = ['prettier', 'tslint', 'remove_trailing_lines']
endif
