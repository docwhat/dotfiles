declare -aU system_python_bin_dirs=( /usr/local/opt/python[@1-9]*/bin(/N) )
declare -aU user_python_bin_dirs=( ~/Library/Python/*/bin(/N:A) )

for dir in "${(@Oa)user_python_bin_dirs}" "${(@Oa)system_python_bin_dirs}"; do
  path+=("$dir")
done
unset system_python_bin_dirs user_python_bin_dirs

# vim: set ft=zsh :
