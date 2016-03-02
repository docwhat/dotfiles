# vim: ft=zsh :

export GOPATH="$HOME/.go"
[ -d "$GOPATH" ] || mkdir -p "$GOPATH"
path=($path "${GOPATH}/bin")
