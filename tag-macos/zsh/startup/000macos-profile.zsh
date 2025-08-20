# macOS has a utility to set up the PATH.
# I don't want it to clobber _my_ path order, though.
if [[ -x /usr/libexec/path_helper ]]; then
  eval "$(/usr/libexec/path_helper -s | sed 's/PATH=/docwhatPATH=/g')"

  IFS=: read -r -A docpath <<< "$docwhatPATH"
  for i in "${docpath[@]}"; do
    if [[ -d "$i" ]]; then
      path+=("$i")
    fi
  done

  unset docwhatPATH MANdocwhatPATH
  typeset -U path manpath
fi
