# vi: ft=zsh :

if [ -d /usr/local/opt/ruby/share/man ]; then
  manpath=("${manpath[@]}" /usr/local/opt/ruby/share/man)
fi

if [ -d /usr/local/opt/ruby/bin ]; then
  path=("${path[@]}" /usr/local/opt/ruby/bin)
fi

# EOF
