" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_sh' | if exists(s:guard) | finish | endif

if has_key(g:plugs, 'ale')
  function! SetShfmtOptions() abort
    let l:tabwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    let b:ale_sh_shfmt_options = '-i ' . l:tabwidth . ' -s'
  endfunction

  augroup FtpluginSh
    autocmd!
    autocmd OptionSet tabstop,shiftwidth nested call SetShfmtOptions()
  augroup END

  let b:ale_fixers = [
        \ 'shfmt',
        \ 'remove_trailing_lines',
        \ 'trim_whitespace'
        \ ]
  let b:ale_fix_on_save = 1
  let b:ale_sh_shellcheck_change_directory = 0

  " Initialization
  if exists(':EditorConfigReload') == 2
    :EditorConfigReload
  endif
  call SetShfmtOptions()
endif

let {s:guard} = 1 " EOF
