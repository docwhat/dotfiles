function clone-repo() {
  local url="$1"

  local tmpdir="$(mktemp -d "${TMPDIR:-/tmp}/repo.XXXXXXXXXX")"
  if ! hub clone "$url" "$tmpdir"; then
    local ec=$?
    rm -rf "$tmpdir"
    return $ec
  fi

  local dir="$(preferred-checkout-dir "$tmpdir")"
  if [[ -d $dir ]]; then
    echo "Repo '$dir' already cloned." 1>&2
    rm -rf "$tmpdir"
    cd "$dir"
    return 0
  fi

  mv "$tmpdir" "$dir"
  cd "$dir"
}
