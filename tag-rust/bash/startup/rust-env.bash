# Set RUSTUP_HOME variable if not already set.
export RUSTUP_HOME="${RUSTUP_HOME:-${HOME}/.rustup}"

# Set the CARGO_HOME variable if not already set.
export CARGO_HOME="${CARGO_HOME:-${HOME}/.cargo}"

# Add CARGO_HOME/bin to PATH if it isn't already there.
if [[ ":${PATH}:" != *":${CARGO_HOME}/bin:"* ]]; then
  export PATH="${PATH}:${CARGO_HOME}/bin"
fi

# EOF
