let g:plug_shallow=0
call plug#begin()

" Support '.' correctly for plugins that support this module.
Plug 'tpope/vim-repeat'

" ds/cs/ys for deleting, changing, your surrounding chars (like ', ", etc.)
Plug 'tpope/vim-surround'

" Allow C-A/C-X to work correctly with dates/times.
Plug 'tpope/vim-speeddating'

" Adds matching 'end*' type syntax for ruby, vimscript, and lua
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-abolish'

" Detect indentation
Plug 'tpope/vim-sleuth'

" Allow chording 'jk' as a replacement for ESC
Plug 'kana/vim-arpeggio'

" lets you align comments, equal signs, etc.
Plug 'godlygeek/tabular'

" Allows editing remote files.
" :e dav://machine[:port]/path                  uses cadaver
" :e fetch://[user@]machine/path                uses fetch
" :e ftp://[user@]machine[[:#]port]/path        uses ftp   autodetects <.netrc>
" :e http://[user@]machine/path                 uses http  uses wget
" :e rcp://[user@]machine/path                  uses rcp
" :e rsync://[user@]machine[:port]/path         uses rsync
" :e scp://[user@]machine[[:#]port]/path        uses scp
" :e sftp://[user@]machine/path                 uses sftp
Plug 'netrw.vim'

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

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'Shougo/neco-syntax'
Plug 'zchee/deoplete-go', {'for': 'go'}
Plug 'fishbullet/deoplete-ruby', {'for': 'ruby'}

" Javascript & JSON
Plug 'elzr/vim-json', {'for': ['javascript', 'json']}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'json']}

" Ruby
Plug 'osyo-manga/vim-monster', { 'for': 'ruby' }

" GoLang
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'garyburd/go-explorer', { 'for': 'go', 'do': 'go get github.com/garyburd/go-explorer/src/getool' }

" Cursorline theme
let g:airline_powerline_fonts            = 1
let g:airline_theme                      = 'badwolf'
let g:airline#extensions#tabline#enabled = 1
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Jellybeans
let g:jellybeans_background_color="000000"
let g:jellybeans_background_color_256=232
let g:jellybeans_overrides={}
let g:jellybeans_overrides.LineNr  = {
                  \ '256ctermfg': 59,
                  \ '256ctermbg': 233
                  \}
Plug 'nanotech/jellybeans.vim'

call plug#end()

" EOF
