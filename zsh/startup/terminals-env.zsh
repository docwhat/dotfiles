case "$TERM_PROGRAM" in
  iTerm.app )
    # We display UTF-8 correctly.
    setopt combining_chars
    ;;
  Apple_Terminal )
    # We display UTF-8 correctly.
    setopt combining_chars
    ;;
esac
