# vim: ft=zsh :

path=(~/bin ~/.bin "$path[@]")

# Fix the paths up
typeset -axU path manpath
