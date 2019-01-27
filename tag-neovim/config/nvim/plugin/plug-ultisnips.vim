if !HasPlugin('ultisnips')
  finish
endif
" README
"
" To use the snippets fully, you will need to set these values:
"
"   let g:snips_email='you@example.com'
"   let g.snips_author='Your Name Here'
"   let g.snips_github='https://github.com/your-id-here'
"
" You can do this via a plugin file like:
" ~  /.config/nvim/plugin/personalization.vim

let g:UltiSnipsSnippetDirectories  = ['UltiSnips', 'snips']
let g:UltiSnipsNoPythonWarning     = 1
let g:UltiSnipsUsePythonVersion    = 3
let g:UltiSnipsEditSplit           = 'vertical'

let g:UltiSnipsListSnippets        = '<C-s>'
let g:UltiSnipsExpandTrigger       = '<Tab>'
let g:UltiSnipsJumpForwardTrigger  = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

" " c-j c-k for moving in snippet
" imap <expr> <c-u> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand)", 'm')
" smap <c-u> <Plug>(ultisnips_expand)
" let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
" let g:UltiSnipsRemoveSelectModeMappings = 0

" Needed for some snippets
if !exists('*Filename')
  function Filename(...)
    let l:filename = expand('%:t:r')
    if l:filename ==# '' | return a:0 == 2 ? a:2 : '' | endif
    return !a:0 || a:1 ==# '' ? l:filename : substitute(a:1, '$1', l:filename, 'g')
  endfunction
endif
