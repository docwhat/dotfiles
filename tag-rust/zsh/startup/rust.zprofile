if (( $+commands[rustup] )); then
  # Rustup Completions
  rustup completions zsh > ~/.zsh/functions/_rustup

  # Cargo Completions
  c="$(rustup which cargo)"
  if [ -d "${c:h:h}/share/zsh/site-functions/" ]; then
    fpath+=("${c:h:h}/share/zsh/site-functions/")
  fi
  unset c
fi

# vim:set et ft=zsh sw=2 ts=2:
