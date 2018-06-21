" my filetype file
if exists('did_load_filetypes')
  finish
endif

function! s:detectChefSubFileType()
  let l:gitroot = systemlist('git rev-parse --show-toplevel')[0]
  if l:gitroot ==# '' | return | endif
  if filereadable(l:gitroot . '/metadata.rb')
    let &filetype = &filetype . '.chef'
  endif
endfunction

augroup filetypedetect
  autocmd!

  " Common JSON conf files.
  autocmd BufRead,BufNewFile .prettierrc,.babelrc,.eslintrc,.jscsrc setfiletype json


  " Chef
  autocmd FileType ruby,eruby call s:detectChefSubFileType()
augroup END
