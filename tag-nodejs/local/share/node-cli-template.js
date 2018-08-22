#!/usr/bin/env node

const pkg = process.argv[2]
const cmd = process.argv[3]
const ver = process.argv[4]

console.log(`#!/bin/bash

#!/bin/bash
##marker: NODEJS-CLI-TOOL##
set -eEuo pipefail

package='${pkg}'
command='${cmd}'

export NODENV_VERSION='${ver}'

local_bin="$(npm bin 2>/dev/null)"
global_bin="$(npm bin --global 2>/dev/null)"

if [ -x "\${local_bin}/\${command}" ]; then
  exec "\${local_bin}/\${command}" "$@"
fi

if [ -x "\${global_bin}/\${command}" ]; then
  exec "\${global_bin}/\${command}" "$@"
fi

npm install --global "$package" >/dev/null 2>&1
exec "\${global_bin}/\${command}" "$@"

#EOF`)
