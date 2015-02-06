if [[ -d /opt/chef || -d /opt/chefdk || -d ~/.chef ]]; then
  alias kl="kitchen list"
  alias kc="kitchen converge"
  alias kv="kitchen verify"
  alias kd="kitchen destroy"
  alias kt="kitchen test"
  alias ks="kitchen login"
fi
