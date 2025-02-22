export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"

path=(
  "${ASDF_DATA_DIR}/shims" $path
)

# EOF
