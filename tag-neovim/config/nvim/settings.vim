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

" Note, the sleuth plugin overrides these.
set tabstop=2
set shiftwidth=0
set softtabstop=-1 " Use shiftwidth instead.
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

set shortmess+=F

set autoread
augroup checktime
  autocmd!
  if !has('gui_running')
    autocmd BufEnter,FocusGained,TabEnter * checktime
  endif
augroup END

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
set background=dark
highlight link phpBoolean Boolean

" Vim Resizing
" -----------------------------------------------------------------------------
augroup VimrcResizing
  autocmd!
  autocmd VimResized * :wincmd =
augroup END

" Terminal
" -----------------------------------------------------------------------------
augroup VimrcTerminal
  autocmd!
  autocmd TermOpen * let g:last_terminal_job_id = b:terminal_job_id | IndentLinesDisable
  autocmd WinEnter term://* startinsert | IndentLinesDisable
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
function! MyIndentWholeBufferIfEnabled() " abort
  let l:buffer = bufnr('')

  if has_key(g:plugs, 'ale')
    if type(get(b:, 'ale_fixers')) is type([])
      let l:fixers = b:ale_fixers
    else
      let l:fixers = get(ale#Var(l:buffer, 'fixers'), &filetype, [])
    endif

    if len(l:fixers) > 0
      call ale#fix#Fix(l:buffer, '')
      return
    endif
  endif

  if exists('*LCformatting_sync')
    try
      let l:did_it_work = LCformatting_sync()
      if l:did_it_work
        return
      endif
    catch " Ignore errors
    endtry
  endif

  call Preserve('normal gg=G')
endfunction

nmap <silent> <Leader>g :verbose call MyIndentWholeBufferIfEnabled()<CR>

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

" Man-pages and :help
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

function! s:get_git_root()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  return v:shell_error ? '' : root
endfunction

" Completion (<CR>) handling.
"-----------------------------------------------------------------------------
"
if has_key(g:plugs, 'lexima.vim')
  " Lexima conflicts with Deoplete and NCM2, etc. by remapping <CR>
  " https://github.com/cohama/lexima.vim/issues/65
  let g:lexima_no_default_rules = 1
  call lexima#set_default_rules()
  call lexima#insmode#map_hook('before', '<CR>', '')
endif

function! DocwhatCR() abort
  if has_key(g:plugs, 'lexima.vim')
    let l:cr = lexima#expand('<CR>', 'i')
  else
    let l:cr = '<CR>'
  endif
  let l:retval = l:cr

  if pumvisible()
    if has_key(g:plugs, 'deoplete.nvim')
      let l:retval = deoplete#smart_close_popup() . l:retval
    else
      let l:retval = "\<C-y>" . l:retval
    endif
  endif

  if has_key(g:plugs, 'ultisnips') && !empty(v:completed_item)
    let l:retval = ncm2_ultisnips#expand_or(l:retval, 'n')
  endif

  return l:retval
endfunction
inoremap <silent> <expr> <CR> DocwhatCR()

" Arpeggio
if has_key(g:plugs, 'vim-arpeggio') " {{{
  augroup VimrcSmashEscape
    autocmd!
    " Smash escape!
    autocmd VimEnter * Arpeggio inoremap jk  <Esc>
  augroup END
endif " }}}

" Surround
if has_key(g:plugs, 'vim-surround') " {{{
  let g:surround_no_insert_mappings=1
endif " }}}

" Gutentags
if has_key(g:plugs, 'vim-gutentags') " {{{
  let g:gutentags_enabled=0
endif " }}}

" Tagbar
if has_key(g:plugs, 'tagbar') " {{{
  nnoremap <silent> <Leader>tb :TagbarToggle<CR>

  if executable('gotags')
    let g:tagbar_type_go = {
          \   'ctagstype' : 'go',
          \   'kinds'     : [
          \     'p:package',
          \     'i:imports:1',
          \     'c:constants',
          \     'v:variables',
          \     't:types',
          \     'n:interfaces',
          \     'w:fields',
          \     'e:embedded',
          \     'm:methods',
          \     'r:constructor',
          \     'f:functions'
          \   ],
          \   'sro' : '.',
          \   'kind2scope' : {
          \     't' : 'ctype',
          \     'n' : 'ntype'
          \   },
          \   'scope2kind' : {
          \     'ctype' : 't',
          \     'ntype' : 'n'
          \   },
          \   'ctagsbin'  : 'gotags',
          \   'ctagsargs' : '-sort -silent',
          \ }
  endif

  let g:tagbar_type_gradle = {
        \   'ctagstype' : 'Gradle',
        \   'kinds'     : [
        \     't:tasks',
        \     'm:methods'
        \   ]
        \ }

  let g:tagbar_type_groovy = {
        \   'ctagstype' : 'Groovy',
        \   'kinds'     : [
        \     'p:package',
        \     'c:classes',
        \     'i:interfaces',
        \     't:traits',
        \     'e:enums',
        \     'r:constructors',
        \     'm:methods',
        \     'f:fields:1'
        \   ]
        \ }

endif " }}}

" TweekMonster's WStrip -- whitespace trimming and highlighting for
" only changed lines.
if has_key(g:plugs, 'wstrip.vim') " {{{
  nmap <silent> <Leader><space> :WStrip<CR>
  augroup VimrcWStrip
    autocmd!
    autocmd FileType ruby,php,c,cpp,java,vim,html,xml,xsl let b:wstrip_auto = 1
  augroup END
endif " }}}

" Better Whitespace -- whitespace trimming and highlighting
if has_key(g:plugs, 'vim-better-whitespace') " {{{
  nmap <silent> <Leader><space> :StripWhitespace<CR>
  augroup VimrcBetterWhitespace
    autocmd!
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
  if !has_key(g:plugs, 'fzf.vim')
    nnoremap <silent> <leader>p :Denite file_rec<cr>
  endif
endif " }}}

" FZF
if has_key(g:plugs, 'fzf.vim') " {{{

  function! MyGFilesOrFiles()
    let root = s:get_git_root()
    if empty(s:get_git_root())
      :Files
    else
      :GFiles
    endif
  endfunction

  let g:fzf_buffers_jump = 1
  nnoremap <silent> <leader>p :call MyGFilesOrFiles()<CR>

  " Mapping selecting mappings
  nmap <leader><tab> <plug>(fzf-maps-n)
  xmap <leader><tab> <plug>(fzf-maps-x)
  omap <leader><tab> <plug>(fzf-maps-o)

  " Insert mode completion
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)

  " Advanced customization using autoload functions
  inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
endif " }}}

" Markdown
if has_key(g:plugs, 'vim-markdown') " {{{
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_folding_style_pythonic = 1

  let g:vim_markdown_conceal = 0
  let g:vim_markdown_frontmatter = 1
  let g:vim_markdown_fenced_languages = [
        \ 'bash=sh',
        \ 'console=sh',
        \ 'erb=eruby',
        \ 'javascript',
        \ 'python',
        \ 'ruby',
        \ 'sh',
        \ 'viml=vim',
        \ 'zsh=sh']

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
  augroup END
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

" Jenkinsfile Syntax
if has_key(g:plugs, 'Jenkinsfile-vim-syntax') " {{{
  augroup VimrcJenkinsfile
    autocmd!
    autocmd BufRead,BufNewFile Ghenkinsfile  nested setlocal filetype=Jenkinsfile
    autocmd BufRead,BufNewFile Ghenkinsfile* nested setfiletype Jenkinsfile
  augroup END
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

" ColorSchemes
if has_key(g:plugs, 'colorscheme-dracula') "{{{
  colorscheme dracula
elseif has_key(g:plugs, 'colorscheme-gruvbox')
  let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_contrast_light = 'hard'
  let g:gruvbox_improved_strings = 0
  let g:gruvbox_improved_warnings = 0
  if $TERM_PROGRAM ==? 'iTerm.app'
    let g:gruvbox_italic=1
  endif
  colorscheme gruvbox
elseif has_key(g:plugs, 'colorscheme-jellybeans')
  let g:jellybeans_overrides = {}
  let g:jellybeans_overrides['background']           = { 'guibg': 'none' }
  let g:jellybeans_overrides['LineNr']               = { 'attr': 'none', 'guifg': '707090', 'guibg': 'none'   }
  let g:jellybeans_overrides['CursorLineNr']         = { 'attr': 'none', 'guifg': 'a0a0f0', 'guibg': 'none'   }
  let g:jellybeans_overrides['IncSearch']            = { 'attr': 'none', 'guifg': '405060', 'guibg': 'ff8b0f' }
  let g:jellybeans_overrides['Search']               = { 'attr': 'none', 'guifg': '203040', 'guibg': 'f7ff0d' }
  let g:jellybeans_overrides['Boolean']              = { 'attr': 'none', 'guifg': 'c04ccf', 'guibg': 'none'   }

  let g:jellybeans_overrides['SyntasticWarningSign'] = { 'attr': 'none', 'guifg': 'ffdc00', 'guibg': '333333' }
  let g:jellybeans_overrides['SyntasticErrorSign']   = { 'attr': 'none', 'guifg': 'ff4136', 'guibg': '333333' }

  let g:jellybeans_overrides['NeomakeInfoSign']      = { 'attr': 'none', 'guifg': '00dcff', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeMessageSign']   = { 'attr': 'none', 'guifg': 'eeeeee', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeWarningSign']   = { 'attr': 'none', 'guifg': 'ffdc00', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeErrorSign']     = { 'attr': 'none', 'guifg': 'ff4136', 'guibg': '333333' }

  let g:jellybeans_overrides['NeomakeInfo']          = { 'attr': 'none', 'guifg': '0000ff', 'guibg': '333388' }
  let g:jellybeans_overrides['NeomakeMessage']       = { 'attr': 'none', 'guifg': 'ffffff', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeWarning']       = { 'attr': 'none', 'guifg': 'ffff00', 'guibg': '888833' }
  let g:jellybeans_overrides['NeomakeError']         = { 'attr': 'none', 'guifg': 'ff0000', 'guibg': '883333' }

  let g:jellybeans_overrides['ALEErrorSign']         = { 'attr': 'none', 'guifg': '990000', 'guibg': '333333' }
  let g:jellybeans_overrides['ALEWarningSign']       = { 'attr': 'none', 'guifg': 'df5f00', 'guibg': '333333' }
  let g:jellybeans_overrides['ALEInfoSign']          = { 'attr': 'none', 'guifg': 'aeee00', 'guibg': '333333' }

  let g:jellybeans_overrides['ALEStyleErrorSign']    = { 'attr': 'none', 'guifg': 'ff0000', 'guibg': '333333' }
  let g:jellybeans_overrides['ALEStyleWarningSign']  = { 'attr': 'none', 'guifg': 'ffff00', 'guibg': '333333' }

  let g:airline_theme='badwolf'
  colorscheme jellybeans
elseif has_key(g:plugs, 'colorscheme-molokai')
  let g:molokai_original = 1
  let g:rehash256 = 1
  colorscheme molokai
endif
" }}}

" Rainbow Parentheses -- Color matching parentheses
if has_key(g:plugs, 'rainbow-parentheses') " {{{
  let g:rainbow_active = 1
endif " }}}

" Airplane -- cursor line theme
if has_key(g:plugs, 'vim-airline') " {{{
  let g:airline_powerline_fonts            = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_left_sep=''
  let g:airline_right_sep=''
endif " }}}

" EditorConfig -- Additional configuration
if has_key(g:plugs, 'editorconfig-vim') " {{{
  let g:EditorConfig_exclude_patterns = [
        \ 'scp://.*',
        \ 'rsync://.*',
        \ '*.diff',
        \ '*/.git/*',
        \ ]
  let g:EditorConfig_max_line_indicator = 'fill'
  let g:EditorConfig_preserve_formatoptions = 1

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

" EditorConfig -- Additional configuration
if has_key(g:plugs, 'vim-editorconfig') " {{{
  let g:editorconfig_blacklist = {
        \ 'filetype': ['git.*', 'fugitive', 'diff'],
        \ 'pattern': ['\.un~$']}
  let g:editorconfig_root_chdir = 1
  let g:editorconfig_verbose = 1
  let g:editorconfig_local_vimrc = 0 " Never!

  command! EditorConfigReload call editorconfig#load()
endif " }}}

" NCM2 -- Neovim Completion Manager
if has_key(g:plugs, 'ncm2') " {{{
  augroup VimrcNCM
    autocmd!
    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()

    " :help Ncm2PopupOpen for more information
    autocmd User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
    autocmd User Ncm2PopupClose set completeopt=menuone
  augroup END

  " suppress the annoying 'match x of y', 'The only match' and 'Pattern not
  " found' messages
  set shortmess+=c

  " CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
  inoremap <c-c> <ESC>

  " ncm2/ncm2-match-highlight
  let g:ncm2#match_highlight = 'mono-space'
endif " }}}

" Deoplete -- Additional configuration
if has_key(g:plugs, 'deoplete.nvim') " {{{
  set completeopt=menu,menuone,noselect

  call deoplete#custom#source('_', 'converters', [
        \ 'converter_remove_paren',
        \ 'converter_remove_overlap',
        \ 'converter_truncate_abbr',
        \ 'converter_truncate_menu',
        \ 'converter_auto_delimiter',
        \ ])
  call deoplete#custom#source('_', 'matchers', ['matcher_length', 'matcher_fuzzy'])
  call deoplete#custom#source('ultisnips', 'matchers', ['matcher_full_fuzzy'])


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
  let g:UltiSnipsSnippetDirectories  = ['UltiSnips', 'snips']
  let g:UltiSnipsNoPythonWarning     = 1
  let g:UltiSnipsUsePythonVersion    = 3 " We always have python3 for deoplete.
  let g:UltiSnipsEditSplit           = 'vertical'

  let g:UltiSnipsListSnippets        = '<C-s>'
  let g:UltiSnipsExpandTrigger       = '<Tab>'
  let g:UltiSnipsJumpForwardTrigger  = '<Tab>'
  let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

  " " c-j c-k for moving in snippet
  " imap <expr> <c-u> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand)", 'm')
  " smap <c-u> <Plug>(ultisnips_expand)
  " let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
  " let g:UltiSnipsRemoveSelectModeMappings = 0

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

" Javascript -- by pangloss
if has_key(g:plugs, 'vim-javascript') " {{{
  let g:javascript_plugin_flow = 1
endif " }}}

" Prettier -- Specialized formatting tool
if has_key(g:plugs, 'vim-prettier') " {{{
  function! s:myPrettierSetup()
    let l:whitelist = [ 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue' ]
    if &readonly                         | return | endif
    if ! &modifiable                     | return | endif
    if index(l:whitelist, &filetype) < 0 | return | endif

    function! s:PrettierEnable()
      let b:my_prettier_disable = 0

      augroup VimrcPrettier
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> Prettier
      augroup END
    endfunction

    function! s:PrettierDisable()
      let b:my_prettier_disable = 1

      augroup VimrcPrettier
        autocmd! * <buffer>
      augroup END
      augroup! VimrcPrettier
    endfunction

    function! PrettierToggle()
      if b:my_prettier_disable
        echomsg 'Prettier on save: ENABLED'
        call s:PrettierEnable()
      else
        echomsg 'Prettier on save: DISABLED'
        call s:PrettierDisable()
      endif
    endfunction
    command! PrettierToggle call PrettierToggle()

    if !exists('b:my_neoformat_disable')
      let b:my_prettier_disable = 0
      call s:PrettierEnable()
    endif

    nmap <buffer> <Leader>g <Plug>(PrettierAsync)
  endfunction

  let g:prettier#autoformat = 0
  let g:prettier#config#config_precedence = 'file-override'
  let g:prettier#config#prose_wrap = 'always'

  augroup VimrcPrettierSetup
    autocmd!
    autocmd BufEnter * call s:myPrettierSetup()
  augroup END
endif " }}}

" Neoformat -- forced formatting
if has_key(g:plugs, 'neoformat') " {{{
  " Enable alignment
  let g:neoformat_basic_format_align = 1

  " Enable tab to spaces conversion
  let g:neoformat_basic_format_retab = 1

  " Disable trimmming of trailing whitespace, we have that elsewhere.
  let g:neoformat_basic_format_trim = 0

  function! s:myNeoformat()
    if !exists('b:my_neoformat_disable')
      let b:my_neoformat_disable = 0
    endif

    if b:my_neoformat_disable
      return
    endif

    let l:whitelist = [
          \ 'html',
          \ 'lua',
          \ 'sh',
          \ 'terraform',
          \ 'xml',
          \ ]
    if &readonly                         | return | endif
    if ! &modifiable                     | return | endif
    if index(l:whitelist, &filetype) < 0 | return | endif

    " Ignore error from undojoin: E790
    Neoformat
  endfunction

  function! NeoformatToggle()
    if !exists('b:my_neoformat_disable')
      let b:my_neoformat_disable = 0
    endif

    if b:my_neoformat_disable
      echomsg 'Neoformat: ENABLED'
      let b:my_neoformat_disable = 0
    else
      echomsg 'Neoformat: DISABLED'
      let b:my_neoformat_disable = 1
    endif
  endfunction
  command! NeoformatToggle call NeoformatToggle()

  augroup VimrcNeoformat
    autocmd!
    autocmd BufWritePre * call s:myNeoformat()
  augroup END
endif " }}}

" LanguageClient - LSP client
if has_key(g:plugs, 'LanguageClient-neovim') " {{{
  let g:LanguageClient_serverCommands = {
        \   'Dockerfile': ['docker-langserver', '--stdio'],
        \   'c': ['clangd'],
        \   'cpp': ['clangd'],
        \   'dot': ['dot-languageserver', '--stdio'],
        \   'go': ['go-langserver', '-mode', 'stdio'],
        \   'groovy': ['groovy-language-server'],
        \   'haskell': ['hie', '--lsp'],
        \   'html': ['html-languageserver', '--stdio'],
        \   'javascript': [ 'javascript-typescript-stdio' ],
        \   'json' : [ 'vscode-json-languageserver', '--stdio' ],
        \   'lua': ['lua-lsp'],
        \   'objc': ['clangd'],
        \   'objcpp': ['clangd'],
        \   'python': ['pyls'],
        \   'rust': [ 'rustup', 'run', 'nightly', 'rls' ],
        \   'ruby': [ 'solargraph', 'stdio' ],
        \   'sh': [ 'bash-language-server', 'start'],
        \   'typescript': [ 'typescript-language-server', '--stdio'],
        \ }

  let g:LanguageClient_rootMarkers = {
        \   'haskell': ['*.cabal', 'stack.yaml'],
        \ }

  nnoremap <F5>         :call LanguageClient_contextMenu()<CR>
  map <Leader>lc        :call LanguageClient_contextMenu()<CR>
  map <Leader>lk        :call LanguageClient#textDocument_hover()<CR>
  map <Leader>lg        :call LanguageClient#textDocument_definition()<CR>
  map <Leader>lr        :call LanguageClient#textDocument_rename()<CR>
  map <Leader>lf        :call LanguageClient#textDocument_formatting()<CR>
  map <Leader>lb        :call LanguageClient#textDocument_references()<CR>
  map <Leader>la        :call LanguageClient#textDocument_codeAction()<CR>
  map <Leader>ls        :call LanguageClient#textDocument_documentSymbol()<CR>

  command! LCContext    :call LanguageClient_contextMenu()
  command! LCHover      :call LanguageClient#textDocument_hover()
  command! LCDefinition :call LanguageClient#textDocument_definition()
  command! LCRename     :call LanguageClient#textDocument_rename()
  command! LCFormatting :call LanguageClient#textDocument_formatting()
  command! LCRefs       :call LanguageClient#textDocument_references()
  command! LCAction     :call LanguageClient#textDocument_codeAction()
  command! LCSyms       :call LanguageClient#textDocument_documentSymbol()

  function! LCformatting_sync() abort
    if &filetype ==# 'sh'
      " The sh LanguageServer is currently broken.
      return
    endif
    let l:result = LanguageClient_runSync('LanguageClient#textDocument_formatting', {
          \ 'handle': v:true,
          \ })
    return l:result isnot v:null
  endfunction

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

  let g:neomake_markdown_enabled_makers = neomake#makers#ft#markdown#EnabledMakers()
  let g:neomake_markdown_enabled_makers += ['alex', 'proselint']

  let g:neomake_javascript_eslint_maker = neomake#makers#ft#javascript#eslint()
  let g:neomake_javascript_eslint_maker.args = [ 'eslint', '--format=compact' ]
  let g:neomake_javascript_eslint_maker.exe = 'npx'
  " Workaround until neomake/neomake#1939 is accepted.
  function! g:neomake_javascript_eslint_maker.supports_stdin(jobinfo) abort
    " vint: -ProhibitImplicitScopeVariable
    let self.args += ['--stdin', '--stdin-filename', '%:p' ]
    let self.tempfile_name = ''
    " vint: +ProhibitImplicitScopeVariable
    return 1
  endfunction

  let g:neomake_text_writegood_maker = neomake#makers#ft#text#writegood()
  let g:neomake_text_writegood_maker.args = [ 'writegood', '--format=compact' ]
  let g:neomake_text_writegood_maker.exe = 'npx'

  " jshint never works quite right...
  let g:neomake_javascript_enabled_makers = filter( filter(neomake#makers#ft#javascript#EnabledMakers(), "v:val !=# 'jshint'"), "v:val !=# 'jscs'")

  call neomake#configure#automake({
        \ 'TextChanged': {'delay': 1000},
        \ 'InsertLeave': {'delay': 1000},
        \ 'TextChangedI': {'delay': 2000},
        \ 'BufWritePost': {'delay': 0},
        \ 'BufWinEnter': {'delay': 200},
        \ 'FileType': {'delay': 200},
        \ 'FileChangedShellPost': {'delay': 500}
        \ }, 1000)

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

" ALE -- linting, completion, and formatting
if has_key(g:plugs, 'ale') " {{{
  nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  nmap <silent> <C-j> <Plug>(ale_next_wrap)

  let g:ale_completion_enabled = 0
  let g:ale_sign_column_always = 1
  let g:ale_use_global_executables = 1
  let g:ale_list_window_size = 5

  " How messages are displayed
  let g:ale_echo_cursor          = 1
  let g:ale_echo_delay           = 20
  let g:ale_echo_msg_error_str   = 'E'
  let g:ale_echo_msg_info_str    = 'I'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_format      = '%code: %%s [%linter%/%severity%]'

  if $POWERLEVEL9K_MODE ==# 'nerdfont-complete'
    let g:ale_sign_error         = ''
    let g:ale_sign_warning       = ''
    let g:ale_sign_info          = ''
    let g:ale_sign_style_error   = ''
    let g:ale_sign_style_warning = '𥉉'
  else
    let g:ale_sign_error         = '◉'
    let g:ale_sign_warning       = '◉'
    let g:ale_sign_info          = '◉'
    let g:ale_sign_style_error   = '!'
    let g:ale_sign_style_warning = '!'
  endif

  if has_key(g:plugs, 'vim-airline')
    " Set this. Airline will handle the rest.
    let g:airline#extensions#ale#enabled = 1

    if $POWERLEVEL9K_MODE ==# 'nerdfont-complete'
      let g:airline#extensions#ale#error_symbol = ' '
      let g:airline#extensions#ale#warning_symbol = '𥉉'
    else
      let g:airline#extensions#ale#error_symbol = 'E:'
      let g:airline#extensions#ale#warning_symbol = 'W:'
    endif
  endif

  augroup VimrcALE
    autocmd!
    autocmd OptionSet tabstop,shiftwidth nested :call s:fixPrettierOptions()
    autocmd BufEnter *                   nested :call s:fixPrettierOptions()
  augroup END

  function! s:fixPrettierOptions()
    let l:tabwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    let b:ale_javascript_prettier_options =
          \ get(g:, 'ale_javascript_prettier_options', '')
          \ . ' --tab-width=' . l:tabwidth

    if &textwidth > 0
      let b:ale_javascript_prettier_options = b:ale_javascript_prettier_options . ' --print-width=' . &textwidth . ' --prose-wrap=always'
    else
      let b:ale_javascript_prettier_options = b:ale_javascript_prettier_options . ' --prose-wrap=never'
    endif
  endfunction

  " ALE isn't going to add the fixers to the normal enable/disable.
  " reference: https://github.com/w0rp/ale/issues/1353
  command! ALEFixersDisable       let b:ale_fix_on_save=0
  command! ALEFixersEnable        let b:ale_fix_on_save=1
  command! ALEFixersToggle        let b:ale_fix_on_save = get(b:, 'ale_fix_on_save', get(g:, 'ale_fix_on_save', 0)) ? 0 : 1

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

" Nuake -- Quake Like terminal popup
if has_key(g:plugs, 'nuake') " {{{
  let g:nuake_position = 0 " 0:horizontal & 1:vertical
  let g:nuake_size     = 0.30
  let g:nuake_per_tab  = 0

  " nnoremap <C-y> :Nuake<CR>
  " inoremap <C-y> <C-\><C-n>:Nuake<CR>
  " tnoremap <C-y> <C-\><C-n>:Nuake<CR>
endif " }}}

" vim: set foldminlines=0 foldmethod=marker :
