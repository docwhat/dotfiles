export ASDF_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${ASDF_DIR}"

if [[ -f "${ASDF_DIR}/asdf.sh" ]]; then
  . "${ASDF_DIR}/asdf.sh"

  if [[ -f "${ASDF_DIR}/completions/asdf.bash" ]]; then
    . "${ASDF_DIR}/completions/asdf.bash"
  fi
fi
