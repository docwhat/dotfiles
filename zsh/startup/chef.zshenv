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

if [[ -n $CHEF_LOCATION ]]; then
  # https://github.com/someara/kitchen-dokken
  # https://kitchen.ci/docs/faq
  KITCHEN_YAML=.kitchen.yml
  KITCHEN_LOCAL_YAML=.kitchen.dokken.yml
  export KITCHEN_YAML KITCHEN_LOCAL_YAML
fi

# vim: set ft=zsh :
