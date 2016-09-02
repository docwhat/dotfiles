fpath=(~/.zsh/functions "${fpath[@]}")
autoload -Uz ~/.zsh/functions/*(N:t)

# Set the time builtin format.
TIMEFMT="${fg[green]}%J${reset_color}  %P cpu  %M KiB  ${fg[cyan]}%*E${reset_color} total"

# Report the time for anything that takes longer than 2 seconds.
REPORTTIME=2
