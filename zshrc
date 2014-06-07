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
  zsh-syntax-highlighting
  brew
  vagrant
  redis-cli
  cp
  rsync
  ssh-agent

  # Languages
  node
  npm
  python
  pip
  urltools

  # Ruby
  ruby
  jruby
  rails
  rake
  gem
  powder
  heroku
  thor
  cap
  knife
  tmuxinator
  #bundler # must be last

  # My plugins
  prompts
  gotmux
  task
  ack
)

source $ZSH/oh-my-zsh.sh

zstyle :omz:plugins:ssh-agent agent-forwarding on

# Load my customized environment.
for config_file (~/.zsh/startup/*.zsh(N)); do
  source $config_file
done
unset config_file

# Fix the paths up
typeset -xU fpath path manpath
