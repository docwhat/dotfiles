" my filetype file
if exists('did_load_filetypes')
  finish
endif

function! s:inChef()
  let l:gitroot = GetGitRoot()
  if l:gitroot ==# '' | return v:false | endif
  return filereadable(l:gitroot . '/metadata.rb')
endfunction

function! s:detectChefSubFileType()
  if !s:inChef() | return | endif
  if &filetype !=# 'ruby' | return | endif

  let &filetype = &filetype . '.chef'
endfunction

augroup filetypedetect
  autocmd!

  " Common JSON conf files.
  autocmd BufRead,BufNewFile .prettierrc,.babelrc,.eslintrc,.jscsrc setfiletype json

  " Chef
  autocmd FileType ruby,eruby call s:detectChefSubFileType()

  " React
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx

  " BATS
  autocmd BufNewFile,BufRead *.bats set filetype=bats
augroup END
