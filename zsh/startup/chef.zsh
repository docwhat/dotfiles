if [[ -n $CHEF_LOCATION ]] && [[ -x "${CHEF_LOCATION}/bin/chef" ]]; then

  cache_dir=~/.cache/chef
  mkdir -p "$cache_dir"

  if [[ ! -r  "${cache_dir}/chef-shell-init.zsh" ]] \
    || [[ "${cache_dir}/chef-shell-init.zsh" -ot "${CHEF_LOCATION}/bin/chef" ]]; then
    chef shell-init zsh \
      | grep -Ev '^export' \
      > "${cache_dir}/chef-shell-init.zsh"
  fi

  eval "$(cat "${cache_dir}/chef-shell-init.zsh")"
  unset cache_dir

  alias kitchen-login="simplify-term kitchen login"
fi
