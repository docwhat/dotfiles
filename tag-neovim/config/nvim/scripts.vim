echomsg 'scripts.vim ' . did_filetype()

if did_filetype()
  finish
endif

" if getline(1) =~ '^#!.*\<mine\>'
"   setfiletype mine
" elseif getline(1) =~? '\<drawing\>'
"   setfiletype drawing
" endif
" function! s:detectChefSubFileType()
"   let l:gitroot = systemlist('git rev-parse --show-toplevel')[0]
"   if l:gitroot ==# '' | return | endif
"   if filereadable(l:gitroot . '/metadata.rb')
"     let &filetype = &filetype . '.chef'
"   endif
" endfunction

" autocmd FileType ruby,eruby call s:detectChefSubFileType()
