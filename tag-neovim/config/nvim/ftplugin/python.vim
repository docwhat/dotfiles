if has_key(g:plugs, 'ale')
  let b:ale_fixers = [
        \ 'remove_trailing_lines',
        \ 'isort',
        \ 'autopep8',
        \ 'black',
        \]

  let b:ale_completion_excluded_words = ['and', 'or', 'if']
  let b:ale_fix_on_save = 1
endif
