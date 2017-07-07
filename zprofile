# vim: set ft=zsh :

# Load my customized profile.
for config_file (~/.zsh/startup/*.zprofile(rN)); do
  source "${config_file}"
done
unset config_file

# EOF
