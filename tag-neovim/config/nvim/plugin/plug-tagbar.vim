" Tagbar
if !HasPlugin('tagbar')
  finish
endif

nnoremap <silent> <Leader>tb :TagbarToggle<CR>

let g:tagbar_type_typescript = {
      \   'ctagstype': 'typescript',
      \   'kinds': [
      \     'C:classes',
      \     'N:namespaces',
      \     'M:modules',
      \     'f:functions:1',
      \     'v:variables',
      \     'V:varlambdas',
      \     'm:members',
      \     'i:interfaces',
      \     't:types',
      \     'e:enums',
      \     'I:imports',
      \   ],
      \   'kind2scope' : {
      \     'e' : 'enums',
      \     'C' : 'classes',
      \     'N' : 'namespaces',
      \     'M' : 'modules',
      \     'i' : 'interfaces',
      \   },
      \   'scope2kind' : {
      \     'enums' : 'e',
      \     'classes' : 'C',
      \     'namespaces' : 'N',
      \     'modules' : 'M',
      \     'interfaces' : 'i',
      \   },
      \ }

if executable('gotags')
  let g:tagbar_type_go = {
        \   'ctagstype' : 'go',
        \   'kinds'     : [
        \     'p:package',
        \     'i:imports:1',
        \     'c:constants',
        \     'v:variables',
        \     't:types',
        \     'n:interfaces',
        \     'w:fields',
        \     'e:embedded',
        \     'm:methods',
        \     'r:constructor',
        \     'f:functions'
        \   ],
        \   'sro' : '.',
        \   'kind2scope' : {
        \     't' : 'ctype',
        \     'n' : 'ntype'
        \   },
        \   'scope2kind' : {
        \     'ctype' : 't',
        \     'ntype' : 'n'
        \   },
        \   'ctagsbin'  : 'gotags',
        \   'ctagsargs' : '-sort -silent',
        \ }
endif
