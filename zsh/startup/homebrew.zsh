# Settings related to homebrew
if (( ${+commands[brew]} )); then

  # Autojump brew
  if [[ -f "$(brew --prefix)/etc/autojump" ]]; then
    source "$(brew --prefix)/etc/autojump"
  fi

  # Enable super help
  if [ -d /usr/local/share/zsh/help ]; then
    if (( ${+aliases[run-help]} )); then
      unalias run-help
    fi
    autoload run-help
    HELPDIR=/usr/local/share/zsh/help
  fi

  if [ -x /usr/local/opt/openssl/bin/openssl ]; then
    alias openssl=/usr/local/opt/openssl/bin/openssl
  fi

  # git's contrib completion for zsh is ... sub-optimal.
  # Homebrew used to allow ditching it, but no more.
  # https://github.com/Homebrew/homebrew-core/issues/33275
  if ! [[ ~/.zsh/functions/_git -ef /usr/local/opt/zsh/share/zsh/functions/_git ]]; then
    ln -nfs /usr/local/opt/zsh/share/zsh/functions/_git ~/.zsh/functions/_git
  fi
fi

# vim: set ft=zsh :
