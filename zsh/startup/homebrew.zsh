# Settings related to homebrew
if (( $+commands[brew] )); then

  # Autojump brew
  if [[ -f `brew --prefix`/etc/autojump ]]; then
    source `brew --prefix`/etc/autojump
  fi

  # Enable github support
  if [ -x /usr/local/bin/hub ]; then
    alias git=/usr/local/bin/hub
    type compdef >/dev/null && compdef hub=git
  elif command -v hub >/dev/null; then
    alias git=hub
    type compdef >/dev/null && compdef hub=git
  fi

  # Extra ZSH completions from Homebrew packages
  if [[ -d /usr/local/share/zsh/site-completions ]]; then
    fpath=(/usr/local/share/zsh/site-completions $fpath)
  fi
  if [[ -d /usr/local/share/zsh-completions ]]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
  fi

  # Enable super help
  if [ -d /usr/local/share/zsh/helpfiles ]; then
    unalias run-help
    autoload run-help
    export HELPDIR=/usr/local/share/zsh/helpfiles
  fi

  function brew()
  {
    # We want to use the system ruby to compile vim.
    env \
      RBENV_VERSION=system \
      HOMEBREW_GITHUB_API_TOKEN=1fb431ef5362f2c16e3bf308306838839358c2b3 \
      =brew "$@"
    if [[ "$1" == *install* ]]; then
      rehash
    fi
  }

  function enccache()
  {
    if [[ -d `brew --prefix ccache` ]]; then
      export PATH="$(brew --prefix ccache)/libexec:${PATH}"
      typeset -U path
    else
      echo "ccache is not installed"
    fi
  }
fi

# EOF
