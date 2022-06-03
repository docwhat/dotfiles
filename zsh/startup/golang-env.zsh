export GOPATH="$HOME/go"

if [ -d "$HOME/.go" -a ! -d "$HOME/go" ]; then
  mv "$HOME/.go" "$HOME/go"
fi

[ -d "$GOPATH" ] || mkdir -p "$GOPATH"
path+=("${GOPATH}/bin")

# vim: set ft=zsh :
