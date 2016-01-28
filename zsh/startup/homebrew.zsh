# Settings related to homebrew
if (( $+commands[brew] )); then

  # Autojump brew
  if [[ -f "$(brew --prefix)/etc/autojump" ]]; then
    source "$(brew --prefix)/etc/autojump"
  fi

  # Enable github support
  if [ -x /usr/local/bin/hub ]; then
    alias git=/usr/local/bin/hub
    type compdef >/dev/null && compdef hub=git
  elif command -v hub >/dev/null; then
    alias git=hub
    type compdef >/dev/null && compdef hub=git
  fi

  # Enable super help
  if [ -d /usr/local/share/zsh/help ]; then
    if (( $+aliases[run-help] )); then
      unalias run-help
    fi
    autoload run-help
    HELPDIR=/usr/local/share/zsh/help
  fi

  function brew()
  {
    # We want to use the system ruby to compile vim.
    env \
      RBENV_VERSION=system \
      =brew "$@"
    if [[ "$1" == *install* ]]; then
      rehash
    fi
  }

  function enccache()
  {
    if [[ -d "$(brew --prefix ccache)" ]]; then
      export PATH="$(brew --prefix ccache)/libexec:${PATH}"
      typeset -U path
    else
      echo "ccache is not installed"
    fi
  }
fi

# EOF
