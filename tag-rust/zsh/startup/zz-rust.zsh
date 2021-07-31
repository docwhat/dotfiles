zinit ice \
  --as='completion' \
  --atclone="chmod +x ./rustup-init.sh &&
  ./rustup-init.sh -y --verbose --no-modify-path --default-toolchain none &&
  ~/.cargo/bin/rustup completions zsh rustup > ./_rustup &&
  ~/.cargo/bin/rustup completions zsh cargo > ./_cargo" \
  --atpull='%atclone' \
  --atload='if [[ -f "$HOME/.cargo/env" ]]; then source "$HOME/.cargo/env"; fi'

zinit snippet 'https://github.com/rust-lang/rustup/blob/master/rustup-init.sh'

# EOF
