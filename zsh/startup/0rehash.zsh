typeset -a custom_rehash_hooks=()

add-rehash-hook() {
  custom_rehash_hooks+=("$*")
}

custom_rehash() {
  local cmd
  for cmd in "${custom_rehash_hooks[@]}"; do
    eval "$cmd"
  done
  builtin rehash
}

alias rehash=custom_rehash

# EOF
