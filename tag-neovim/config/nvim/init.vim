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

set encoding=utf-8
scriptencoding utf-8
language en_US.UTF-8

if exists('g:scode')
  echomsg 'Running under VS code.'
else

  if has('win16') || has('win32') || has('win64')
    set termencoding=cp850
    setglobal fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
  endif

  let s:bootstrap=0

  let s:vim_plug_path = stdpath('config') . '/autoload/plug.vim'

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

  execute 'source ' . stdpath('config') . '/plugins.vim'

  if has('ruby')
    let s:bootcheck_path = stdpath('config') . '/bootcheck.rb'
    ruby load VIM.evaluate('s:bootcheck_path')
  endif

  if s:bootstrap && ! exists('$NVIM_SKIP_PLUGIN_CHECK')
    echo "Installing missing plugins. Please wait...\n"
    :silent PlugClean!
    :silent PlugInstall
    :silent PlugUpgrade
    quit
  endif

  execute 'source ' . stdpath('config') . '/settings.vim'

  " Local settings
  if filereadable(stdpath('config') . '/local.vim')
    execute 'source ' . stdpath('config') . '/local.vim'
  endif
endif

" EOF
