" Must be at the start
if exists('b:did_ftplugin_yaml')
  finish
endif

setlocal tabstop=2

if has_key(g:plugs, 'ale')
  let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
  let b:ale_fix_on_save = 1
endif

" Must be last
let b:did_ftplugin_yaml = 1
