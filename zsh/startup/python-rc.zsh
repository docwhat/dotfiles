# https://github.com/sorin-ionescu/prezto/blob/e9197234cfd051effa75fa98344f845e1d818972/modules/python/init.zsh#L149-L178
# Load PIP completion.
# Detect and use one available from among 'pip', 'pip3' variants
if [[ -n $PYENV_ROOT ]] && (( ${+commands[pyenv]} )); then
  for pip in pip{,3}; do
    pip_command="$(pyenv which "$pip" 2>/dev/null)"
    [[ -n $pip_command ]] && break
  done
  unset pip
else
  pip_command="$commands[(i)pip(|[3])]"
fi

if [[ -n $pip_command ]]; then
  cache_file="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/pip-cache.zsh"

  if [[ $pip_command -nt $cache_file || ! -s $cache_file ]]; then
    mkdir -p "$cache_file:h"
    # pip is slow; cache its output. And also support 'pip3' variants
    "$pip_command" completion --zsh |
      sed -e "s/\(compctl -K [-_[:alnum:]]* pip\).*/\1{,3}{,.{0..9}}/" \
        >!"$cache_file" \
        2>/dev/null
  fi

  source "$cache_file"

  unset cache_file
fi
unset pip_command

# EOF
