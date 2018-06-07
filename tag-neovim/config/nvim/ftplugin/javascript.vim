" Current buffer number
let s:buffer = bufnr('%')

" Select fixers
let b:ale_fixers = []
if filereadable(ale#fixers#prettier_eslint#GetExecutable(s:buffer))
  let b:ale_fixers = ['prettier-eslint']
elseif filereadable(ale#fixers#prettier_standard#GetExecutable(s:buffer))
  let b:ale_fixers = ['prettier-standard']
else
  let b:ale_fixers = ['prettier', 'eslint']
endif

" Auto fix on save
let b:ale_fix_on_save = 1
