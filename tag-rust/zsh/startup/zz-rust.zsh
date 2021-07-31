zinit ice \
  --as='completion' \
  --atclone="chmod +x ./rustup-init.sh &&
  ./rustup-init.sh -y --verbose --no-modify-path --default-toolchain none --profile minimal &&
  ~/.cargo/bin/rustup --version &&
  ~/.cargo/bin/rustup completions zsh cargo > ./_cargo &&
  ~/.cargo/bin/rustup completions zsh rustup > ./_rustup" \
  --atpull='%atclone' \
  --atload='if [[ -f "$HOME/.cargo/env" ]]; then source "$HOME/.cargo/env"; fi'

zinit snippet 'https://github.com/rust-lang/rustup/blob/master/rustup-init.sh'

# EOF
