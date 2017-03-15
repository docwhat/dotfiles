# Turn off globbing for pip, to allow square brackets.
# Also, pick the most recent one.
if [ $+commands[pip3] ]; then
  alias pip="noglob pip3"
  alias pip3="noglob pip3"
elif [ $+commands[pip] ]; then
  alias pip="noglob pip"
elif [ $+commands[pip2] ]; then
  alias pip="noglob pip2"
  alias pip2="noglob pip2"
fi
