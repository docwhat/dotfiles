" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_go' | if exists(s:guard) | finish | endif

" Go -- GoLang syntax, indentation, and tools
if has_key(g:plugs, 'vim-go') " {{{
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_interfaces = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_types = 1

  let g:go_auto_type_info = 1

  let g:go_term_enabled = 1

  let g:go_list_type = 'quickfix'

  " GoMetoLinter is deprecated now.
  let g:go_metalinter_command = 'gometalinter'

  let g:go_addtags_transform = 'snakecase'

  let g:go_fmt_command = 'goimports'

  if has_key(g:plugs, 'ale')
    let g:go_fmt_experimental = 0
    let g:go_fmt_autosave = 0
  else
    let g:go_fmt_experimental = 1
    let g:go_fmt_autosave = 1
  endif
endif " }}}

if has_key(g:plugs, 'ale')
  let b:ale_fixers = [ 'goimports' ]
  let b:ale_fix_on_save = 1
  let b:ale_enabled = 1
endif

let {s:guard} = 1 " EOF
