if [[ "${TERM}" == dumb || "${EMACS}" == t ]]; then
   # Disable powerlevel9k
   add-zsh-hook -D precmd powerlevel9k_\*
   add-zsh-hook -D preexec powerlevel9k_\*
   PS1='zsh%# '
fi
