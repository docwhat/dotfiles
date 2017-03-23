fpath=(~/.zsh/functions "${fpath[@]}")
autoload -Uz ~/.zsh/functions/*(N:t)

# Set the time builtin format.
TIMEFMT="${fg[green]}%J${reset_color}  %P cpu  %M KiB  ${fg[cyan]}%*E${reset_color} total"

# Report the time for anything that takes longer than 2 seconds.
REPORTTIME=2

# Disable compinit generation by Ubuntu and Debian.
skip_global_compinit=1

# Ubuntu/Debian shouldn't muck with my keyboard.
DEBIAN_PREVENT_KEYBOARD_CHANGES=1

# Local man files
if [ -d ~/.local/share/man ]; then
  manpath=( "${manpath[@]}" ~/.local/share/man )
fi
