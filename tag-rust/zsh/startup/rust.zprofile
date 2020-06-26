if (( $+commands[rustup] )); then
  # Rustup Completions
  if [[ -n ~/.zsh/functions/_rustup(#qN.mh+24) ]]; then
    {
    rustup completions zsh \
      > ~/.zsh/functions/_rustup
    } &!
  fi

  # Cargo Completions
  c="$(rustup which cargo)"
  if [ -d "${c:h:h}/share/zsh/site-functions/" ]; then
    fpath+=("${c:h:h}/share/zsh/site-functions/")
  fi
  unset c
fi

# vim:set et ft=zsh sw=2 ts=2:
