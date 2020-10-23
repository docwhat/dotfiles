#!bash
# ~/.bashrc: executed by bash(1) for non-login shells.

if [ -r ~/.bashenv ]; then
  # shellcheck disable=SC1090
  . ~/.bashenv
fi

# If not running interactively, don't do anything
case "$-" in
*i*) ;;
*) return ;;
esac

# Setup history
# https://sanctum.geek.nz/arabesque/better-bash-history/
shopt -s histappend
shopt -s cmdhist

HISTFILESIZE=1000000
HISTSIZE=1000000
HISTTIMEFORMAT='%F %T '
HISTCONTROL=ignoreboth
HISTIGNORE='ls:bg:fg:history'
PROMPT_COMMAND='history -a'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\\[\\e]0;\\u@\\h: \\w\\a\\]$PS1"
  ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  if test -r ~/.dircolors; then
    eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  fi
  alias ls='ls --color=auto -CF'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -f ~/.bash_aliases ]; then
  # shellcheck disable=SC1090
  . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  # If set, the pattern "**" used in a pathname expansion context will
  # match all files and zero or more directories and subdirectories.
  shopt -s globstar

  if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
    # shellcheck disable=SC1091
    . "/usr/local/etc/profile.d/bash_completion.sh"
  elif [ -f /usr/share/bash-completion/bash_completion ]; then
    # shellcheck disable=SC1091
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    # shellcheck disable=SC1091
    . /etc/bash_completion
  fi
fi

for rc in ~/.bash/startup/*-rc.bash; do
  . "$rc"
done

# EOF
