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
set wildignore+=*.o,*.obj,*.pyc,*.pyo,*.pyd
set wildignore+=*.png,*.gif,*.jpg,*.ico,*.ttf,*.TTF,*.svg
set wildignore+=.git,.svn,.hg,.DS_Store
set wildignore+=*.so,*.class,*.lock
set wildignore+=*/tmp/*,*/target/*

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
let g:docwhat_commandline_prompt = '➭'

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
  if HasPlugin('vim-pandoc')
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
nmap <Leader>g <Plug>SmartIndentWholeBufferIfEnabled

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

" Completion (<CR>) handling.
"-----------------------------------------------------------------------------
"
if HasPlugin('lexima.vim')
  " Lexima conflicts with Deoplete and NCM2, etc. by remapping <CR>
  " https://github.com/cohama/lexima.vim/issues/65
  let g:lexima_no_default_rules = 1
  let g:lexima_map_escape = '<C-y><Esc>'
  call lexima#set_default_rules()
  call lexima#insmode#map_hook('before', '<CR>', '')
endif

function! DocwhatCR() abort
  if HasPlugin('lexima.vim')
    let l:cr = lexima#expand('<CR>', 'i')
  else
    let l:cr = "\<CR>"
  endif
  let l:retval = l:cr

  if pumvisible()
    if HasPlugin('deoplete.nvim')
      let l:retval = deoplete#smart_close_popup() . l:retval
    else
      let l:retval = "\<C-y>" . l:retval
    endif
  else
    " `<C-g>u` means break undo chain at current position.
    let l:retval = "\<C-g>u" . l:retval
  endif

  if HasPlugin('ultisnips') && !empty(v:completed_item)
    let l:retval = ncm2_ultisnips#expand_or(l:retval, 'n')
  endif

  return l:retval
endfunction
inoremap <silent> <expr> <CR> DocwhatCR()

" Codi -- Scratch Pad testing of various languages
if HasPlugin('codi.vim') " {{{
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
if HasPlugin('vim-dirvish') " {{{
  augroup VimrcDirvish
    autocmd!
    autocmd FileType dirvish call fugitive#detect(@%)
  augroup END
endif " }}}

" Committia -- Git commit message helper
if HasPlugin('committia.vim') " {{{
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
if HasPlugin('nerdcommenter') " {{{
  " Command and uncomment code easily
  " <leader>cc -- comment ragged style
  " <leader>cl -- comment aligned style
  " <leader>cu -- uncomment
  " <leader>ci -- toggle comments
  let g:NERDRemoveExtraSpaces=1
  let g:NERDSpaceDelims=1
  let g:NERDCommentWholeLinesInVMode=2
endif " }}}

" Markdown
if HasPlugin('vim-markdown') " {{{
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

" Ruby -- syntaxt and indentation (overrides built-in version)
if HasPlugin('vim-ruby') " {{{
  let g:ruby_indent_block_style = 'do'
  let g:ruby_indent_assignment_style = 'variable'
endif " }}}

" Jenkinsfile Syntax
if HasPlugin('Jenkinsfile-vim-syntax') " {{{
  augroup VimrcJenkinsfile
    autocmd!
    autocmd BufRead,BufNewFile Ghenkinsfile  nested setlocal filetype=Jenkinsfile
    autocmd BufRead,BufNewFile Ghenkinsfile* nested setfiletype Jenkinsfile
  augroup END
endif " }}}

" Rust -- rust syntax and indentation
if HasPlugin('rust.vim') " {{{
  let g:rustfmt_autosave = 1
endif
" }}}

" UltiSnips -- Snippets
if HasPlugin('ultisnips') " {{{
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
if HasPlugin('vim-javascript') " {{{
  let g:javascript_plugin_flow = 1
endif " }}}

" Sieve -- mail filtering (RFC 5228)
if HasPlugin('sieve.vim') " {{{
  augroup VimrcSieve
    autocmd!
    autocmd BufNewFile,BufRead *.sieve nested setlocal filetype=sieve
  augroup END
endif " }}}

" vim: set foldminlines=0 foldmethod=marker :
