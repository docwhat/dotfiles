for dir in "${HOME}/Library/Python"/*/bin; do
  if [ -d "${dir}" ]; then
    path+=("$dir")
  fi
done
