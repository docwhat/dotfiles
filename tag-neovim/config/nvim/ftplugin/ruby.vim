if has_key(g:plugs, 'ale')
  let b:ale_fixers = [ 'rubocop' ]
  let b:ale_fix_on_save = 1
endif
