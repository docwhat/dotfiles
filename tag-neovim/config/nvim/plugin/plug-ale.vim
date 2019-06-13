" ALE -- linting, completion, and formatting
if !HasPlugin('ale')
  finish
end

if HasPlugin('coc.nvim')
  " Start disabled
  let g:ale_enabled     = 0
  let g:ale_fix_on_save = 0
  let g:ale_disable_lsp = 1
end

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 1
let g:ale_list_window_size = 5

" How messages are displayed
let g:ale_echo_cursor          = 1
let g:ale_echo_delay           = 20
let g:ale_echo_msg_error_str   = 'E'
let g:ale_echo_msg_info_str    = 'I'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format      = '%code: %%s [%linter%/%severity%]'

if $P9K_MODE ==# 'nerdfont-complete'
  let g:ale_sign_error         = ''
  let g:ale_sign_warning       = ''
  let g:ale_sign_info          = ''
  let g:ale_sign_style_error   = ''
  let g:ale_sign_style_warning = '𥉉'
else
  let g:ale_sign_error         = '◉'
  let g:ale_sign_warning       = '◉'
  let g:ale_sign_info          = '◉'
  let g:ale_sign_style_error   = '!'
  let g:ale_sign_style_warning = '!'
endif

if HasPlugin('vim-airline')
  " Set this. Airline will handle the rest.
  let g:airline#extensions#ale#enabled = 1

  if $P9K_MODE ==# 'nerdfont-complete'
    let g:airline#extensions#ale#error_symbol = ' '
    let g:airline#extensions#ale#warning_symbol = '𥉉'
  else
    let g:airline#extensions#ale#error_symbol = 'E:'
    let g:airline#extensions#ale#warning_symbol = 'W:'
  endif
endif

augroup VimrcALE
  autocmd!
  autocmd OptionSet tabstop,shiftwidth nested :call s:fixPrettierOptions()
  autocmd BufEnter *                   nested :call s:fixPrettierOptions()
augroup END

function! s:fixPrettierOptions()
  let l:tabwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
  let b:ale_javascript_prettier_options =
        \ get(g:, 'ale_javascript_prettier_options', '')
        \ . ' --tab-width=' . l:tabwidth

  if &textwidth > 0
    let b:ale_javascript_prettier_options = b:ale_javascript_prettier_options . ' --print-width=' . &textwidth . ' --prose-wrap=always'
  else
    let b:ale_javascript_prettier_options = b:ale_javascript_prettier_options . ' --prose-wrap=never'
  endif
endfunction

" ALE isn't going to add the fixers to the normal enable/disable.
" reference: https://github.com/w0rp/ale/issues/1353
command! ALEFixersDisable       let b:ale_fix_on_save=0
command! ALEFixersEnable        let b:ale_fix_on_save=1
command! ALEFixersToggle        let b:ale_fix_on_save = get(b:, 'ale_fix_on_save', get(g:, 'ale_fix_on_save', 0)) ? 0 : 1

