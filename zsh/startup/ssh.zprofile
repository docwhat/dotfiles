if [ "${SSH_AUTH_SOCK:-}" != "$HOME/.ssh/ssh_auth_sock" ]; then
  if (( $+commands[ssh-add] )); then
    if (( $+commands[keychain] )); then
      eval "$(keychain --eval --quick --noask --nogui --inherit 'any' --agents 'ssh' --ignore-missing id_rsa id_dsa)"
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

# vim: ft=zsh :
