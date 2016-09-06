" A wrapper function to restore the cursor position, window position,
" and last search after running a command.
function! Preserve(command)
  " Save the last search
  let last_search=@/
  " Save the current cursor position
  let save_cursor = getpos('.')
  " Save the window position
  normal H
  let save_window = getpos('.')
  call setpos('.', save_cursor)

  " Do the business:
  execute a:command

  " Restore the last_search
  let @/=last_search
  " Restore the window position
  call setpos('.', save_window)
  normal zt
  " Restore the cursor position
  call setpos('.', save_cursor)
endfunction

" Whitespace Triming methods
"-----------------------------------------------------------------------------
" Use :StripTrailingWhiteOnSaveToggle to disable whitespace stripping.
" Use :StripTrailingWhite to call whitespace stripping manually.

function! s:StripTrailingWhite()
  let l:winview = winsaveview()
  silent! %s/\s\+$//
  call winrestview(l:winview)
endfunction
command! StripTrailingWhite call <SID>StripTrailingWhite()

" Strips whitespace on file save
function! s:StripTrailingWhiteOnSave()
  if g:strip_trainging_white_on_save == 1
    call s:StripTrailingWhite()
  endif
endfunction

function! s:StripTrailingWhiteOnSaveToggle()
  if g:strip_trainging_white_on_save == 0
    let g:strip_trainging_white_on_save = 1
    echo "Strip Trailing Whitespace On Save: Enabled"
  else
    let g:strip_trainging_white_on_save = 0
    echo "Strip Trailing Whitespace On Save: Disabled"
  endif
endfunction
command! StripTrailingWhiteOnSaveToggle call <SID>StripTrailingWhiteOnSaveToggle()

" Set this to true by default
let g:strip_trainging_white_on_save = 1

augroup StripTrailingWhite
  autocmd!
  autocmd BufWritePre *.{md,txt,rb,c,h,php,java,js,json,xml,xsl,vim} nested call s:StripTrailingWhiteOnSave()
augroup END
