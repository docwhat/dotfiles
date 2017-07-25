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

" Figure out the XDG_CONFIG_HOME and XDG_DATA_HOME directories.
" See https://github.com/neovim/neovim/issues/5297
let g:xdg_config_home = fnamemodify(expand('<sfile>'), ':p:h')
let g:xdg_data_home = fnamemodify(g:xdg_config_home, ':s?/.config/nvim?/.local/share/nvim?')
if filewritable(g:xdg_data_home) != 2
  let g:xdg_data_home = g:xdg_config_home
endif

let s:vim_plug_path = g:xdg_config_home . '/autoload/plug.vim'

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

execute 'source ' . g:xdg_config_home . '/plugins.vim'

if has('ruby')
  ruby load "#{VIM.evaluate('g:xdg_config_home')}/bootcheck.rb"
endif

if s:bootstrap && ! exists('$NVIM_SKIP_PLUGIN_CHECK')
  echo "Installing missing plugins. Please wait...\n"
  :silent PlugInstall
  :silent PlugUpgrade
  quit
endif

execute 'source ' . g:xdg_config_home . '/functions.vim'
execute 'source ' . g:xdg_config_home . '/settings.vim'
execute 'source ' . g:xdg_config_home . '/keys.vim'

" Local settings
if filereadable(g:xdg_config_home . '/local.vim')
  execute 'source ' . g:xdg_config_home . '/local.vim'
endif

" EOF
