let g:plug_shallow=0
call plug#begin()

" Asynch support for vim
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Support '.' correctly for plugins that support this module.
Plug 'tpope/vim-repeat'

" ds/cs/ys for deleting, changing, your surrounding chars (like ', ", etc.)
Plug 'tpope/vim-surround'

" Allow C-A/C-X to work correctly with dates/times.
Plug 'tpope/vim-speeddating'

" Allow chording 'jk' as a replacement for ESC
Plug 'kana/vim-arpeggio'

" lets you align comments, equal signs, etc.
Plug 'godlygeek/tabular'

" Display an indent line
Plug 'Yggdroot/indentLine'
let g:indentLine_char = "⋮"
let g:indentLine_noConcealCursor = 1

" Command and uncomment code easily
" <leader>cc -- comment ragged style
" <leader>cl -- comment aligned style
" <leader>cu -- uncomment
" <leader>ci -- toggle comments
Plug 'scrooloose/nerdcommenter'
let g:NERDRemoveExtraSpaces=1
let g:NERDSpaceDelims=1
let g:NERDCommentWholeLinesInVMode=2

Plug 'Shougo/unite.vim'

" Cursorline theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts            = 1
let g:airline_theme                      = 'jellybeans'
let g:airline#extensions#tabline#enabled = 1

" Jellybeans
Plug 'nanotech/jellybeans.vim'
let g:jellybeans_background_color="000000"
let g:jellybeans_background_color_256=232
let g:jellybeans_overrides={}
let g:jellybeans_overrides.LineNr  = {
  \ '256ctermfg': 59,
  \ '256ctermbg': 233
  \}

call plug#end()

" EOF
