# 1Password shell integration.

if [[ -z ${SSH_AUTH_SOCK} ]] && command -v op 1>/dev/null 2>&1; then
  for sock in "${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" "${HOME}/.1password/agent.sock"; do
    if [[ -S ${sock} ]]; then
      export SSH_AUTH_SOCK="${sock}"
    fi
  done

  # https://developer.1password.com/docs/cli/about-biometric-unlock/
  export OP_BIOMETRIC_UNLOCK_ENABLED=true
fi

# EOF
