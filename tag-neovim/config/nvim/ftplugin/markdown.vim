" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_markdown' | if exists(s:guard) | finish | endif

let s:editable = 1

" Programatic markdown buffers, such as :checkhealth
if &readonly || ! &modifiable || empty(bufname('%'))
  let s:editable = 0
endif

" Disable vim-sleuth
let b:sleuth_automatic = 0
setlocal tabstop=4
setlocal concealcursor= conceallevel=2
setlocal wrap linebreak nolist

if s:editable >= 1
  setlocal spell

  if has_key(g:plugs, 'ale')
    let b:ale_fixers = ['textlint', 'prettier']
    let b:ale_fix_on_save = 1

    let s:enabled_linters = deepcopy(ale#linter#Get('markdown'))
    let s:enabled_names = map(copy(s:enabled_linters), 'v:val[''name'']')

    let b:ale_linters = get(b:, 'ale_linters', {})
    let b:ale_linters['markdown'] = s:enabled_names

    if executable('vale')
      call filter(b:ale_linters['markdown'], { idx, val -> val != 'proselint' })
      call filter(b:ale_linters['markdown'], { idx, val -> val != 'writegood' })
      call filter(b:ale_linters['markdown'], { idx, val -> val != 'alex' })
    endif
    call filter(b:ale_linters['markdown'], { idx, val -> val != 'redpen' })
    call filter(b:ale_linters['markdown'], { idx, val -> val != 'mdl' })
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

let {s:guard} = 1 " EOF
