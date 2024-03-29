# macOS has a utility to set up the PATH.
# I don't want it to clobber _my_ path order, though.
if [[ -x /usr/libexec/path_helper ]]; then
  eval "$(/usr/libexec/path_helper -s | sed 's/PATH=/DOCPATH=/g')"

  IFS=: read -r -A docpath <<< "$DOCPATH"
  for i in "${docpath[@]}"; do
    if [[ -d "$i" ]]; then
      path+=("$i")
    fi
  done

  IFS=: read -r -A mandocpath <<< "$MANDOCPATH"
  for i in "${mandocpath[@]}"; do
    if [[ -d "$i" ]]; then
      manpath+=("$i")
    fi
  done

  typeset -U path manpath
fi
