scriptencoding utf-8

if has('filterpipe')
  set noshelltemp
endif

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

if has("patch-7.4.1570")
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

" Save Cursor Positions
"-----------------------------------------------------------------------------
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost * nested
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Prevent highlight being lost on (de)indent.
"-----------------------------------------------------------------------------
xnoremap < <gv
xnoremap > >gv

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
"-----------------------------------------------------------------------------
inoremap <C-U> <C-G>u<C-U>
inoremap <CR> <C-G>u<CR>

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

" Manpages and :help
"-----------------------------------------------------------------------------
function! ILikeHelpToTheRight()
  if !exists('w:help_is_moved') || w:help_is_moved != "right"
    wincmd L
    let w:help_is_moved = "right"
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
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

augroup VimrcMakeParentDirs
  autocmd!
  autocmd BufWritePre * nested :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
