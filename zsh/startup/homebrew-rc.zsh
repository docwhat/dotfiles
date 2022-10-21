# Settings related to homebrew
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  brewfpath=${${:-"${HOMEBREW_PREFIX}/share/zsh/functions/_git"}:A:h}
  if [[ -d "$brewfpath" ]] && (( ${fpath[(i)$brewfpath]} <= ${#fpath} )) ; then
    # git's contrib completion for zsh is ... sub-optimal.
    # Homebrew used to allow ditching it, but no more.
    # https://github.com/Homebrew/homebrew-core/issues/33275
    # This ensures homebrew goes early in the fpath.
    fpath=($brewfpath "${fpath[@]}")
  fi
  unset brewfpath

  # Homebrew's zsh doesn't always add all the default paths, depending on
  # where the HOMEBREW_PREFIX is pointing.
  brew_site_path="${HOMEBREW_PREFIX}/share/zsh/site-functions"
  if [[ -d "$brew_site_path" ]]; then
    fpath+=$brew_site_path
  fi
  unset brew_site_path

  # Autojump brew
  if [[ -f "$HOMEBREW_PREFIX/etc/autojump" ]]; then
    source "$HOMEBREW_PREFIX/etc/autojump"
  fi

  if [ -x "$HOMEBREW_PREFIX/opt/openssl/bin/openssl" ]; then
    alias openssl="$HOMEBREW_PREFIX/opt/openssl/bin/openssl"
  fi
fi

# vim: set ft=zsh :
