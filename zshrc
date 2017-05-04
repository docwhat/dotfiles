#!/bin/zsh
# vim: ft=zsh :

# Load my customized environment.
for config_file (~/.zsh/startup/*.zsh(rN)); do
  source $config_file
done
unset config_file

# Fix the paths up
typeset -xU fpath path manpath

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
