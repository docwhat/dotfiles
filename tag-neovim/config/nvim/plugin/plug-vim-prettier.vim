" Prettier -- Specialized formatting tool
if !HasPlugin('vim-prettier')
  finish
endif

function! s:myPrettierSetup()
  let l:whitelist = [ 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue' ]
  if &readonly                         | return | endif
  if ! &modifiable                     | return | endif
  if index(l:whitelist, &filetype) < 0 | return | endif

  function! s:PrettierEnable()
    let b:my_prettier_disable = 0

    augroup VimrcPrettier
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> Prettier
    augroup END
  endfunction

  function! s:PrettierDisable()
    let b:my_prettier_disable = 1

    augroup VimrcPrettier
      autocmd! * <buffer>
    augroup END
    augroup! VimrcPrettier
  endfunction

  function! PrettierToggle()
    if b:my_prettier_disable
      echomsg 'Prettier on save: ENABLED'
      call s:PrettierEnable()
    else
      echomsg 'Prettier on save: DISABLED'
      call s:PrettierDisable()
    endif
  endfunction
  command! PrettierToggle call PrettierToggle()

  if !exists('b:my_neoformat_disable')
    let b:my_prettier_disable = 0
    call s:PrettierEnable()
  endif

  nmap <buffer> <Leader>g <Plug>(PrettierAsync)
endfunction

let g:prettier#autoformat = 0
let g:prettier#config#config_precedence = 'file-override'
let g:prettier#config#prose_wrap = 'always'

augroup VimrcPrettierSetup
  autocmd!
  autocmd BufEnter * call s:myPrettierSetup()
augroup END


