# vim: set ft=zsh :

if (( ${+commands[starship]} )); then
  export "KITTY_CONFIG_DIRECTORY=${HOME}/.config/kitty"
fi

# EOF
