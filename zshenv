# vim: ft=zsh :

# Export and uniq. paths
typeset -xU \
  fpath \
  FPATH \
  path \
  PATH \
  manpath \
  MANPATH

# The path has to be set *first*
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  /usr/local/sbin
  /usr/local/bin
  /usr/local/share/npm/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  /opt/X11/bin
  "${path[@]}"
)

manpath=(
  /usr/local/share/man
  /usr/share/man
  /usr/X11/man
  /opt/X11/share/man
)

# Load my customized environment.
for config_file (~/.zsh/startup/*-env.zsh(rN)); do
  source "${config_file}"
done
unset config_file

# EOF
