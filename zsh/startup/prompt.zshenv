if [[ "$TERM" == dumb ]] || [[ "$EMACS" == t ]] || [[ "$TERM_PROGRAM" == Prompt_2 ]]; then
   PS4='+%N:%i> '
   SUDO_PROMPT='[sudo] %p -> %U: '
else
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

   SUDO_PROMPT='🔐 [sudo] %p → %U: '
fi

export SUDO_PROMPT

# vim: set ft=zsh :
