if (( ${+commands[ssh-add]} )); then
  {
    if (( ${+commands[keychain]} )); then
      eval "$(keychain --eval --quick --noask --nogui --quiet --inherit 'any' --agents 'ssh' --ignore-missing id_rsa id_dsa id_ed25519)"
    fi

    # Used for TMUX
    if [ "${SSH_AUTH_SOCK:-}" != "$HOME/.ssh/ssh_auth_sock" ]; then
      if [[ -S "$SSH_AUTH_SOCK" && ! -L "$SSH_AUTH_SOCK" ]]; then
        ln -nsf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
      fi
    fi

    if [[ "${OSTYPE}" == darwin* ]]; then
      /usr/bin/ssh-add -A >/dev/null 2>&1
    fi
  } &!
fi

# References:
# http://unix.stackexchange.com/questions/90853/
# On OS X, see the ssh-add(1) manpage for the -A and -K flags
# In Sierra (10.12) ssh-add -A must be done manually, where it was done
# automatically before:
#   https://github.com/lionheart/openradar-mirror/issues/15361
#   http://www.openradar.me/27348363

# vim: ft=zsh :
