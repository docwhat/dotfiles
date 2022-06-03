unset ZINIT ZPFX
declare -A ZINIT
ZINIT[HOME_DIR]="$XDG_DATA_HOME/zinit"
ZPFX="${ZINIT[HOME_DIR]}/polaris"
ZINIT[MAN_DIR]="$ZPFX/man"
ZINIT[ZERO]="${ZINIT[HOME_DIR]}/zinit.git/zinit.zsh"

# skywind3000/z.lua
export _ZL_ADD_ONCE=1
export _ZL_DATA="$XDG_DATA_HOME/z.lua/database"
export _ZL_ECHO=1
export _ZL_HYPHEN=1
export _ZL_MATCH_MODE=1
export _ZL_ROOT_MARKERS=".git,.svn,.hg,.root,package.json"

# RobSis/zsh-completion-generator
if [[ -z $GENCOMPL_PY ]] && [[ -z "${commandds[python]}" ]] && [[ -n "${commands[python3]}" ]]; then
  # It doesn't auto-detect 'python3' when 'python' is missing.
  GENCOMPL_PY=python3
fi
GENCOMPL_FPATH="${ZSH_CACHE_DIR}/completion-generator"

manpath=( $ZPFX/man "${manpath[@]}" )

# EOF
