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
fi

# vim: set ft=zsh :
