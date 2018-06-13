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
