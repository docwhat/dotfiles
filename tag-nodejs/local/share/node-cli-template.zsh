#!/usr/bin/env zsh

set -eu
setopt pipefail

package="$1"
command="$2"
node_version="$3"

echo '#!/bin/bash'
echo
echo '##marker: NODEJS-CLI-TOOL##'
echo
echo 'set -eEuo pipefail'
echo
echo "package=${(q)package}"
echo "command=${(q)command}"
echo "node_version=${(q)node_version}"
echo 'prefix="${HOME}/.cache/nodejs-cli-tool/node-${node_version}"'
echo
echo 'export NODENV_VERSION=$node_version'
echo
echo 'function do_install() {'
echo '  npm install --global --prefix "$prefix" "$package"'
echo '}'
echo
echo 'if [ -n "${TOOL_INSTALL:-}" ]; then'
echo '  do_install'
echo '  exit'
echo 'fi'
echo
echo 'local_bin="$(npm bin 2>/dev/null)"'
echo 'global_bin="${prefix}/bin"'
echo
echo 'if [ -x "${local_bin}/${command}" ]; then'
echo '  exec "${local_bin}/${command}" "$@"'
echo 'fi'
echo
echo 'if [ -x "${global_bin}/${command}" ]; then'
echo '  exec "${global_bin}/${command}" "$@"'
echo 'fi'
echo
echo 'do_install >/dev/null 2>&1'
echo 'exec "${global_bin}/${command}" "$@"'
echo
echo '# EOF'

# EOF
