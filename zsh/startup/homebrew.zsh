# Settings related to homebrew
if (( $+commands[brew] )); then

  # Autojump brew
  if [[ -f "$(brew --prefix)/etc/autojump" ]]; then
    source "$(brew --prefix)/etc/autojump"
  fi

  # Enable super help
  if [ -d /usr/local/share/zsh/help ]; then
    if (( $+aliases[run-help] )); then
      unalias run-help
    fi
    autoload run-help
    HELPDIR=/usr/local/share/zsh/help
  fi

  if [ -x /usr/local/opt/openssl/bin/openssl ]; then
    alias openssl=/usr/local/opt/openssl/bin/openssl
  fi

  function brew() {
    local myterm=$TERM
    case "$TERM" in
      tmux-256color)
        myterm=screen-256color
        ;;
      tmux)
        myterm=screen
        ;;
    esac

    # We want to use the system ruby to compile vim.
    env \
      RBENV_VERSION=system \
      TERM="$myterm" \
      =brew "$@"
    if [[ "$1" == *install* ]]; then
      rehash
    fi
  }
fi

# vim: set ft=zsh :
