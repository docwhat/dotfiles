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

if has('win16') || has('win32') || has('win64')
  language messages en_US.UTF-8
  if has('multi_byte')
    set termencoding=cp850
    set encoding=utf-8
    setglobal fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
  endif
else
  language en_US.UTF-8
  set encoding=utf-8
  set termencoding=utf-8
endif

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
  echomsg "Updating plugins. Please wait. "
  redraw
  :PlugUpdate
endif

execute 'source ' . g:my_nvim_dir . '/functions.vim'
execute 'source ' . g:my_nvim_dir . '/settings.vim'

" Local settings
if filereadable(g:my_nvim_dir . '/local.vim')
  execute 'source ' . g:my_nvim_dir . '/local.vim'
endif

if s:bootstrap
  echomsg "Quitting to have new plugins take effect."
  for name in keys(g:plugs)
    echomsg "Plugin " . name . " installed."
    silent noautocmd call plug#load(name)
  endfor
  call remote#host#UpdateRemotePlugins()
  :qall
endif

" EOF
