if [[ -n $CHEF_LOCATION ]] && [[ -x "${CHEF_LOCATION}/bin/chef" ]]; then

  function require-kitchen-yml() {
    if [ ! -r .kitchen.yml ]; then
      echo 'No .kitchen.yml present!' 1>&2
      return 1
    fi
  }

  alias kl="kitchen list"
  alias kc="kitchen converge"
  alias kv="kitchen verify"
  alias kd="kitchen destroy"
  alias kt="kitchen test"
  alias kitchen='require-kitchen-yml && "${CHEF_LOCATION}/bin/chef" exec kitchen'

  function kcv() {
    require-kitchen-yml || return 1

    "${CHEF_LOCATION}/bin/chef" exec kitchen converge "$@" || return $?

    "${CHEF_LOCATION}/bin/chef" exec kitchen verify "$@" || return $?
  }

  function ks() {
    require-kitchen-yml || return 1

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

    env TERM="${new_term}" "${CHEF_LOCATION}/bin/chef" exec kitchen login "$@"
  }

  mkdir -p ~/.cache/zsh/

  if [[ ! -r  ~/.cache/zsh/chef-shell-init.zsh ]] || [[ ~/.cache/zsh/chef-shell-init.zsh -ot "$CHEF_LOCATION" ]]; then
    "${CHEF_LOCATION}/bin/chef" shell-init zsh | grep -Ev '^export' > ~/.cache/zsh/chef-shell-init.zsh
  fi

  eval "$(cat ~/.cache/zsh/chef-shell-init.zsh)"
fi
