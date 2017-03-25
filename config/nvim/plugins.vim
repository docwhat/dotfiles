scriptencoding utf-8

call plug#begin(g:xdg_data_home . '/plugged')

" Usage: Plug 'blah', { 'do': function('DoRemotePluginsUpdate') }
function! DoRemotePluginsUpdate(arg)
  UpdateRemotePlugins
endfunction

" -- Utilities
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Support '.' correctly for plugins that support this module.
Plug 'tpope/vim-repeat'

" ds/cs/ys for deleting, changing, your surrounding chars (like ', ", etc.)
Plug 'tpope/vim-surround'

Plug 'tpope/vim-speeddating'

" Auto-pairing, including adding `end` to if statements.
Plug 'cohama/lexima.vim'

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

" Convert single line things to multi-line and back
"   gS - single -> multi
"   gJ - multi -> single
Plug 'AndrewRadev/splitjoin.vim'

" Whitespace trimming and highlighting
Plug 'ntpeters/vim-better-whitespace'

Plug 'metakirby5/codi.vim'
Plug 'justinmk/vim-dirvish'
Plug 'editorconfig/editorconfig-vim'

" Git & VCS support
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'
Plug 'tpope/vim-rhubarb'

" Comments
Plug 'scrooloose/nerdcommenter'

" Unite/Denite
Plug 'Shougo/denite.nvim', { 'do': function('DoRemotePluginsUpdate') }

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }

" Remote File Editing
Plug 'netrw.vim'

" Completion & Snippets
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemotePluginsUpdate') }
Plug 'docwhat/deoplete-better-length-matcher.nvim'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'zchee/deoplete-go'
Plug 'Shougo/deoplete-rct'
Plug 'fishbullet/deoplete-ruby'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'eagletmt/neco-ghc'
Plug 'zchee/deoplete-jedi'
Plug 'tweekmonster/deoplete-clang2'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs'
Plug 'zchee/deoplete-zsh'

" Style/Lint
Plug 'dbakker/vim-lint'
Plug 'neomake/neomake'
" Plug 'scrooloose/syntastic'


" Markdown
Plug 'tpope/vim-markdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'

" Javascript & JSON
Plug 'elzr/vim-json', {'for': ['javascript', 'json']}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'json']}

" XML, HTML & CSS
Plug 'othree/html5.vim'
" TODO: Use polyglot instead? It's a curated list of languages, syntaxes, and indentations.
" Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-ragtag'

" Show a facsimile of CSS colors as a highlight.
Plug 'chrisbra/color_highlight'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'
if exists('$RVM_PATH')
  Plug 'tpope/vim-rvm'
else
  Plug 'tpope/vim-rbenv'
endif

" Groovy
Plug 'vim-scripts/groovyindent-unix'

" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'garyburd/go-explorer', { 'for': 'go', 'do': 'go get github.com/garyburd/go-explorer/src/getool' }

" Rust
Plug 'rust-lang/rust.vim'

" Display
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nanotech/jellybeans.vim'

call plug#end()

" Surround
if has_key(g:plugs, 'vim-surround') " {{{
  let g:surround_no_insert_mappings=1
endif " }}}

" Tagbar
if has_key(g:plugs, 'tagbar') " {{{
  nnoremap <silent> <Leader>tb :TagbarToggle<CR>
endif " }}}

" Better Whitespace -- whitespace trimming and highlighting
if has_key(g:plugs, 'vim-better-whitespace') " {{{
  nmap <silent> <Leader><space> :StripWhitespace<CR>
  augroup VimrcBetterWhitespace
    autocmd!
    " autocmd FileType ruby,php,json,c,cpp,js,java,vim,html,xml,xsl let g:strip_whitespace_on_save = 0 | ToggleStripWhitespaceOnSave
    " FIXME: This should work instead of the above.
    autocmd FileType ruby,php,json,c,cpp,js,java,vim,html,xml,xsl :EnableStripWhitespaceOnSave
  augroup END
endif " }}}

" Codi -- Scratch Pad testing of various languages
if has_key(g:plugs, 'codi.vim') " {{{
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
  if executable('stack')
    let g:codi#interpreters['haskell'] = {
          \ 'bin': [ 'stack', 'ghci' ]
          \ }
  endif
  " let g:codi#log = "/tmp/codi.log"
endif " }}}

" Dirvish -- path navigator
if has_key(g:plugs, 'vim-dirvish') " {{{
  augroup VimrcDirvish
    autocmd!
    autocmd FileType dirvish call fugitive#detect(@%)
  augroup END
endif " }}}

" Committia -- Git commit message helper
if has_key(g:plugs, 'committia.vim') " {{{
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
endif " }}}

" NerdCommenter
if has_key(g:plugs, 'nerdcommenter') " {{{
  " Command and uncomment code easily
  " <leader>cc -- comment ragged style
  " <leader>cl -- comment aligned style
  " <leader>cu -- uncomment
  " <leader>ci -- toggle comments
  let g:NERDRemoveExtraSpaces=1
  let g:NERDSpaceDelims=1
  let g:NERDCommentWholeLinesInVMode=2
endif " }}}

" Denite
if has_key(g:plugs, 'denite.nvim') " {{{
  if executable('ag')
    call denite#custom#source(
          \ 'file_rec', 'vars', {
          \   'command': [
          \      'ag', '--follow', '--nocolor', '--nogroup',
          \      '--hidden', '-g', ''
          \   ] })
  endif
  nnoremap <silent> <leader>t :Denite file_rec<cr>
  " nnoremap <C-p> :Denite file_rec<cr>
endif " }}}

" Netrw -- Remote file editing
if has_key(g:plugs, 'netrw.vim') " {{{
  " :e dav://machine[:port]/path                  uses cadaver
  " :e http://[user@]machine/path                 uses http  uses wget
  " :e sftp://[user@]machine/path                 uses sftp
  " :e rsync://[user@]machine[:port]/path         uses rsync
  " :e scp://[user@]machine[[:#]port]/path        uses scp
  let g:netrw_home = g:xdg_data_home
  let g:netrw_silent = 1
endif " }}}

" Pandoc -- Markdown, Text, and HTML formatter/converter
if has_key(g:plugs, 'vim-pandoc') " {{{
  let g:pandoc#modules#disabled = ['chdir']
  let g:pandoc#folding#mode = 'stacked'
  let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
  let g:pandoc#formatting#mode = 'sa'
  let g:pandoc#formatting#equalprg = ''
  let g:pandoc#formatting#extra_equalprg = '--standalone'


  " autocmd FileType pandoc nested setlocal shiftwidth=4 softtabstop=4
  " autocmd FileType pandoc nested setlocal wrap linebreak nolist wrapmargin=0 textwidth=0 spell
  function! CaptureTextWidth()
    if &filetype ==# 'pandoc' && v:option_type ==# 'local'
      call SetPandocEqualPrg()
    endif
  endfunction
  autocmd OptionSet textwidth nested call CaptureTextWidth()

  function! SetPandocEqualPrg()
    let g:pandoc#formatting#equalprg = 'pandoc'
    let g:pandoc#formatting#textwidth = &textwidth
    if &textwidth > 0
      let g:pandoc#formatting#equalprg .= ' --to=markdown_github+yaml_metadata_block-hard_line_breaks --columns=' . &l:textwidth
    else
      let g:pandoc#formatting#equalprg .= ' --to=markdown_github+yaml_metadata_block --wrap=none'
    endif
    let &l:equalprg=g:pandoc#formatting#equalprg.' '.g:pandoc#formatting#extra_equalprg
    setlocal concealcursor= conceallevel=1
  endfunction

  augroup VimrcMarkdown
    autocmd!
    autocmd BufNewFile,BufReadPost *.{mdwn,mkd,md,markdown} nested setlocal filetype=pandoc
    autocmd FileType pandoc nested call SetPandocEqualPrg()
  augroup END
else
  augroup VimrcMarkdown
    autocmd!
    autocmd BufNewFile,BufRead *.{mdwn,mkd,md,markdown} nested setlocal filetype=markdown
    autocmd FileType markdown nested setlocal tabstop=4 shiftwidth=4 softtabstop=4 spell concealcursor= conceallevel=1 wrap linebreak nolist
  augroup END
endif " }}}

" WriteGood
if has_key(g:plugs, 'writegood.vim') " {{{
  augroup MarkdownPandoc
    autocmd!
    autocmd FileType markdown,pandoc :WritegoodEnable
  augroup END
endif " }}}

" Color Highlight -- Show CSS colors via highlights
if has_key(g:plugs, 'color_highlight') " {{{
  let g:colorizer_auto_filetype='css,scss,sass,html'
endif " }}}

" Ruby -- syntaxt and indentation (overrides built-in version)
if has_key(g:plugs, 'vim-ruby') " {{{
  let g:ruby_indent_block_style = 'do'
  let g:ruby_indent_assignment_style = 'variable'
endif " }}}

" Go -- GoLang syntax, indentation, and tools
if has_key(g:plugs, 'vim-go') " {{{
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_interfaces = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1

  let g:go_term_enabled = 1
  let g:go_list_type = 'quickfix'

  let g:go_fmt_command = 'goimports'
  let g:go_fmt_experimental = 1
  let g:go_fmt_autosave = 1

  let g:go_metalinter_autosave = 1
endif " }}}

" Rust -- rust syntax and indentation
if has_key(g:plugs, 'indentLine') " {{{
  let g:rustfmt_autosave = 1
endif
" }}}

" Indentline -- show indentation markers
if has_key(g:plugs, 'indentLine') " {{{
  let g:indentLine_char = '¦'
  let g:indentLine_setConceal = 0
endif " }}}

" Airplane -- cursor line theme
if has_key(g:plugs, 'jellybeans.vim') " {{{
  let g:airline_powerline_fonts            = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_left_sep=''
  let g:airline_right_sep=''
endif " }}}

" Jellybeans -- syntax theme
if has_key(g:plugs, 'jellybeans.vim') "{{{
  let g:jellybeans_overrides = {}
  let g:jellybeans_overrides['background']           = { 'guibg': 'none' }
  let g:jellybeans_overrides['LineNr']               = { 'attr': 'none', 'guifg': '707090', 'guibg': 'none'   }
  let g:jellybeans_overrides['CursorLineNr']         = { 'attr': 'none', 'guifg': 'a0a0f0', 'guibg': 'none'   }
  let g:jellybeans_overrides['IncSearch']            = { 'attr': 'none', 'guifg': '405060', 'guibg': 'ff8b0f' }
  let g:jellybeans_overrides['Search']               = { 'attr': 'none', 'guifg': '203040', 'guibg': 'f7ff0d' }

  let g:jellybeans_overrides['SyntasticWarningSign'] = { 'attr': 'none', 'guifg': 'ffdc00', 'guibg': '333333' }
  let g:jellybeans_overrides['SyntasticErrorSign']   = { 'attr': 'none', 'guifg': 'ff4136', 'guibg': '333333' }

  let g:jellybeans_overrides['NeomakeInfoSign']    = { 'attr': 'none', 'guifg': '00dcff', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeMessageSign']    = { 'attr': 'none', 'guifg': 'eeeeee', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeWarningSign'] = { 'attr': 'none', 'guifg': 'ffdc00', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeErrorSign']   = { 'attr': 'none', 'guifg': 'ff4136', 'guibg': '333333' }

  let g:jellybeans_overrides['NeomakeInfo']    = { 'attr': 'none', 'guifg': '0000ff', 'guibg': '333388' }
  let g:jellybeans_overrides['NeomakeMessage']    = { 'attr': 'none', 'guifg': 'ffffff', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeWarning'] = { 'attr': 'none', 'guifg': 'ffff00', 'guibg': '888833' }
  let g:jellybeans_overrides['NeomakeError']   = { 'attr': 'none', 'guifg': 'ff0000', 'guibg': '883333' }
endif "}}}

" EditorConfig -- Additional configuration
if has_key(g:plugs, 'editorconfig-vim') " {{{
  function! EditorConfigFiletypeHook(config)
    if has_key(a:config, 'vim_filetype')
      let &filetype = a:config['vim_filetype']
    endif

    return 0   " Return 0 to show no error happened
  endfunction
  call editorconfig#AddNewHook(function('EditorConfigFiletypeHook'))
endif " }}}

" Deoplete -- Additional configuration
if has_key(g:plugs, 'deoplete.nvim') " {{{
  call deoplete#custom#set('_', 'converters', [
        \ 'converter_remove_paren',
        \ 'converter_remove_overlap',
        \ 'converter_truncate_abbr',
        \ 'converter_truncate_menu',
        \ 'converter_auto_delimiter',
        \ ])
  call deoplete#custom#set('_', 'matchers', ['matcher_length', 'matcher_fuzzy'])
  call deoplete#custom#set('ultisnips', 'matchers', ['matcher_full_fuzzy'])


  let g:deoplete#enable_at_startup       = 1
  let g:deoplete#enable_smart_case       = 1
  let g:deoplete#enable_camel_case       = 1
  let g:deoplete#file#enable_buffer_path = 1

  let g:deoplete#sources                 = {}
  let g:deoplete#sources._               = []
  let g:deoplete#sources.ruby            = ['rct', 'ruby', 'ultisnips', 'around']
  let g:deoplete#sources.go              = ['go', 'around', 'ultisnips']
  let g:deoplete#sources.vim             = ['vim', 'around', 'file', 'ultisnips']
endif " }}}

" UltiSnips -- Snippets
if has_key(g:plugs, 'ultisnips') " {{{
  let g:UltiSnipsSnippetsDir         = g:xdg_config_home . '/snips'
  let g:UltiSnipsNoPythonWarning     = 1
  let g:UltiSnipsUsePythonVersion    = 3 " We always have python3 for deoplete.
  let g:UltiSnipsEditSplit           = 'vertical'

  let g:UltiSnipsListSnippets        = '<C-s>'
  let g:UltiSnipsExpandTrigger       = '<Tab>'
  let g:UltiSnipsJumpForwardTrigger  = '<Tab>'
  let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

  if filereadable(g:xdg_config_home . '/personalization.vim')
    execute 'source ' . g:xdg_config_home . '/personalization.vim'
  endif
  " You'll want to set these in ~/.config/nvim/personalization.vim
  " let g:snips_email="you@example.com"
  " let g.snips_author="Your Name Here"
  " let g.snips_github="https://github.com/your id here"
endif " }}}

" Neomake -- linting and building
if has_key(g:plugs, 'neomake') " {{{
  " Tools to install:
  "   - ruby:         rubocop reek
  "   - css:          stylelint csslint
  "   - vim:          vim-vint
  "   - python:       flake8
  "   - html:         tidy-html5 htmlhint
  "   - sh:           shellcheck checkbashisms
  "   - coffeescript: coffeelint
  "   - javascript:   eslint
  "   - perl:         perlcritic
  "   - lua:          luacheck
  "   - markdown:     proselint markdownlint(mdl)
  "   - yaml:         yamllint
  "
  " gem install rubocop reek mdl
  " npm install --global eslint csslint htmlhint coffeelint stylelint
  " write-good
  " brew install tidy-html5 shellcheck
  " pip3 install --upgrade vim-vint flake8 proselint yamllint jedi
  " cpanm Perl::Critic
  " luarocks install luacheck

  let g:neomake_verbose=0
  let g:neomake_warning_sign = { 'text': '', 'texthl': 'NeomakeWarningSign' }
  let g:neomake_error_sign   = { 'text': '', 'texthl': 'NeomakeErrorSign' }
  let g:neomake_message_sign = { 'text': '☛', 'texthl': 'NeomakeMessageSign' }
  let g:neomake_info_sign    = { 'text': 'ℹ︎', 'texthl': 'NeomakeInfoSign' }

  let g:neomake_sh_enabled_maker = neomake#makers#ft#sh#EnabledMakers() + [ 'checkbashisms' ]
  let g:neomake_sh_shellcheck_maker = neomake#makers#ft#sh#shellcheck()
  let g:neomake_sh_shellcheck_maker.args += ['-x']

  let g:neomake_ruby_rubocop_maker = neomake#makers#ft#ruby#rubocop()
  let g:neomake_ruby_rubocop_maker.args += ['--display-cop-names']

  function! s:myNeomake()
    if &readonly           | return | endif
    if ! &modifiable       | return | endif
    if !exists(':Neomake') | return | endif

    Neomake
  endfunction

  augroup VimrcNeomake
    autocmd!
    autocmd BufEnter *     call s:myNeomake()
    autocmd BufWritePost * call s:myNeomake()
    autocmd BufEnter Gemfile*,Guardfile let b:neomake_ruby_enabled_makers = ['mri', 'rubocop']
  augroup END
endif " }}}

" Syntastic -- linting
if has_key(g:plugs, 'syntastic') " {{{
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
endif " }}}

" vim: set foldminlines=0 foldmethod=marker :
