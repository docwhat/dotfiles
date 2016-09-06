let g:plug_shallow=0
call plug#begin()

augroup VimrcPlugins
  autocmd!
augroup END

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
Plug 'Shougo/deoplete.nvim' " :UpdateRemotePlugins
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
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'garyburd/go-explorer', { 'for': 'go', 'do': 'go get github.com/garyburd/go-explorer/src/getool' }

" Unite for NeoVim
function s:init_denite()
  if executable('ag')
    call denite#custom#source(
          \ 'file_rec', 'vars', {
          \   'command': [
          \      'ag', '--follow', '--nocolor', '--nogroup',
          \      '--hidden', '-g', ''
          \   ] })
  endif
endfunction
augroup VimrcPlugins
  autocmd VimEnter call s:init_denite()
augroup END
nnoremap <silent> <leader>t :Denite file_rec<cr>
" nnoremap <C-p> :Denite file_rec<cr>
Plug 'Shougo/denite.nvim' " :UpdateRemotePlugins

" Cursorline theme
let g:airline_powerline_fonts            = 1
let g:airline#extensions#tabline#enabled = 1
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Jellybeans theme
let g:jellybeans_overrides = {
      \    'LineNr': { 'guifg': '707090', 'ctermfg': '707090' },
      \    'CursorLineNr': { 'guifg': 'a0a0f0', 'ctermfg': 'a0a0f0' },
      \    'background': { 'guibg': 'none', 'ctermbg': 'none', '256ctermbg': 'none' },
      \}
Plug 'nanotech/jellybeans.vim'

" Gruvbox theme
let g:gruvbox_contrast_dark = "hard"
Plug 'morhetz/gruvbox'

call plug#end()

" EOF
