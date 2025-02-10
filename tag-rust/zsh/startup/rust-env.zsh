# Set RUSTUP_HOME variable if not already set.
export RUSTUP_HOME="${RUSTUP_HOME:-${HOME}/.rustup}"

# Set the CARGO_HOME variable if not already set.
export CARGO_HOME="${CARGO_HOME:-${HOME}/.cargo}"

# Add CARGO_HOME/bin to PATH
path+=("${CARGO_HOME}/bin")

# EOF
