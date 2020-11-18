#!/bin/zsh
# vim: ft=zsh :

# zmodload zsh/zprof

# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '

# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile

# setopt XTRACE

# Load my customized environment.
for config_file (~/.zsh/startup/*.zsh(rN)); do
  source "$config_file"
done
unset config_file

# Fix the paths up
typeset -xU fpath path manpath

# unsetopt XTRACE
# exec 2>&3 3>&-

if (( $+builtins[zprof] )); then
  zprof | tee /tmp/zprofile-$$.log
fi
