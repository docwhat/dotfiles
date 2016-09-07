augroup Vimrc
  autocmd!
augroup END

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set hidden

set shiftround

set linebreak                    " Only wrap on characters in `breakat`
let &showbreak = '↳ '

set ignorecase
set smartcase

set number
" set wildmode=list:longest,full   " Completion for wildchar (see help)
set wildignore+=*.o,*.obj,*.pyc,*.pyo,*.pyd,*.class,*.lock
set wildignore+=*.png,*.gif,*.jpg,*.ico
set wildignore+=.git,.svn,.hg

set showmatch                    " Show the matching bracket
set matchpairs=(:),{:},[:]       " List of characters we expect in balanced pairs

set cursorline                   " highlights the current line

" Folds
set foldminlines=20

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set scrolloff=5       " don't scroll any closer to top/bottom
set sidescrolloff=5   " don't scroll any closer to left/right

" Themes/Colors
set termguicolors
set background=dark
colorscheme jellybeans
call airline#switch_theme('badwolf')

" Smash escape!
augroup Vimrc
  autocmd VimEnter * Arpeggio inoremap jk  <Esc>
augroup END

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
xnoremap < <gv
xnoremap > >gv

" %% in command mode will expand to the directory name.
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Indent whole file
nmap <silent> <Leader>g :call Preserve("normal gg=G")<CR>
nmap <silent> <Leader><space> :call Preserve("%s/\\s\\+$//e")<CR>

" Since C-l is now window navigation, use Leader-h
" to redraw (and hide highlighted search).
nnoremap <silent> <Leader>h :nohlsearch<CR><C-L>

" Get Jared and Selker to use hjkl instead of cursor keys...
nnoremap <Left>  :echoerr "I don't like that direction... try 'h' instead."<cr>
nnoremap <Right> :echoerr "Republican, eh? I prefer 'l'."<cr>
nnoremap <Up>    :echoerr "This is why we can't have nice things. You should have used 'k'."<cr>
nnoremap <Down>  :echoerr "That's what she said... and then used 'j'."<cr>

" Manpages and :help
function! ILikeHelpToTheRight()
  if !exists('w:help_is_moved') || w:help_is_moved != "right"
    wincmd L
    let w:help_is_moved = "right"
  endif
endfunction

let g:real_manpager=$MANPAGER
let g:ft_man_folding_enable = 1

augroup ManAndHelpPages
  autocmd!
  autocmd FileType help nested call ILikeHelpToTheRight()
  autocmd FileType man,help nested nnoremap <buffer> q :q!<cr>
  autocmd FileType man nested let &listchars=""
  " Work around for stupid attempt to prevent recursive vim
  " calls.
  autocmd FileType man nested let $MANPAGER=g:real_manpager
augroup END
