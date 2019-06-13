# vim:set ft=zsh:

if [[ -z ${GEM_HOME:-} ]] \
  && ! [[ -d ${RBENV_ROOT:-/qqqqqqq} ]] \
  && [[ $commands[ruby] == /usr/bin/ruby ]] \
  && [[ $commands[gem] == /usr/bin/gem ]]
then
  export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
  path=( "${path[@]}"  "${GEM_HOME}/bin" )
fi
