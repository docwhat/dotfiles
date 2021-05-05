#!zsh

autoload -U compdef

if (( ${+commands[gnumake]} )); then
  compdef gnumake=gmake
fi
