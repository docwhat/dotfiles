
if [[ -x /usr/bin/xcode-select ]]; then
  i="$(xcode-select -p)"
  if [[ -d "$i" ]]; then
    path+=( "$i/usr/bin" )
    manpath+=( "$i/usr/share/man" )
  fi
fi
