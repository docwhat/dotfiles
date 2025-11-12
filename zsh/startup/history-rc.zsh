if [[ ! -d ~/.zsh ]]; then
  mkdir -p ~/.zsh
fi
HISTFILE=~/.zsh/history
SAVEHIST=$((100 * 1000))
HISTSIZE=$((SAVEHIST * 1.20))

# Setopt names are case insensitive and underscores are ignored.

# Treat the '!' character specially during expansion.
setopt bang_hist

# Write the history file in the ":start:elapsed;command" format.
setopt extended_history

# Beep when accessing nonexistent history.
setopt hist_beep

# Use the system's fcntl() call if available.
setopt hist_fcntl_lock

# Expire duplicate entries first when trimming history.
setopt hist_expire_dups_first

# Don't record an entry that was just recorded again.
setopt hist_ignore_dups

# Do not display a line previously found.
setopt hist_find_no_dups

# Don't write duplicate entries in the history file.
setopt hist_save_no_dups

# Delete old recorded entry if new entry is a duplicate.
setopt hist_ignore_all_dups

# Don't record an entry starting with a space.
setopt hist_ignore_space

# Remove superfluous blanks before recording entry.
setopt hist_reduce_blanks

# Don't execute immediately upon history expansion.
setopt hist_verify

# Write to the history file immediately, not when the shell exits.
# Mutually exclusive with share_history and inc_append_history_time.
setopt no_inc_append_history

# Share history between all sessions.
# Mutually exclusive with inc_append_history and inc_append_history_time.
setopt no_share_history

# Like inc_append_history, but writes the line after the command finishes so
# that the time-took is recorded accurately.
# Mutually exclusive with share_history and no_inc_append_history.
setopt inc_append_history_time

# When saving history, write history to $HISTFILE.new and rename it over the
# old one.
setopt hist_save_by_copy

# Since we don't automatically import new entries in the histfile.
# 'rehist' will reload history from the histfile.
alias rehist='fc -Ri'
