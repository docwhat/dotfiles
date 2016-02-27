# vim: ft=zsh :

# While this is named after ack, when I switched to ag (the Silver Searcher) I didn't
# rename the file.

if (( $+commands[ag] )); then
  alias  ag="ag --pager 'less -RS' --smart-case -C3 --color-line-number '1;34' --color-match '1;04;31' --color-path '1;32'"
  alias agr='ag --ruby'
  alias agy='ag --yaml'
  alias agm='ag --markdown'
  alias agh='ag --html'
  alias agx='ag --xml'
  alias ack="echo 'Use ag instead.' ; false"
fi
