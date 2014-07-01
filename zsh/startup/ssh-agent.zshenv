# vi: ft=zsh :
#
# CREDITS
#
#   Based on code from Oh My ZSH
#   https://github.com/robbyrussell/oh-my-zsh
#
#   Based on code from Joseph M. Reagle
#   http://www.cygwin.com/ml/cygwin/2001-06/msg00537.html
#
#   Agent forwarding support based on ideas from
#   Florent Thoumie and Jonas Pfenniger
#

function _plugin__start_agent()
{
  local -a identities
  local lifetime
  zstyle -s :omz:plugins:ssh-agent lifetime lifetime

  # start ssh-agent and setup environment
  ssh-agent ${lifetime:+-t} ${lifetime} | sed 's/^echo/#echo/' > ${SSH_ENVIRONMENT_FILE}
  chmod 600 ${SSH_ENVIRONMENT_FILE}
  . ${SSH_ENVIRONMENT_FILE} > /dev/null

  # load identies
  zstyle -a :omz:plugins:ssh-agent identities identities
  echo starting ssh-agent...

  ssh-add "${HOME}/.ssh/"${^identities}
}

# Get the filename to store/lookup the environment from
if [ ! -f "${SSH_ENVIRONMENT_FILE}" ]; then
  if (( $+commands[scutil] )); then
    # It's OS X!
    SSH_ENVIRONMENT_FILE="$HOME/.ssh/environment-$(scutil --get ComputerName)"
  else
    SSH_ENVIRONMENT_FILE="$HOME/.ssh/environment-$HOST"
  fi
fi

# test if agent-forwarding is enabled
if [ -n "${SSH_AUTH_SOCK}" ]; then
  # Add a nifty symlink for screen/tmux if agent forwarding
  [[ -L "${SSH_AUTH_SOCK}" ]] || ln -sf "$SSH_AUTH_SOCK" /tmp/ssh-agent-$USER-screen
elif [ -f "${SSH_ENVIRONMENT_FILE}" ]; then
  # Source SSH settings, if applicable
  . ${SSH_ENVIRONMENT_FILE} > /dev/null
  if ! ps x | grep ${SSH_AGENT_PID} | grep ssh-agent > /dev/null; then
    _plugin__start_agent;
  fi
else
  _plugin__start_agent;
fi

export SSH_ENVIRONMENT_FILE

# tidy up after ourselves
unfunction _plugin__start_agent
