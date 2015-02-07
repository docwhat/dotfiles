# vi: set ft=zsh :

if (( $+commands[keychain] )); then
  eval "$(keychain --quiet --agents ssh --eval)"
  if [[ "${OSTYPE}" != darwin* ]] && ! ssh-add -l >/dev/null; then
    [ -r ~/.ssh/id_rsa ] && ssh-add ~/.ssh/id_rsa
    [ -r ~/.ssh/id_dsa ] && ssh-add ~/.ssh/id_dsa
  fi
fi

# References:
# http://unix.stackexchange.com/questions/90853/
# On OS X, see the ssh-add(1) manpage for the -A and -K flags

# EOF
