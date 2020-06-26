#!/bin/zsh

function reset-kubeconfig {
  local -a configs=( ~/.kube/config.d/*.yaml(.N) )

  export KUBECONFIG=$(
    printf ~/.kube/config
    if (( $#configs > 0 )); then
      printf ":%s" "${(@)configs}"
    fi
  )
}

# If set to a non-standard value, don't override it.
if [[ "${KUBECONFIG:-$HOME/.kube/config}" == "$HOME/.kube/config" ]]; then
  reset-kubeconfig
fi
