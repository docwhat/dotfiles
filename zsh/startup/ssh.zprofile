if [ "${SSH_AUTH_SOCK:-}" != "$HOME/.ssh/ssh_auth_sock" ]; then
  if (( $+commands[ssh-add] )); then
    if (( $+commands[keychain] )); then
      eval "$(keychain --quiet --quick --noask --agents ssh --inherit any-once --eval)"
      if [[ "${OSTYPE}" != darwin* ]] && ! ssh-add -l >/dev/null; then
        [ -r ~/.ssh/id_rsa ] && ssh-add ~/.ssh/id_rsa
        [ -r ~/.ssh/id_dsa ] && ssh-add ~/.ssh/id_dsa
      fi
    fi

    # Used for TMUX
    if [[ -S "$SSH_AUTH_SOCK" && ! -L "$SSH_AUTH_SOCK" ]]; then
      ln -nsf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi
  fi
fi

# References:
# http://unix.stackexchange.com/questions/90853/
# On OS X, see the ssh-add(1) manpage for the -A and -K flags

# EOF
