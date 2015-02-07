
for lousy_aliases in cp rm mv; do
  if (( $+aliases[$lousy_aliases] )); then
    unalias $lousy_aliases
  fi
done

unset lousy_aliases

# Fix the SHORT_HOST if it has (2) after it.
if [ -n "${SHORT_HOST}" ]; then
  SHORT_HOST="${SHORT_HOST%% \(*\)}"
fi
