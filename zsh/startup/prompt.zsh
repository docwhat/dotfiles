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

   # The execution trace prompt.  Default is `+%N:%i> ', which displays the
   # name of the current shell structure and the line number within
   # it. In sh or ksh emulation, the default is `+ '.
   PS4='%s%f%b%k'

   PS4+=$'%F{blue}'
   PS4+=$'%{\u03BB%}%L '

   # The name of the script, sourced file, or shell function that zsh is currently executing, whichever was started most recently
   PS4+='%F{240}'
   PS4+='%N:%i'

   # The return status of the last command executed just before the prompt
   PS4+='%(?.. %F{red}%?)'

   # The status of the parser, i.e. the shell constructs (like `if' and `for') that have been started on the command line.
   PS4+=' %1(_.%F{yellow}%-1_ .)'

   # The end of the prompt
   # PS4+='%F{blue}'
   # PS4+=$'%{\u03BB%}'
   PS4+='%s%f%b%k' # reset all colors
   PS4+=$'\t'
fi
