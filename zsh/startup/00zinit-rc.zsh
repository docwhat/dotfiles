declare -A ZINIT

# ZINIT[HOME_DIR]="$XDG_CACHE_HOME/zinit"
# ZINIT[PLUGINS_DIR]="${ZINIT[HOME_DIR]}/plugins"
# ZINIT[COMPLETIONS_DIR]="${ZINIT[HOME_DIR]}/completions"
# ZINIT[SNIPPETS_DIR]="${ZINIT[HOME_DIR]}/snippets"
# mkdir -p "${ZINIT[HOME_DIR]}" "${ZINIT[PLUGINS_DIR]}" "${ZINIT[COMPLETIONS_DIR]}" "${ZINIT[SNIPPETS_DIR]}"

# ZINIT[BIN_DIR]="$HOME/.zinit/bin"
# fpath+=("${ZINIT[BIN_DIR]}")

mkdir -p \
  ~/.zinit/plugins \
  ~/.zinit/completion \
  ~/.zinit/snipptes

source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# EOF
