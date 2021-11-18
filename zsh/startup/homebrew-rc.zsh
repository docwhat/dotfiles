# Settings related to homebrew
if (( ${+commands[brew]} )); then

  # Autojump brew
  if [[ -f "$HOMEBREW_PREFIX/etc/autojump" ]]; then
    source "$HOMEBREW_PREFIX/etc/autojump"
  fi

  if [ -x "$HOMEBREW_PREFIX/opt/openssl/bin/openssl" ]; then
    alias openssl="$HOMEBREW_PREFIX/opt/openssl/bin/openssl"
  fi
fi

# vim: set ft=zsh :
