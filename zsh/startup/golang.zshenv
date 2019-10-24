export GOPATH="$HOME/go"

if [ -d "$HOME/.go" -a ! -d "$HOME/go" ]; then
  mv "$HOME/.go" "$HOME/go"
fi

[ -d "$GOPATH" ] || mkdir -p "$GOPATH"
path=($path "${GOPATH}/bin")

# https://github.com/jfrog/gocenter/wiki
export GOPROXY=https://gocenter.io

# vim: set ft=zsh :
