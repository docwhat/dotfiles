## Try installing asdf if not already available.
if ! (( $+commands[asdf] )); then
  if (( $+commands[brew] )); then
    brew install --quiet asdf
  fi
fi

## Abort if not available.
if ! (( $+commands[asdf] )); then
  return
fi

# Write out the completion info.
asdf completion zsh > ~/.zsh/functions/_asdf

# Reshim when we type 'rehash'.
add-rehash-hook "asdf reshim"

# EOF
