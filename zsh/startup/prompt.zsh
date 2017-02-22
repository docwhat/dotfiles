if [[ "${TERM}" != dumb && "${EMACS}" != t ]]; then
   autoload -Uz promptinit && promptinit
   prompt docwhat
fi
