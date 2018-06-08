if has_key(g:plugs, 'ale')
  let b:ale_fixers = [
        \   'remove_trailing_lines',
        \   'isort',
        \   'extra_ale_fixers#AutomaticallyFixJSONDiffOutput',
        \   'ale#fixers#generic_python#BreakUpLongLines',
        \   'autopep8',
        \]

  let b:ale_completion_excluded_words = ['and', 'or', 'if']
endif
