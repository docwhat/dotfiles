if [[ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]]; then
  # shellcheck disable=1091
  . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi
