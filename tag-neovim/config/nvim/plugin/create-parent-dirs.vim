" Create Parent Directories
"--------------------------

" Create directories if the parent directory for a
" file doesn't exist.
" from: http://stackoverflow.com/a/4294176/108857
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let l:dir=fnamemodify(a:file, ':h')
    if !isdirectory(l:dir)
      call mkdir(l:dir, 'p')
    endif
  endif
endfunction

augroup VimrcMakeParentDirs
  autocmd!
  autocmd BufWritePre * nested :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
