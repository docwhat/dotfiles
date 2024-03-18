# macOS has a utility to set up the PATH.
if [[ -x /usr/libexec/path_helper ]]; then
  eval `/usr/libexec/path_helper -s`
fi
