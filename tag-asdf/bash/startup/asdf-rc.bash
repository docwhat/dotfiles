# shellcheck disable=SC2034
ASDF_DIR="${XDG_DATA_HOME}/asdf"
ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
ASDF_DATA_DIR="${ASDF_DIR}"

if [[ -f "${ASDF_DIR}/asdf.sh" ]]; then
  # shellcheck disable=SC1091
  . "${ASDF_DIR}/asdf.sh"

  if [[ -f "${ASDF_DIR}/completions/asdf.bash" ]]; then
    # shellcheck disable=SC1091
    . "${ASDF_DIR}/completions/asdf.bash"
  fi
fi
