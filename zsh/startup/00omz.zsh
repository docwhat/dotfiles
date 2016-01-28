
for lousy_alias in cp rm mv; do
  if (( $+aliases[$lousy_alias] )); then
    unalias $lousy_alias
  fi
done
unset lousy_alias

# Fix the SHORT_HOST if it has (2) after it.
if [ -n "${SHORT_HOST}" ]; then
  SHORT_HOST="${SHORT_HOST%% \(*\)}"
fi
