# vim: ft=zsh :

# Add the ChefDK at the beginning of the path if installed.
if [ -d /opt/chefdk/bin ]; then
  if [ "$ZSH_ENABLECHEFDK" = true ]; then
    eval "$(chef shell-init zsh)"
  else
    function chefdk
    {
      env \
        ZSH_ENABLERUBY=false \
        ZSH_ENABLECHEFDK=true \
        PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/opt/ruby/bin:/opt/X11/bin \
        zsh -l
    }
  fi
fi
