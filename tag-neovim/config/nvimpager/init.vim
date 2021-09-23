
" Disable nvimpager's key maps.
lua nvimpager.maps = false

set smartcase
set termguicolors
set scrolloff=5
set sidescrolloff=5
set clipboard+=unnamedplus
set updatetime=300

nmap q :quit!<cr>
vmap q :<C-U>quit!<cr>

nmap <Space> <PageDown>
nmap <C-Space> <PageUp>
nmap g gg
nmap j <C-E>
nmap k <C-Y>
nmap <Up> <C-Y>
nmap <Down> <C-E>

colorscheme darkblue

" EOF
