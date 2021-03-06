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

" PUM - Popup Menu
set completeopt=menu,menuone,preview
if exists('&pumblend')
  set pumblend=15
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

set diffopt+=iwhiteall,hiddenoff
if has('patch-8.1.0360')
  set diffopt+=internal,algorithm:patience
endif

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
execute 'silent !mkdir -p ' . stdpath('cache') . '/undo'
let &undodir=stdpath('cache') . '/undo,' . stdpath('data') . '/undo'

" Backups
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory(stdpath('cache') . '/backup') == 0
  execute 'silent !mkdir -p ' . stdpath('cache') . '/backup >/dev/null 2>&1'
endif
let &backupdir=stdpath('cache') . '/backup' . ',' . stdpath('data') . '/backup' . ',' . '.'

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
  autocmd FocusGained,FocusLost * rshada|wshada
augroup END

" Disable Python 2
let g:loaded_python_provider = 1
if has('pythonx')
  set pyxversion=3
endif

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
let g:netrw_home = stdpath('data')
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
if has('nvim') && executable('nvr')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  let $EDITOR = 'nvr --remote-wait'
endif

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

" Detect Secrets baseline syntax
augroup VimrcDetectSecretsBaseline " {{{
  autocmd!
  autocmd BufRead,BufNewFile .secrets.baseline nested setlocal filetype=json
augroup END " }}}

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
