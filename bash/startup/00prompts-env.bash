#
#
# set a fancy prompt (non-color, unless we know we "want" color)
if command -v tput >/dev/null && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
else
  color_prompt=
fi

if [[ ${color_prompt} == yes ]]; then
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  PS4='+\[\033[01;34m\](${BASH_SOURCE[0]:-stdin}:${LINENO})\[\033[00m\]: ${FUNCNAME[0]:+\[\033[01;33m\]${FUNCNAME[0]}()\[\033[00m\]: }'
else
  PS1='\u@\h:\w\$ '
  PS4='+(${BASH_SOURCE[0]:-stdin}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
fi

unset color_prompt
export PS4

# EOF
