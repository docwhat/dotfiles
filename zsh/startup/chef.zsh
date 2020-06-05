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

  alias kl="kitchen list"
  alias kc="kitchen converge"
  alias kv="kitchen verify"
  alias kd="kitchen destroy"
  alias kt="kitchen test"

  function kcv() {
    kitchen converge "$@" || return $?
    kitchen verify "$@" || return $?
  }

  function ks() {
    case "$TERM" in
    screen*)
      new_term=screen
      ;;
    tmux*)
      new_term=screen
      ;;
    xterm*)
      new_term=xterm
      ;;
    *)
      new_term=$TERM
      ;;
    esac

    env TERM="${new_term}" kitchen login "$@"
  }
fi
