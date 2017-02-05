call plug#begin(g:xdg_data_home . '/plugged')

" Usage: Plug 'blah', { 'do': function('DoRemotePluginsUpdate') }
function! DoRemotePluginsUpdate(arg)
  UpdateRemotePlugins
endfunction

augroup VimrcPlugins
  autocmd!
augroup END

" -- Utilities {{{
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

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

" Visualize the undo tree
Plug 'mbbill/undotree'

" Tags support; I recommend Universal Ctags
"   https://ctags.io/
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
nnoremap <silent> <Leader>tb :TagbarToggle<CR>

" Convert single line things to multi-line and back
"   gS - single -> multi
"   gJ - multi -> single
Plug 'AndrewRadev/splitjoin.vim'

" Whitespace trimming and highlighting
Plug 'ntpeters/vim-better-whitespace'
nmap <silent> <Leader><space> :StripWhitespace<CR>
autocmd FileType ruby,php,json,c,cpp,js,java,vim,html,xml,xsl let g:strip_whitespace_on_save = 0 | ToggleStripWhitespaceOnSave
" After https://github.com/ntpeters/vim-better-whitespace/pull/55 is accepted:
" autocmd FileType ruby,php,json,c,cpp,js,java,vim,html,xml,xsl autocmd BufEnter <buffer> EnableStripWhitespaceOnSave

" Scratch pad for various languages.
Plug 'metakirby5/codi.vim'
let g:codi#interpreters = {
      \   'bash': {
      \     'bin': [ 'env',
      \              'PS1=\!> ', 'PS2=-> ', 'PS3=', 'PS4=+> ',
      \              'HISTFILE=', 'SHELL=bash',
      \              'bash', '-s' ],
      \     'prompt': '^[^>]*> ',
      \     'rightalign': 0,
      \   }
      \ }
" let g:codi#log = "/tmp/codi.log"

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
Plug 'Shougo/denite.nvim', { 'do': function('DoRemotePluginsUpdate') }
" }}}
" ---- Remote File Editing {{{
" Allows editing remote files.
"-----------------------------------------------------------------------------
" :e dav://machine[:port]/path                  uses cadaver
" :e http://[user@]machine/path                 uses http  uses wget
" :e sftp://[user@]machine/path                 uses sftp
" :e rsync://[user@]machine[:port]/path         uses rsync
" :e scp://[user@]machine[[:#]port]/path        uses scp
let g:netrw_home = g:xdg_data_home
let g:netrw_silent = 1
Plug 'netrw.vim'

" }}}
" }}}

" -- Completion {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#file#enable_buffer_path=1

let g:deoplete#sources={}
let g:deoplete#sources._    = []
let g:deoplete#sources.ruby = ['rct', 'ruby', 'buffer']
let g:deoplete#sources.go = ['go', 'around']
let g:deoplete#sources.vim = ['vim', 'buffer', 'file']

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemotePluginsUpdate') }
" VimL/Vimscript
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
" Go
Plug 'zchee/deoplete-go', {'for': 'go'}
" Ruby
" See https://github.com/Shougo/deoplete-rct/pull/1
Plug 'Shougo/deoplete-rct'
Plug 'fishbullet/deoplete-ruby'

" }}}

" -- Syntax/Lint {{{

Plug 'scrooloose/syntastic'
Plug 'dbakker/vim-lint'

let g:syntastic_warning_symbol            = ''
let g:syntastic_error_symbol              = ''
let g:syntastic_style_warning_symbol      = ''
let g:syntastic_style_error_symbol        = ''

let g:syntastic_always_populate_loc_list  = 1
let g:syntastic_auto_loc_list             = 1 " Close the location-list when errors are gone
let g:syntastic_loc_list_height           = 5
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_sh_checkers               = ['shellcheck', 'checkbashisms', 'sh']
let g:syntastic_sh_checkbashisms_args     = '--extra' " Turn off the --force flag
let g:syntastic_sh_shellcheck_args        = '--external-sources' " Follow sources/dependencies explicitly added
let g:syntastic_ruby_checkers             = ['mri', 'jruby', 'rubocop']
if executable('rubocop-workaround.sh')
  let g:syntastic_ruby_rubocop_exec       = 'rubocop-workaround.sh'
endif
let g:syntastic_ruby_rubocop_args         = '--display-cop-names'
let g:syntastic_eruby_ruby_quiet_messages = {'regex': 'possibly useless use of a variable in void context'}
let g:syntastic_scss_checkers             = ['sass']
let g:syntastic_sass_checkers             = ['sass']
let g:syntastic_python_checkers           = ['python', 'flake8', 'pep8', 'pylint']
let g:syntastic_chef_checkers             = [''] " I'm sick of foodcritic
let g:syntastic_xml_checkers              = ['xmllint']
let g:syntastic_xslt_checkers             = ['xmllint']
let g:syntastic_html_tidy_ignore_errors = [ '<link> proprietary attribute "integrity"', '<link> proprietary attribute "crossorigin"' ]
" npm install js-yaml
let g:syntastic_yaml_checkers             = ['jsyaml']
let g:syntastic_go_checkers               = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map                  = { 'mode': 'active', 'passive_filetypes': ['go'] }

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

" Rails, bundler, etc.
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'

" Get me some RVM/Rbenv support
if exists("$RVM_PATH")
  Plug 'tpope/vim-rvm'
else
  Plug 'tpope/vim-rbenv'
endif

" }}}
" ---- Groovy {{{

Plug 'vim-scripts/groovyindent-unix'

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
" ---- Rust {{{

let g:rustfmt_autosave = 1
Plug 'rust-lang/rust.vim'

" }}}

" }}}

" -- Display, Color, & UI {{{

" ---- Indentation Columns {{{
" Display an indent line
Plug 'Yggdroot/indentLine'
" let g:indentLine_char = "│"
let g:indentLine_char = "¦"
let g:indentLine_setConceal = 0

" }}}
" ---- Cursorline Colors {{{
let g:airline_powerline_fonts            = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" }}}
" ---- Jellybeans ColorScheme {{{

let g:jellybeans_overrides = {}
let g:jellybeans_overrides["background"]           = { "guibg": "none" }
let g:jellybeans_overrides["LineNr"]               = { "attr": "none", "guifg": "707090", "guibg": "none"   }
let g:jellybeans_overrides["CursorLineNr"]         = { "attr": "none", "guifg": "a0a0f0", "guibg": "none"   }
let g:jellybeans_overrides["IncSearch"]            = { "attr": "none", "guifg": "405060", "guibg": "ff8b0f" }
let g:jellybeans_overrides["Search"]               = { "attr": "none", "guifg": "203040", "guibg": "f7ff0d" }

let g:jellybeans_overrides["SyntasticWarningSign"] = { "attr": "none", "guifg": "ffdc00", "guibg": "333333" }
let g:jellybeans_overrides["SyntasticErrorSign"]   = { "attr": "none", "guifg": "ff4136", "guibg": "333333" }

Plug 'nanotech/jellybeans.vim'

" }}}
" }}}

call plug#end()

" vim: set foldminlines=0 foldmethod=marker :
