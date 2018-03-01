#!/bin/bash

set -eEuo pipefail

while (( "$#" > 0 )); do
  case "${1}" in
    --help|-h)
      echo "$0 [user@]host"
      exit 0
      ;;
    *)
      break
      ;;
  esac
  shift
done

infocmp -x \
  | ssh "$@" -- \
  'tmpfile="${TMPDIR:-${TMP:-/tmp}}/${user}.'"${TERM}"'.$$.terminfo"; dd of="$tmpfile" ; tic -x "$tmpfile" ; rm -f "$tmpfile"'

echo
if ssh "$@" -- 'env TERM='"${TERM}"' infocmp -x >/dev/null'; then
  echo "The TERM '${TERM}' has been sent." 1>&2
else
  echo "ERROR: Failed to send the TERM '${TERM}'." 1>&2
  exit 1
fi

# EOF
