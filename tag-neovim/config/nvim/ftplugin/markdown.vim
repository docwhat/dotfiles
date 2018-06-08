" Default according to spec.
set tabstop=4 shiftwidth=4

if has_key(g:plugs, 'ale')
  let b:ale_fixers = ['prettier']
  let b:ale_fix_on_save = 1
endif
