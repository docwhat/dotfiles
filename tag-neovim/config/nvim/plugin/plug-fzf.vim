" FZF
if !HasPlugin('fzf.vim')
  finish
end

  function! MyGFilesOrFiles()
    if empty(GetGitRoot())
      :Files
    else
      :GFiles
    endif
  endfunction

  let g:fzf_buffers_jump = 1
  nnoremap <silent> <leader>p :call MyGFilesOrFiles()<CR>
  nnoremap <silent> <leader>b :Buffers<CR>

  " Mapping selecting mappings
  nmap <leader><tab> <plug>(fzf-maps-n)
  xmap <leader><tab> <plug>(fzf-maps-x)
  omap <leader><tab> <plug>(fzf-maps-o)

  " Insert mode completion
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)

  " Advanced customization using autoload functions
  inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
