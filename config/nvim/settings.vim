" Misc. Builtin Settings {{{
scriptencoding utf-8

if has('filterpipe')
  set noshelltemp
endif

if !has('nvim-0.2')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  " https://github.com/neovim/neovim/wiki/Following-HEAD#20170402
endif

set mouse=a

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set hidden
set modeline

set shiftround

set linebreak                    " Only wrap on characters in `breakat`
let &showbreak = '↳ '

set ignorecase
set smartcase
if exists('&inccommand')
  set inccommand=split
endif

set completeopt=menu,menuone,noselect,preview

set number
" set wildmode=list:longest,full   " Completion for wildchar (see help)
set wildignore+=*.o,*.obj,*.pyc,*.pyo,*.pyd,*.class,*.lock
set wildignore+=*.png,*.gif,*.jpg,*.ico
set wildignore+=.git,.svn,.hg

set showmatch                    " Show the matching bracket
set matchpairs=(:),{:},[:]       " List of characters we expect in balanced pairs

set cursorline                   " highlights the current line
set conceallevel=2
set concealcursor=

if has('patch-7.4.1570')
  set shortmess+=F
endif

" undo persist between sessions
set undofile

" Backups
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory(g:xdg_data_home . '/backup') == 0
  execute 'silent !mkdir -p ' . g:xdg_data_home . '/backup >/dev/null 2>&1'
endif
set backupdir-=.
set backupdir+=.
execute 'set backupdir^=' . g:xdg_data_home . '/backup'
set backupdir^=./.vim-backup
set backup
augroup VimrcBackups
  autocmd!
  autocmd BufWritePre * let &backupext = '-' . substitute(expand('%:p:h'), '/', '%', 'g') . '~'
augroup END

" Folds
set foldminlines=4

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set scrolloff=5       " don't scroll any closer to top/bottom
set sidescrolloff=5   " don't scroll any closer to left/right

set path+=**

augroup VimrcShada
  autocmd!
  autocmd CursorHold,FocusGained,FocusLost * rshada|wshada
augroup END

" }}}

" Spelling {{{
set spelllang=en_us " This is lowercase for some reason.
set spellsuggest=file:~/.config/nvim/spell/suggestions,best,10
set spellfile=~/.config/nvim/spell/personal.utf-8.add
if ! filereadable(&spellfile . '.spl')
  silent execute 'mkspell ' . &spellfile
endif
" }}}

" Netrw -- Remote file editing
"-----------------------------------------------------------------------------
" :e dav://machine[:port]/path                  uses cadaver
" :e http://[user@]machine/path                 uses http  uses wget
" :e sftp://[user@]machine/path                 uses sftp
" :e rsync://[user@]machine[:port]/path         uses rsync
" :e scp://[user@]machine[[:#]port]/path        uses scp
let g:netrw_home = g:xdg_data_home
let g:netrw_silent = 1

" Themes/Colors
"-----------------------------------------------------------------------------
if exists('+termguicolors')
  set termguicolors
elseif exists('+guicolors')
  set guicolors
endif
colorscheme jellybeans
call airline#switch_theme('badwolf')
set background=dark

" Smash escape!
"-----------------------------------------------------------------------------
augroup VimrcSmashEscape
  autocmd!
  autocmd VimEnter * Arpeggio inoremap jk  <Esc>
augroup END

" Terminal
" -----------------------------------------------------------------------------
augroup VimrcTerminal
  autocmd!
  autocmd TermOpen * let g:last_terminal_job_id = b:terminal_job_id | IndentLinesDisable
  autocmd WinEnter term://* startinsert | IndentLinesDisable
  "autocmd TermClose * exec &buftype == 'terminal' ? 'bd!' :  ''
  autocmd TermClose * exe expand('<abuf>').'bd!'
augroup END

" GitCommits
"
augroup VimrcGit
  autocmd!
  autocmd FileType gitcommit setlocal spell
  if has_key(g:plugs, 'vim-pandoc')
    autocmd VimEnter .git/PULLREQ_EDITMSG setlocal filetype=pandoc spell
  else
    autocmd VimEnter .git/PULLREQ_EDITMSG setlocal filetype=markdown spell
  endif
augroup END

" Save Cursor Positions
"-----------------------------------------------------------------------------
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
augroup VimrcSaveCursorPosition
  autocmd!
  autocmd BufReadPost * nested
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" Prevent highlight being lost on (de)indent.
"-----------------------------------------------------------------------------
xnoremap < <gv
xnoremap > >gv

" I really need control-a and control-e (emacs) in command mode.
"-----------------------------------------------------------------------------
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" %% in command mode will expand to the directory name.
"-----------------------------------------------------------------------------
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Indent whole file
"-----------------------------------------------------------------------------
nmap <silent> <Leader>g :call Preserve("normal gg=G")<CR>

" Turn off highlights
"-----------------------------------------------------------------------------
" Since C-l is now window navigation, use Leader-h
" to redraw (and hide highlighted search).
nnoremap <silent> <Leader>h :nohlsearch<CR><C-L>

" Get Jared and Selker to use hjkl instead of cursor keys...
"-----------------------------------------------------------------------------
nnoremap <Left>  :echoerr "I don't like that direction... try 'h' instead."<cr>
nnoremap <Right> :echoerr "Republican, eh? I prefer 'l'."<cr>
nnoremap <Up>    :echoerr "This is why we can't have nice things. You should have used 'k'."<cr>
nnoremap <Down>  :echoerr "That's what she said... and then used 'j'."<cr>

" Comment Strings -- Override some lame defaults
"-----------------------------------------------------------------------------
augroup VimrcCommentStrings
  autocmd!
  autocmd FileType vim set commentstring=\ \"\ %s
augroup END


" Manpages and :help
"-----------------------------------------------------------------------------
function! ILikeHelpToTheRight()
  if !exists('w:help_is_moved') || w:help_is_moved !=# 'right'
    wincmd L
    let w:help_is_moved = 'right'
  endif
endfunction

let g:real_manpager=$MANPAGER
let g:ft_man_folding_enable = 1

augroup VimrcManpagesAndHelp
  autocmd!
  autocmd FileType help     nested call ILikeHelpToTheRight()
  autocmd FileType man,help nested nnoremap <buffer> q :q!<cr>
  autocmd FileType man      nested let &listchars=""
  autocmd FileType man      nested let $MANPAGER=g:real_manpager " Prevent recursive calls.
  autocmd FileType man      nested set foldminlines=20
augroup END

" Create Parent Directories
"-----------------------------------------------------------------------------
" Create directories if the parent directory for a
" file doesn't exist.
" from: http://stackoverflow.com/a/4294176/108857
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let l:dir=fnamemodify(a:file, ':h')
    if !isdirectory(l:dir)
      call mkdir(l:dir, 'p')
    endif
  endif
endfunction

augroup VimrcMakeParentDirs
  autocmd!
  autocmd BufWritePre * nested :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" Surround
if has_key(g:plugs, 'vim-surround') " {{{
  let g:surround_no_insert_mappings=1
endif " }}}

" Tagbar
if has_key(g:plugs, 'tagbar') " {{{
  nnoremap <silent> <Leader>tb :TagbarToggle<CR>
endif " }}}

" TweekMonster's WStrip -- whitespace trimming and highlighting for
" only changed lines.
if has_key(g:plugs, 'wstrip.vim') " {{{
  nmap <silent> <Leader><space> :WStrip<CR>
  augroup VimrcWStrip
    autocmd!
    autocmd FileType ruby,php,json,c,cpp,js,java,vim,html,xml,xsl let b:wstrip_auto = 1
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
  nnoremap <silent> <leader>p :Denite file_rec<cr>
  " nnoremap <C-p> :Denite file_rec<cr>
endif " }}}

" Pandoc -- Markdown, Text, and HTML formatter/converter
if has_key(g:plugs, 'vim-pandoc') " {{{
  let g:pandoc#modules#disabled = ['chdir']
  let g:pandoc#folding#fold_yaml = 1
  let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
  let g:pandoc#formatting#mode = 'sa'
  let g:pandoc#formatting#equalprg = ''
  let g:pandoc#formatting#extra_equalprg = '--standalone'
  let g:pandoc#formatting#textwidth = 76

  function! MyCaptureMarkdownOptions()
    if &filetype ==# 'pandoc' || &filetype ==# 'markdown'
      let l:pandoc_to='markdown_github+yaml_metadata_block+smart'
      let g:pandoc#formatting#equalprg = 'pandoc'
      let g:pandoc#formatting#textwidth = &textwidth

      if !exists('b:my_pandoc_disable_footnotes')
        let b:my_pandoc_disable_footnotes = 0
      endif
      if !exists('b:my_pandoc_reference_links')
        let b:my_pandoc_reference_links = 0
      endif

      if !b:my_pandoc_disable_footnotes
        let l:pandoc_to.='+footnotes+inline_notes'
      endif

      if &textwidth > 0
        let g:pandoc#formatting#equalprg .= ' --to='.l:pandoc_to.'-hard_line_breaks --columns=' . &textwidth
      else
        let g:pandoc#formatting#equalprg .= ' --to='.l:pandoc_to.' --wrap=none'
      endif

      if b:my_pandoc_reference_links || expand('%:t:r') ==# 'CHANGELOG'
        let g:pandoc#formatting#equalprg .= ' --reference-links'
      endif

      let &l:equalprg=g:pandoc#formatting#equalprg.' '.g:pandoc#formatting#extra_equalprg
      setlocal concealcursor= conceallevel=1
    endif
  endfunction

  augroup VimrcPandoc
    autocmd!
    autocmd OptionSet textwidth nested :call MyCaptureMarkdownOptions()
    autocmd BufEnter * nested :call MyCaptureMarkdownOptions()
    if has_key(g:plugs, 'editorconfig-vim')
      autocmd FileType pandoc,markdown :EditorConfigReload
    endif
    autocmd FileType pandoc,markdown normal zR
  augroup END
else
  augroup VimrcMarkdown
    autocmd!
    autocmd BufNewFile,BufRead *.{mdwn,mkd,md,markdown} nested setlocal filetype=markdown
    autocmd FileType markdown nested setlocal tabstop=4 shiftwidth=4 softtabstop=4 spell concealcursor= conceallevel=1 wrap linebreak nolist
  augroup END
endif " }}}

if has_key(g:plugs, 'vim-markdown') " {{{
  let g:markdown_github_languages = ['ruby', 'erb=eruby', 'sh']
endif " }}}

" WriteGood
if has_key(g:plugs, 'writegood.vim') " {{{
  augroup VimrcWritegood
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
if has_key(g:plugs, 'Jenkinsfile-vim-syntax') " {{{
  augroup VimrcJenkinsfile
    autocmd!
    autocmd BufRead,BufNewFile Ghenkinsfile  nested setlocal filetype=Jenkinsfile
    autocmd BufRead,BufNewFile Ghenkinsfile* nested setfiletype Jenkinsfile
  augroup END
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
  let g:jellybeans_overrides['NeomakeMessageSign'] = { 'attr': 'none', 'guifg': 'eeeeee', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeWarningSign'] = { 'attr': 'none', 'guifg': 'ffdc00', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeErrorSign']   = { 'attr': 'none', 'guifg': 'ff4136', 'guibg': '333333' }

  let g:jellybeans_overrides['NeomakeInfo']        = { 'attr': 'none', 'guifg': '0000ff', 'guibg': '333388' }
  let g:jellybeans_overrides['NeomakeMessage']     = { 'attr': 'none', 'guifg': 'ffffff', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeWarning']     = { 'attr': 'none', 'guifg': 'ffff00', 'guibg': '888833' }
  let g:jellybeans_overrides['NeomakeError']       = { 'attr': 'none', 'guifg': 'ff0000', 'guibg': '883333' }
endif "}}}

" EditorConfig -- Additional configuration
if has_key(g:plugs, 'editorconfig-vim') " {{{
  function! EditorConfigFiletypeHook(config)
    if exists('g:myvim_editor_config_filetype_hook') && g:myvim_editor_config_filetype_hook > 0
      return 0
    endif
    let g:myvim_editor_config_filetype_hook = 1
    if has_key(a:config, 'vim_filetype')
      let &filetype = a:config['vim_filetype']
    endif

    if has_key(g:plugs, 'vim-pandoc')
      for l:opt in ['reference_links', 'disable_footnotes']
        if has_key(a:config, 'pandoc_' . l:opt)
          execute ':let b:my_pandoc_' . l:opt .' = a:config["pandoc_' . l:opt .'"] ==? "true"'
        else
          execute ':let b:my_pandoc_' . l:opt .' = 0'
        endif
      endfor

      :call MyCaptureMarkdownOptions()
    endif

    let g:myvim_editor_config_filetype_hook = 0
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

  " <CR>: close popup and save indent.
  if has_key(g:plugs, 'lexima.vim')
    " Lexima conflicts with Deoplete and remapping <CR>
    " https://github.com/cohama/lexima.vim/issues/65
    let g:lexima_no_default_rules = 1
    call lexima#set_default_rules()
    call lexima#insmode#map_hook('before', '<CR>', '')

    function! s:my_cr_function() abort
      return pumvisible() ? deoplete#smart_close_popup() . "\<CR>" : lexima#expand('<CR>', 'i')
    endfunction
  else
    function! s:my_cr_function() abort
      return deoplete#smart_close_popup() . "\<CR>"
    endfunction
  endif
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

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
  "
  " Needed for some snippets
  if !exists('*Filename')
    function! Filename(...)
      let l:filename = expand('%:t:r')
      if l:filename ==# '' | return a:0 == 2 ? a:2 : '' | endif
      return !a:0 || a:1 ==# '' ? l:filename : substitute(a:1, '$1', l:filename, 'g')
    endfunction
  endif
endif " }}}

" Neoformat -- forced formatting
if has_key(g:plugs, 'neoformat') " {{{
  " Enable alignment
  let g:neoformat_basic_format_align = 1

  " Enable tab to spaces conversion
  let g:neoformat_basic_format_retab = 1

  " Enable trimmming of trailing whitespace
  let g:neoformat_basic_format_trim = 1

  " Only complain if there is an error
  " let g:neoformat_only_msg_on_error = 1

  let g:neoformat_markdown_prettier = neoformat#formatters#markdown#prettier()
  let g:neoformat_markdown_prettier.args += ['--parser=markdown', '--prose-wrap=always']

  augroup VimrcNeoformat
    autocmd!
    autocmd BufWritePre *.css,*.csv,*.html,*.js,*.jsx,*.json,*.less,*.lua,*.md,*.py,*.scss*.sh,*.xml,*.yml,*.yaml undojoin | Neoformat
  augroup END
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
  let g:neomake_error_sign   = { 'text': '', 'texthl': 'NeomakeErrorSign' }
  let g:neomake_message_sign = { 'text': '', 'texthl': 'NeomakeMessageSign' }
  let g:neomake_info_sign    = { 'text': '', 'texthl': 'NeomakeInfoSign' }

  let g:neomake_sh_enabled_makers = neomake#makers#ft#sh#EnabledMakers() + [ 'checkbashisms' ]
  let g:neomake_zsh_enabled_makers = neomake#makers#ft#zsh#EnabledMakers()
  let g:neomake_sh_bats_enabled_makers = []

  let g:neomake_sh_shellcheck_maker = neomake#makers#ft#sh#shellcheck()
  let g:neomake_sh_shellcheck_maker.args += ['-x']

  let g:neomake_sh_checkbashisms_maker = neomake#makers#ft#sh#checkbashisms()
  let g:neomake_sh_checkbashisms_maker.args = ['-x']

  let g:neomake_ruby_enabled_makers = neomake#makers#ft#ruby#EnabledMakers()
  call filter(g:neomake_ruby_enabled_makers, "v:val !=# 'rubylint'")

  let g:neomake_chef_rubocop_maker = neomake#makers#ft#ruby#rubocop()
  if executable('cookstyle')
    let g:neomake_chef_rubocop_maker.exe = 'cookstyle'
  endif
  let g:neomake_ruby_chef_enabled_makers = neomake#makers#ft#ruby#EnabledMakers()
  call filter(g:neomake_ruby_chef_enabled_makers, "v:val !=# 'rubocop_rails'")
  call filter(g:neomake_ruby_chef_enabled_makers, "v:val !=# 'rubylint'")

  " jshint never works quite right...
  let g:neomake_javascript_enabled_makers = filter(neomake#makers#ft#javascript#EnabledMakers(), "v:val !=# 'jshint'")

  function! s:myNeomake()
    " Buffer must be writable.
    if &readonly           | return | endif
    " Buffer must be modifiable.
    if ! &modifiable       | return | endif
    " Neomake must be installed.
    if !exists(':Neomake') | return | endif
    " The buffer must point at a file that exists.
    if !filereadable(expand('%')) | return | endif

    Neomake
  endfunction

  function! s:detectChefSubFileType()
    let l:gitroot = systemlist('git rev-parse --show-toplevel')[0]
    if l:gitroot ==# '' | return | endif
    if filereadable(l:gitroot . '/metadata.rb')
      let &filetype = &filetype . '.chef'
    endif
  endfunction

  augroup VimrcNeomake
    autocmd!
    autocmd BufEnter *     call s:myNeomake()
    autocmd BufWritePost * call s:myNeomake()
    autocmd BufEnter Gemfile*,Guardfile let b:neomake_ruby_enabled_makers = ['mri', 'rubocop']
    autocmd FileType ruby,eruby call s:detectChefSubFileType()
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


" Sieve -- mail filtering (RFC 5228)
if has_key(g:plugs, 'sieve.vim') " {{{
  augroup VimrcSieve
    autocmd!
    autocmd BufNewFile,BufRead *.sieve nested setlocal filetype=sieve
  augroup END
endif " }}}

" vim: set foldminlines=0 foldmethod=marker :
