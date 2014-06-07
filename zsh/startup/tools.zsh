# -*- sh -*-
# vi: ft=zsh :

path=(~/.bin "${path[@]}")

alias gitlog="echo -n '====> '; git rev-parse --abbrev-ref HEAD ; git log '@{u}..'"

# EOF
