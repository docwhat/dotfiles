let g:plug_shallow=0
call plug#begin()

augroup VimrcPlugins
  autocmd!
augroup END

" -- Utilities {{{
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

" Shows regions that were just yanked.
Plug 'machakann/vim-highlightedyank'

" Tags support; I recommend Universal Ctags
"   https://ctags.io/
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
nnoremap <silent> <Leader>tb :TagbarToggle<CR>

" Scratch pad for various languages.
Plug 'metakirby5/codi.vim'

" Dirvish, a path navigator
Plug 'justinmk/vim-dirvish'
autocmd FileType dirvish call fugitive#detect(@%)

" ---- Git & VCS support {{{
" Git helpers
Plug 'tpope/vim-fugitive'
" Better Git commit message editing
Plug 'rhysd/committia.vim'
" Deal with github in a sane way
" See https://github.com/tpope/vim-rhubarb
Plug 'tpope/vim-rhubarb'

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
  " Additional settings
  setlocal spell

  " If no commit message, start with insert mode
  if a:info.vcs ==# 'git' && getline(1) ==# ''
    startinsert
  end

  " Scroll the diff window from insert mode
  " Map <C-n> and <C-p>
  imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
  imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)

endfunction
" }}}
" ---- Comments {{{
" Command and uncomment code easily
" <leader>cc -- comment ragged style
" <leader>cl -- comment aligned style
" <leader>cu -- uncomment
" <leader>ci -- toggle comments
Plug 'scrooloose/nerdcommenter'
let g:NERDRemoveExtraSpaces=1
let g:NERDSpaceDelims=1
let g:NERDCommentWholeLinesInVMode=2

" }}}
" ---- Unite/Denite {{{
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
" }}}
" ---- Remote File Editing {{{
" Allows editing remote files.
"-----------------------------------------------------------------------------
" :e dav://machine[:port]/path                  uses cadaver
" :e fetch://[user@]machine/path                uses fetch
" :e ftp://[user@]machine[[:#]port]/path        uses ftp   autodetects <.netrc>
" :e http://[user@]machine/path                 uses http  uses wget
" :e rcp://[user@]machine/path                  uses rcp
" :e rsync://[user@]machine[:port]/path         uses rsync
" :e scp://[user@]machine[[:#]port]/path        uses scp
" :e sftp://[user@]machine/path                 uses sftp
Plug 'netrw.vim'

" }}}
" }}}

" -- Completion {{{
Plug 'Shougo/deoplete.nvim' " :UpdateRemotePlugins
let g:deoplete#enable_at_startup = 1
Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'Shougo/neco-syntax'
Plug 'zchee/deoplete-go', {'for': 'go'}
Plug 'fishbullet/deoplete-ruby', {'for': 'ruby'}

" }}}

" -- File Types {{{

" ---- Markdown {{{
"
Plug 'tpope/vim-markdown'
let g:pandoc#modules#disabled = ["chdir"]
let g:pandoc#folding#mode = "stacked"
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
let g:pandoc#formatting#mode = "sa"
let g:pandoc#formatting#equalprg = ""
let g:pandoc#formatting#extra_equalprg = "--standalone"
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'
augroup MarkdownPandoc
  autocmd!
  autocmd FileType markdown nested setlocal shiftwidth=4 softtabstop=4
  autocmd FileType markdown nested setlocal wrap linebreak nolist wrapmargin=0 textwidth=0 spell

  " autocmd FileType pandoc nested setlocal shiftwidth=4 softtabstop=4
  " autocmd FileType pandoc nested setlocal wrap linebreak nolist wrapmargin=0 textwidth=0 spell
  if has_key(g:plugs, 'vim-pandoc')
    function! CaptureTextWidth()
      if &filetype == "pandoc" && v:option_type == 'local'
        call SetPandocEqualPrg()
      endif
    endfunction
    autocmd OptionSet textwidth nested call CaptureTextWidth()

    function! SetPandocEqualPrg()
      let g:pandoc#formatting#equalprg = "pandoc"
      let g:pandoc#formatting#textwidth = &textwidth
      if &textwidth > 0
        let g:pandoc#formatting#equalprg .= " --to=markdown_github-hard_line_breaks --columns=" . &l:textwidth
      else
        let g:pandoc#formatting#equalprg .= " --to=markdown_github --wrap=none"
      endif
      let &l:equalprg=g:pandoc#formatting#equalprg." ".g:pandoc#formatting#extra_equalprg
      setlocal concealcursor= conceallevel=1
    endfunction

    autocmd BufNewFile,BufReadPost *.{mdwn,mkd,md,markdown} nested setlocal filetype=pandoc
    autocmd FileType pandoc nested call SetPandocEqualPrg()
  else
    autocmd BufNewFile,BufRead *.{mdwn,mkd,md,markdown} nested setlocal filetype=markdown
    autocmd FileType markdown nested setlocal tabstop=4 shiftwidth=4 softtabstop=4 spell concealcursor= conceallevel=1
  endif
augroup END
" }}}
" ---- Javascript & JSON {{{

Plug 'elzr/vim-json', {'for': ['javascript', 'json']}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'json']}

" }}}
" ---- Ruby {{{

Plug 'osyo-manga/vim-monster', { 'for': 'ruby' }

" }}}
" ---- GoLang {{{

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_term_enabled = 1
let g:go_list_type = "quickfix"

let g:go_fmt_command = "goimports"
let g:go_fmt_experimental = 1
let g:go_fmt_autosave = 1

let g:go_metalinter_autosave = 1

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'garyburd/go-explorer', { 'for': 'go', 'do': 'go get github.com/garyburd/go-explorer/src/getool' }

" }}}

" }}}

" -- Display, Color, & UI {{{

" ---- Indentation Columns {{{
" Display an indent line
Plug 'Yggdroot/indentLine'
let g:indentLine_char = "⋮"
let g:indentLine_noConcealCursor = 1

" }}}
" ---- Cursorline Colors {{{
let g:airline_powerline_fonts            = 1
let g:airline#extensions#tabline#enabled = 1
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" }}}
" ---- Jellybeans ColorScheme {{{

let g:jellybeans_overrides = {}
let g:jellybeans_overrides["background"]   = { "guibg": "none" }
let g:jellybeans_overrides["LineNr"]       = { "attr": "none", "guifg": "707090", "guibg": "none"   }
let g:jellybeans_overrides["CursorLineNr"] = { "attr": "none", "guifg": "a0a0f0", "guibg": "none"   }
let g:jellybeans_overrides["IncSearch"]    = { "attr": "none", "guifg": "405060", "guibg": "ff8b0f" }
let g:jellybeans_overrides["Search"]       = { "attr": "none", "guifg": "203040", "guibg": "f7ff0d" }

Plug 'nanotech/jellybeans.vim'

" }}}
" }}}

call plug#end()

" vim: set foldminlines=0 foldmethod=marker :
