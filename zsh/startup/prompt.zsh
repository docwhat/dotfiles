if [ "${TERM}" != "dumb" -a "${EMACS}" != 't' ]; then
   autoload -Uz promptinit
   promptinit
   prompt docwhat
fi
