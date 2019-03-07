" Indent whole file
function! s:SmartIndentWholeBufferIfEnabled() " abort
  let l:buffer = bufnr('')

  if HasPlugin('ale')
    let l:fixers = ale#Var(l:buffer, 'fixers')

    call filter(l:fixers,
          \ 'v:val !=# "remove_trailing_lines"')
    call filter(l:fixers,
          \ 'v:val !=# "trim_whitespace"')

    call ale#fix#Fix(l:buffer, '')
    if len(l:fixers) > 0
      return
    endif
  endif

  if HasPlugin('coc.nvim')
    call CocAction('format')
  elseif exists('*LCformatting_sync')
    try
      let l:did_it_work = LCformatting_sync()
      if l:did_it_work
        return
      endif
    catch " Ignore errors
    endtry
  endif

  call Preserve('normal gg=G')
endfunction

map <unique> <Plug>SmartIndentWholeBufferIfEnabled
      \ :<C-U>call <SID>SmartIndentWholeBufferIfEnabled()<CR>
