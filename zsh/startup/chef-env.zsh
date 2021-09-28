declare -a chef_locations=(
  /opt/chef-workstation
  /opt/chefdk
  /opt/chef
)

for chef_location in "${chef_locations[@]}"; do
  if [[ -d $chef_location ]]; then
    CHEF_LOCATION=$chef_location
    break
  fi
done

unset chef_location chef_locations

# vim: set ft=zsh :
