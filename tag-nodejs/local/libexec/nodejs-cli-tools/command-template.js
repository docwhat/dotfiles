#!/usr/bin/env node

const pkg = process.argv[2]
const cmd = process.argv[3]

console.log(`#!/bin/bash

set -eu

declare -r pkg_dir="\${HOME}/.local/libexec/nodejs-cli-tools/${pkg}"

if [ "\${1:-}" == __PRINT_pkg ]; then
  echo "\$pkg_dir"
  exit 0
fi

declare -r npm_bin="$(npm bin)"

if [ -d "$npm_bin" ] && [ -x "\${npm_bin}/${cmd}" ]
then
  exec "\${npm_bin}/${cmd}" "\$@"
else
  exec "\${pkg_dir}/node_modules/.bin/${cmd}" "\$@"
fi`)
