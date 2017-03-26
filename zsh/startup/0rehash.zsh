typeset -a custom_rehash_hooks=()

function custom_rehash {
  for hook in "${custom_rehash_hooks[@]}"; do
    "$hook"
  done
  builtin rehash
}

alias rehash=custom_rehash

# EOF
