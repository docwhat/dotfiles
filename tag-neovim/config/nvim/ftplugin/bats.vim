let s:guard = 'b:did_ftplugin_bats' | if exists(s:guard) | finish | endif

setlocal commentstring=#%s

if has_key(g:plugs, 'ale')
  let b:ale_linter_aliases = ['sh']
  let b:ale_linters = [
        \ 'shellcheck'
        \ ]
  let b:ale_enabled = 1
  let b:ale_sh_shellcheck_change_directory = 0
  let b:ale_sh_shellcheck_dialect="bats"
endif

let b:undo_ftplugin = 'setlocal commentstring<'

let {s:guard} = 1 " EOF
