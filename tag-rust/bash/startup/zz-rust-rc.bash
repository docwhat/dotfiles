if ! command -v rustup &>/dev/null; then
  # shellcheck disable=2312
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
    sh -s -- -y --no-modify-path
fi

# EOF
