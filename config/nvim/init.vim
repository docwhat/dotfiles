" NVim configuration
" 
" pip3 install --upgrade pip setuptools
" pip3 install --upgrade neovim
" pip2 install --upgrade pip setuptools
" pip2 install --upgrade neovim
" gem install neovim
"
" Examples:
"  * https://github.com/EPadronU/conf-files/blob/master/neovim/.nvimrc
"  * https://www.reddit.com/r/neovim/comments/46z55o/help_can_you_give_me_your_opinion_about_my_initvim/

let s:bootstrap=0
" Figure out the home directory.
let g:my_nvim_dir = fnamemodify(expand('<sfile>'), ':p:h')
let s:vim_plug_path = g:my_nvim_dir . "/autoload/plug.vim"

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

execute 'source ' . g:my_nvim_dir . '/plugins.vim'

if has('ruby')
  ruby load "#{VIM.evaluate('g:my_nvim_dir')}/bootcheck.rb"
endif

if s:bootstrap   
  :PlugUpdate
  quit " Close the plugin install window.
  redraw
endif

execute 'source ' . g:my_nvim_dir . '/functions.vim'
execute 'source ' . g:my_nvim_dir . '/settings.vim'

" EOF
