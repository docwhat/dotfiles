if [ -d "$HOME/.cabal/bin" ]; then
  path=( "$HOME/.cabal/bin" "${path[@]}" )
fi
