# Oh my zsh config
# See https://github.com/robbyrussell/oh-my-zsh/blob/master/templates/zshrc.zsh-template
DISABLE_AUTO_UPDATE=true
DISABLE_LS_COLORS=true
DISABLE_AUTO_TITLE=true
ENABLE_CORRECTION=true
COMPLETION_WAITING_DOTS=true
HIST_STAMPS=yyyy-mm-dd

# zsh-completion-generator
GENCOMPL_FPATH="$HOME/.zsh/cache/complete"

source "${HOME}/.zgen/zgen.zsh"

function zsh-startup-zgen()
{
  if ! zgen saved; then

    zgen oh-my-zsh

    # # If zsh-syntax-highlighting is bundled after zsh-history-substring-search,
    # # they break, so get the order right.
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-history-substring-search

    # Set keystrokes for substring searching
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down

    # Python
    zgen oh-my-zsh plugins/python
    zgen oh-my-zsh plugins/pip
    zgen load sharat87/pip-app

    # Ruby
    zgen load unixorn/rake-completion.zshplugin

    # Golang
    zgen oh-my-zsh plugins/golang

    # Various Utils
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/rsync
    zgen oh-my-zsh plugins/vagrant
    zgen load srijanshetty/docker-zsh

    zgen load zsh-users/zsh-completions src

    # Git
    zgen load unixorn/git-extra-commands
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/github

    # zgen oh-my-zsh plugins/colored-man-pages
    #
    if [ $(uname -a | grep -ci Darwin) = 1 ]; then
      # Load OSX-specific plugins
      zgen oh-my-zsh plugins/brew
      zgen oh-my-zsh plugins/osx
    fi

    zgen load chrissicool/zsh-256color

    zgen oh-my-zsh plugins/zsh-navigation-tools
    zgen oh-my-zsh plugins/redis-cli
    zgen oh-my-zsh plugins/rsync
    zgen oh-my-zsh plugins/marked2

    # Completion generator
    zgen load RobSis/zsh-completion-generator

    # Add Fish-like autosuggestions to your ZSH
    zgen load zsh-users/zsh-autosuggestions

    # Save it all to init script
    zgen save
  fi
}

zsh-startup-zgen

# EOF
