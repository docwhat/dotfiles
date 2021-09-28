setopt IGNORE_EOF
# Do not exit on end-of-file.  Require the use of exit or logout instead.  However, ten consecutive EOFs will cause the shell to exit anyway, to avoid the shell hanging if
# its tty goes away.
#
# Also, if this option is set and the Zsh Line Editor is used, widgets implemented by shell functions can be bound to EOF (normally Control-D) without printing the  normal
# warning message.  This works only for normal widgets, not for completion widgets.

setopt GLOB_COMPLETE
# When  the  current  word  has a glob pattern, do not insert all the words resulting from the expansion but generate matches as for completion and cycle through them like
# MENU_COMPLETE. The matches are generated as if a `*' was added to the end of the word, or inserted at the cursor when COMPLETE_IN_WORD is set.  This actually  uses  pat-
# tern matching, not globbing, so it works not only for files but for any completion, such as options, user names, etc.
#
# Note  that when the pattern matcher is used, matching control (for example, case-insensitive or anchored matching) cannot be used.  This limitation only applies when the
# current word contains a pattern; simply turning on the GLOB_COMPLETE option does not have this effect.

setopt EXTENDED_GLOB
# Treat the `#', `~' and `^' characters as part of patterns for filename generation, etc.  (An initial unquoted `~' always produces named directory expansion.)
