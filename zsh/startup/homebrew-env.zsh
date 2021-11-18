# vim: set ft=zsh :

for __brewbin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [[ -x "$__brewbin" ]]; then
    eval "$("$__brewbin" shellenv zsh)"

    # git's contrib completion for zsh is ... sub-optimal.
    # Homebrew used to allow ditching it, but no more.
    # https://github.com/Homebrew/homebrew-core/issues/33275
    # This ensures homebrew goes early in the fpath.
    fpath=("$HOMEBREW_PREFIX/share/zsh/functions" "${fpath[@]}")
    break
  fi
done
unset __brewbin
