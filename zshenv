#!/bin/zsh
# vim: ft=zsh :

# The path has to be set *first*
path=(
  "$HOME/bin"
  "$HOME/.cabal/bin"
  "$HOME/.gocode/bin"
  /usr/local/sbin
  /usr/local/bin
  /usr/local/opt/coreutils/libexec/gnubin
  /usr/local/opt/ruby/bin
  /usr/local/opt/curl/bin
  /usr/local/share/npm/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  /opt/X11/bin
  $path
)

manpath=(
  /usr/local/share/man
  /usr/local/opt/coreutils/libexec/gnuman
  /usr/local/opt/ruby/share/man
  /usr/local/opt/curl/share/man
  /usr/share/man
)

# Load my customized environment.
for config_file (~/.zsh/startup/*.zshenv(N)); do
  source $config_file
done
unset config_file

# EOF
