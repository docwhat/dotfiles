# vim: set ft=zsh :

# This is an interesting idea... http://deenewcum.github.io/termdetect/
# curl -L http://is.gd/termdetect -o ~/bin/termdetect;  chmod +x ~/bin/termdetect
if (( $+commands[termdetect] )); then
  export TERM=$("${commands[termdetect]}" -t)
fi
