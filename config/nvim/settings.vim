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

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Themes/Colors
set termguicolors
set background=dark
colorscheme gruvbox

" Smash escape!
augroup Vimrc
  autocmd VimEnter * Arpeggio inoremap jk  <Esc>
augroup END

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
