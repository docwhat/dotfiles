
for lousy_aliases in cp rm mv; do
  if (( $+aliases[$lousy_aliases] )); then
    unalias $lousy_aliases
  fi
done

unset lousy_aliases
