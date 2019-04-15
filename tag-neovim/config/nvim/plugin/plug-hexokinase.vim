scriptencoding utf-8

" Airline -- cursor line theme
if !HasPlugin('vim-hexokinase')
  finish
endif

let g:Hexokinase_ftAutoload = [
  \ 'css',
  \ 'html',
  \ 'js',
  \ 'jsx',
  \ 'scss',
  \ 'ts',
  \ 'tsx',
  \ 'vim',
  \ 'xml',
  \]
