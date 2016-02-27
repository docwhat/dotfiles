" NVim configuration
" 
" pip3 install --upgrade pip setuptools
" pip3 install --upgrade neovim
" pip2 install --upgrade pip setuptools
" pip2 install --upgrade neovim
"
" Examples:
"  * https://github.com/EPadronU/conf-files/blob/master/neovim/.nvimrc
"  * https://www.reddit.com/r/neovim/comments/46z55o/help_can_you_give_me_your_opinion_about_my_initvim/

let s:bootstrap=0
let s:vim_plug_path = expand("~/.config/nvim/autoload/plug.vim")

if !filereadable(s:vim_plug_path)
  let s:bootstrap=1
endif

if s:bootstrap
  echomsg '********************'
  echomsg 'Bootstrapping NeoVim'
  echomsg '********************'
  echomsg ''
endif

" ** Plugins
if s:bootstrap
  execute 'silent !curl -qSLo ' . s:vim_plug_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  execute 'source ' . s:vim_plug_path
endif

execute 'source ' . expand('~/.config/nvim/plugins.vim')

if s:bootstrap
  :PlugUpdate
endif

" Etc.
augroup Vimrc
  autocmd!
augroup END

filetype plugin indent on " Not needed in 0.13+
syntax enable             " Not needed in 0.13+

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

" if filereadable(g:my_vimrc . '.local-pre')
"   execute 'source ' . g:my_vimrc . '.local-pre'
" endif

colorscheme jellybeans

augroup Vimrc
  autocmd VimEnter * Arpeggio inoremap jk  <Esc>
augroup END

if executable('ag')
  let g:unite_source_grep_command       = 'ag'
  let g:unite_source_grep_default_opts  = 
	  \ '-i --vimgrep --line-numbers -S -C4 --nocolor'
"    \ '--nocolor --line-numbers --nogroup -S -C4'
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <C-p> :Unite file_rec/async<cr>

" This should be at the end.
if s:bootstrap
  unlet s:bootstrap
endif

" EOF
