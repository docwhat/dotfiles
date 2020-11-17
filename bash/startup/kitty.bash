#!/bin/bash
# shellcheck shell=bash

if command -v kitty >/dev/null 2>&1; then
  # shellcheck disable=SC1090
  source <(kitty + complete setup bash)
fi

# EOF
