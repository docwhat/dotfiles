for dir in "${HOME}/Library/Python"/*/bin(N); do
  if [ -d "${dir}" ]; then
    path+=("$dir")
  fi
done
