scriptencoding utf-8

" Airline -- cursor line theme
if !HasPlugin('vim-airline')
  finish
endif

let g:airline_powerline_fonts            = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
