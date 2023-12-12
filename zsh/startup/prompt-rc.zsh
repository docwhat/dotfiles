if [[ "$TERM" == dumb ]] || [[ "$EMACS" == t ]] || [[ "$TERM_PROGRAM" == Prompt_2 ]]; then
   # Disable powerlevel9k
   if [ $+functions[prompt_powerlevel9k_teardown] ]; then
      prompt_powerlevel9k_teardown
   fi
   PS1='zsh%# '
   PS2='%_>'
   PS3='?# '
   PS4='+%N:%i> '
   unset RPROMPT
   unset RPROMPT2
elif [ "$SIMPLE_PROMPT" = t ]; then
   if [ $+functions[prompt_powerlevel9k_teardown] ]; then
      prompt_powerlevel9k_teardown
   fi

   autoload -Uz promptinit && promptinit
   prompt adam1
else
   # The secondary prompt, printed when the shell needs more information
   # to complete a command.  It is expanded in the same way as PS1.
   # The default is `%_> ', which displays any shell constructs or quotation
   # marks which are currently being processed.
   PS2='%s%f%b%k'
   PS2+='%F{blue}'
   PS2+='%L:'
   PS2+='%_'
   PS2+='%F{green}'
   PS2+=$'%{\uE0B0%}' # an arrow: 
   PS2+='%s%f%b%k '

   # Selection prompt used within a select loop.  It is expanded in the same
   # way as PS1.  The default is `?# '.
   # http://www.thegeekstuff.com/2008/09/bash-shell-take-control-of-ps1-ps2-ps3-ps4-and-prompt_command/
   PS3='%s%f%b%k'
   PS3+='%F{green}'
   PS3+='select:'
   PS3+='%s%f%b%k '
fi

# EOF
