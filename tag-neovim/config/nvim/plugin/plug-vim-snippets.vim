if !HasPlugin('vim-snippets')
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

" Needed for some snippets
if !exists('*Filename')
  function Filename(...)
    let l:filename = expand('%:t:r')
    if l:filename ==# '' | return a:0 == 2 ? a:2 : '' | endif
    return !a:0 || a:1 ==# '' ? l:filename : substitute(a:1, '$1', l:filename, 'g')
  endfunction
endif
