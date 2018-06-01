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

  function brew-fast-update() {
    if (( $+commands[parallel] )); then
      /usr/bin/find /usr/local -name '.git' -type d -print0 \
        | parallel --progress --eta -j+0 -0 '(set -e ; cd {} ; cd .. ; echo -en "\n====> " ; pwd ; git fetch --all --prune ; git prune ; git checkout master ; git reset --hard origin/master) 1>&2'
    else
      /usr/bin/find /usr/local -name '.git' -type d -print0 \
        | /usr/bin/xargs -0 -Iqq bash -c '(set -e ; cd qq ; cd .. ; echo -n "====> " ; pwd ; git fetch --all --prune ; git prune ; git checkout master ; git reset --hard origin/master) 1>&2'
    fi

    echo -e "\n\n"
    brew outdated
  }
fi

# vim: set ft=zsh :
