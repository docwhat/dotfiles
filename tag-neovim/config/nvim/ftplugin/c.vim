if has_key(g:plugs, 'ale')
  let b:ale_fixers = ['clang-format', 'remove_trailing_lines', 'trim_whitespace']
  let b:ale_fix_on_save = 1
endif
