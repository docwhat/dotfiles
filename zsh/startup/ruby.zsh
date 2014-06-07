if (( $+commands[rbenv] )) || (( $+commands[rvm] )); then
  function update-gems
  {
    local xargs=xargs

    if ! "$HOME/.zsh/startup/rubygems_needs_update.rb" --debug; then
      echo "$fg[red]You should upgrade rubygems!"
      echo "  gem update --system"
      echo "  gem pristine --all$reset_color"
      return 11
    fi

    if (( $+commands[gxargs] )); then
      xargs=gxargs
    fi

    echo "${fg[blue]}Upgrading builtin gems:$reset_color"
    gem update --conservative rdoc
    ruby -e 'Gem::Specification.select(&:default_gem?).map(&:name).each {|g| print "#{g}\0"}'\
      | $xargs --no-run-if-empty -0 gem update --conservative
    echo "${fg[blue]}Installing missing favorite gems:$reset_color"
    perl -p -e 's/\n/\0/g' ~/.config/docwhat/favorite-gems \
      | $xargs --no-run-if-empty -0 gem install --conservative
    echo "${fg[blue]}Upgrading favorite gems:$reset_color"
    perl -p -e 's/\n/\0/g' ~/.config/docwhat/favorite-gems \
      | $xargs --no-run-if-empty -0 gem update --conservative
  }
fi
