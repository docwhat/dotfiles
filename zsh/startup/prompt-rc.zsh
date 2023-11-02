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

# OSC 133 integration
# https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md
# https://gitlab.freedesktop.org/Per_Bothner/specifications/-/blob/master/proposals/prompts-data/shell-integration.zsh
_prompt_executing=""
function __prompt_precmd() {
    local ret="$?"
    if test "$_prompt_executing" != "0"
    then
      _PROMPT_SAVE_PS1="$PS1"
      _PROMPT_SAVE_PS2="$PS2"
      PS1=$'%{\e]133;P;k=i\a%}'$PS1$'%{\e]133;B\a\e]122;> \a%}'
      PS2=$'%{\e]133;P;k=s\a%}'$PS2$'%{\e]133;B\a%}'
    fi
    if test "$_prompt_executing" != ""
    then
       printf "\033]133;D;%s;aid=%s\007" "$ret" "$$"
    fi
    printf "\033]133;A;cl=m;aid=%s\007" "$$"
    _prompt_executing=0
}
function __prompt_preexec() {
    PS1="$_PROMPT_SAVE_PS1"
    PS2="$_PROMPT_SAVE_PS2"
    printf "\033]133;C;\007"
    _prompt_executing=1
}
preexec_functions+=(__prompt_preexec)
precmd_functions+=(__prompt_precmd)

# EOF
