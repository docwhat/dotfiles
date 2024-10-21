#!zsh

# Keep the configs secure.
if ! [[ -d ~/.kube/config.d ]]; then
  mkdir -m 0700 -p ~/.kube/config.d
fi

if [[ -f ~/.kube/config ]]; then
  chmod 0600 ~/.kube/config
fi
