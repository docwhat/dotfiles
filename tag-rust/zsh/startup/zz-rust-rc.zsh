if [[ -n "${CARGO_HOME:-}" ]] && ! [[ -x "${CARGO_HOME}/bin/rustup" ]]; then
  # shellcheck disable=2312
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
    sh -s -- -y --no-modify-path
fi

# EOF
