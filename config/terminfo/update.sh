#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

curl -z terminfo.src.gz -o terminfo.src.gz http://invisible-island.net/datafiles/current/terminfo.src.gz
gzcat terminfo.src.gz > terminfo.src

rm -rf ~/.terminfo
tic -xa terminfo.src

# EOF
