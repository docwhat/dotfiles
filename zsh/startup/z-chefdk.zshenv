# vim: ft=zsh :

# Add the ChefDK at the beginning of the path if installed.
if [ -d /opt/chefdk/bin ]; then
  export PATH="/opt/chefdk/bin:${PATH}"
fi
