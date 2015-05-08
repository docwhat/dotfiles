# vi : ft=zsh :

if [ -r ~/.config/personal/rbenv-root ]; then
  RBENV_ROOT=$(cat ~/.config/personal/rbenv-root)
else
  RBENV_ROOT="${HOME}/.rbenv"
  # Save it for future use.
  echo "$RBENV_ROOT" > ~/.config/personal/rbenv-root
fi

export RBENV_ROOT
