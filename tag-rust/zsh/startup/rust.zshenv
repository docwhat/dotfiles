if [ -f ~/.cargo/env ]; then
  source ~/.cargo/env
elif [[ -d ~/.cargo/bin ]]; then
  path=( ~/.cargo/bin "${path[@]}" )
fi

# vim:set et ft=zsh sw=2 ts=2:
