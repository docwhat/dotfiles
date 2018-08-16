" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_sh' | if exists(s:guard) | finish | endif

if has_key(g:plugs, 'ale')
  function! SetShfmtOptions() abort
    let l:tabwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    let b:ale_sh_shfmt_options = '-i ' . l:tabwidth . ' -s'
  endfunction

  call SetShfmtOptions()

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
endif

let {s:guard} = 1 " EOF
