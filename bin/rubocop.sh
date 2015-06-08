#!/bin/bash

set -eu

# Work around for a bug in rubocop, ruby-parser and ruby:
# https://github.com/scrooloose/syntastic/issues/1418
if [ $# -eq 1 -a "${1:-}" = --version ]; then
    rubocop "$@" 2>&1 | \
        sed '/warning: parser\/current is loading parser\/ruby[0-9]*, which recognizes/d;
             /warning: [0-9.]*-compliant syntax, but you are running [0-9.]/d'
else
    exec rubocop "$@"
fi
