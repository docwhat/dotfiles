#!/bin/zsh
# vim: ft=zsh :

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

DISABLE_AUTO_UPDATE=true
DISABLE_LS_COLORS=true
DISABLE_AUTO_TITLE=true
COMPLETION_WAITING_DOTS=true
HIST_STAMPS='yyyy-mm-dd'

plugins=(
  # Version Control
  git
  git-extras
  mercurial
  svn

  osx
  zsh-navigation-tools
  brew
  vagrant
  redis-cli
  cp
  rsync
  marked

  # Languages
  node
  npm
  python
  pip
  golang

  # Ruby
  ruby
  jruby
  rails
  rake
  gem
  thor
  cap
  knife
  #bundler # must be last

  # My plugins
  prompts
  gotmux
  task
  ack
)

source $ZSH/oh-my-zsh.sh

# Load my customized environment.
for config_file (~/.zsh/startup/*.zsh(rN)); do
  source $config_file
done
unset config_file

# Fix the paths up
typeset -xU fpath path manpath

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
