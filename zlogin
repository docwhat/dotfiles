# vi: ft=zsh :

if (( $+functions[compinit] )); then
  unfunction compinit
fi
autoload -Uz compinit
compinit -i -d "${ZSH_COMPDUMP}"

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
    zcompile "$ZSH_COMPDUMP"
  fi
} &!

# EOF
