#!/usr/bin/env node

const pkg = process.argv[2]
const cmd = process.argv[3]

console.log(`#!/bin/bash

#!/bin/bash
set -eEuo pipefail

package='${pkg}'
command='${cmd}'

exe="$(npm bin --global 2>/dev/null)/\${command}"

if [ ! -x "$exe" ]; then
  npm install --global "$package" >/dev/null 2>&1
fi

exec "$(npm bin --global 2>/dev/null)/\${command}" "$@"

#EOF`)
