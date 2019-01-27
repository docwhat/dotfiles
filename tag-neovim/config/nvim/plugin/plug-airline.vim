scriptencoding utf-8

" Airline -- cursor line theme
if !HasPlugin('vim-airline')
  finish
endif

let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch    = "\ufb2b"
let g:airline_symbols.crypt     = "\uf023"
let g:airline_symbols.maxlinenr = "\ue0a1"
let g:airline_symbols.modified  = "\uf8ea"
let g:airline_symbols.notexists = "\uf79f"
let g:airline_symbols.readonly  = "\uf8ed"
let g:airline_symbols.spell     = "\uf9c5"

let g:airline#extensions#tabline#enabled =
      \ HasPlugin('vim-buffet') ? 0
      \ : 1
