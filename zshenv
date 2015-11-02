# vim: ft=zsh :

# Load my customized environment.
for config_file (~/.zsh/startup/*.zshenv(rN)); do
  source "${config_file}"
done
unset config_file

# EOF
