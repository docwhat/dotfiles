function git-repo() {
  local -r url="$1"
  local -r clonedir=$(guess-src-dir-from-git-url "$url")

  if ! [[ -d "$clonedir" ]]; then
    mkdir -p "$(dirname "$clonedir")"

    local -r uhost=$(ruby -ruri -e 'print URI(ARGV.first).host' "$url")

    if [[ -z "$uhost" ]] || [[ $host == github.com ]]; then
      if ! (( ${+commands[gh]} )); then
        echo "The 'gh' utility is required: https://github.com/cli/cli"
      fi

      gh repo clone "$url" "$clonedir" -- --filter=blob:none || return $?
    else
      git clone --filter=blob:none "$url" "$clonedir" || return $?
    fi
  fi

  cd "$clonedir"
}

function guess-src-dir-from-git-url() {
  local -r url=$(ruby -e 'print ARGV.first.sub(/^([^@]+)@([^:\/]+):/, "ssh://\\1@\\2/")' "$1")


  local -r uhost=$(ruby -ruri -e 'print URI(ARGV.first).host' "$url")

  if [[ -z "$uhost" ]]; then
    if [[ $url =~ / ]]; then
    echo "${HOME}/src/github.com/$url"
  else
    echo "${HOME}/src/github.com/docwhat/$url"
    fi
  else
    local -r upath=$(ruby -ruri -e 'print URI(ARGV.first).path.sub(/^\//,"").sub(/\.git$/,"").split(/\//)[0,2].join("/")' "$url")
    echo "${HOME}/src/$uhost/$upath"
  fi
}

# c is a short-cut for running git with one of these operations:
#  - cherry-pick
#  - merge
#  - rebase
#  - revert
#
# It passes --continue by default.
#
# @param {string} $* - The arguments to pass to the git operation. Defaults to --continue.
function c() {
	local -ra operations=(
		CHERRY_PICK
		MERGE
		REBASE
		REVERT
	)
	local op cmd

	for op in "${operations[@]}"; do
		if git rev-parse --verify "${op}_HEAD" 2>/dev/null; then
			cmd=$(echo "${op/_/-}" | tr '[:upper:]' '[:lower:]')
			git "$cmd" "${1:---continue}"
			return
		fi
	done

	{
		echo "We weren't in a git operation, and the command failed: $*"
	} >&2
	return 1
}
