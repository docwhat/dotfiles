autoload -U is-at-least
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  zgen oh-my-zsh

  # Python
  zgen oh-my-zsh plugins/python
  zgen oh-my-zsh plugins/pip
  zgen load sharat87/pip-app

  # Ruby
  zgen load unixorn/rake-completion.zshplugin

  # Golang
  zgen oh-my-zsh plugins/golang

  # Various Utils
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/rsync
  zgen oh-my-zsh plugins/vagrant

  zgen load zsh-users/zsh-completions src

  # Git
  zgen load unixorn/git-extra-commands
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/github

  # zgen oh-my-zsh plugins/colored-man-pages
  #
  if [ $(uname -a | grep -ci Darwin) = 1 ]; then
    # Load OSX-specific plugins
    zgen oh-my-zsh plugins/osx
  fi

  zgen load chrissicool/zsh-256color

  zgen oh-my-zsh plugins/redis-cli
  zgen oh-my-zsh plugins/rsync
  zgen oh-my-zsh plugins/marked2

  # Completion generator
  zgen load RobSis/zsh-completion-generator

  # Add Fish shell like syntax highlighting for ZSH
  if false; then
    # With zsh-syntax-highlighting and zsh-autosuggestions both loaded
    # then history-incremental-pattern-search-backward doesn't work:
    # it only works for the first (random) few history items, then stops as if
    # my history is gone.
    zgen load zsh-users/zsh-syntax-highlighting
  fi

  # Add Fish-like autosuggestions to your ZSH
  if is-at-least 5.0; then
    zgen load zsh-users/zsh-autosuggestions
    # Fixes paste being slow.
    zstyle ':bracketed-paste-magic' active-widgets '.self-*'

    ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=( end-of-line vi-end-of-line vi-add-eol )
    ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=( forward-char vi-forward-char )
  fi

  # Save it all to init script
  zgen save
fi

# EOF
