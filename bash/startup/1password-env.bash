# 1Password shell integration.

for sock in \
  "${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" \
  "${HOME}/.1password/agent.sock" \
  "${SSH_AUTH_SOCK:-}"; do
  if [[ -S ${sock} ]]; then
    export SSH_AUTH_SOCK="${sock}"
    break
  fi
done

# https://developer.1password.com/docs/cli/about-biometric-unlock/
export OP_BIOMETRIC_UNLOCK_ENABLED=true

# EOF
