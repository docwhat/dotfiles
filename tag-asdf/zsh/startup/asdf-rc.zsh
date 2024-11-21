
export ASDF_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${ASDF_DIR}"

if [[ -f "${ASDF_DIR}/asdf.sh" ]]; then
  . "${ASDF_DIR}/asdf.sh"

  if [[ -d "${ASDF_DIR}/completions" ]]; then
    fpath=( "${ASDF_DIR}/completions" $fpath )
  fi

  # Reshim when we type 'rehash'.
  add-rehash-hook "asdf reshim"
fi

# EOF
