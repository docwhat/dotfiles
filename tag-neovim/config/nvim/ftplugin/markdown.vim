" Must be at the start
if exists('b:did_ftplugin_markdown')
  finish
endif

let s:editable = 1

" Programatic markdown buffers, such as :checkhealth
if &readonly || ! &modifiable || empty(bufname('%'))
  let s:editable = 0
endif

setlocal tabstop=4
setlocal concealcursor= conceallevel=1
setlocal wrap linebreak nolist

if s:editable >= 1
  setlocal spell

  if has_key(g:plugs, 'ale')
    let b:ale_fixers = ['prettier']
    let b:ale_fix_on_save = 1
  endif

  if has_key(g:plugs, 'ncm2')
    let b:ncm2_look_enabled = 1
  endif
else
  setlocal nospell

  if has_key(g:plugs, 'ale')
    ALEDisableBuffer
  endif
endif

" Must be last
let b:did_ftplugin_markdown = 1
