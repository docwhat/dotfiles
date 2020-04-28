# Create a cache directory if it doesn't exist.
if [[ ! -d "${ZSH_CACHE_DIR}" ]]; then
  mkdir -p "${ZSH_CACHE_DIR}"
fi

# Force starting compinit as early as possible
declare -a compinit_args=( '-d' "$ZSH_COMPDUMP" )
if [[ "$module_path" =~ /usr/local/Cellar/* ]]; then
  compinit_args+=( '-u' )
fi
autoload -Uz compinit && compinit "${(@)compinit_args}"

unset compinit_args
function compinit { }
