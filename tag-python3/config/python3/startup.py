# -*- coding: iso-8859-15 -*-
"""
PYTHONRC - Really Neat way to make the python shell fun and usable!.

Copy this file to some place in your home directory.

This is called when interactive python interpreter is instructed to:
    import user
You can force this to import everytime by setting an environment variable:
    export PYTHONSTARTUP="path/to/this/file.py"
"""


class PythonStartup:
    histfile = None
    debug = None

    def init(cls):
        """Initialize a nice environment to run in."""

        from os import getenv, path

        cls.debug = getenv("PYTHONRC_DEBUG")

        if getenv("NOPYTHONRC"):
            # Not loading the python environment
            cls.dp("Skipping loading the pythonrc environment stuff")
            return

        try:
            import readline
        except ImportError:
            print("Failed to load readline")
            readline = None
        cls.readline = readline

        if readline:
            # Set the history file
            cls.histfile = path.join(getenv("HOME", "."), ".python_history")
            cls.dp("Using history file '%s'" % cls.histfile)

            # Read the history file
            if path.exists(cls.histfile):
                readline.read_history_file(cls.histfile)
                cls.dp("Using existing history information")
            else:
                cls.dp("Creating new history file")

            # Set the number of history items to 3000
            readline.set_history_length(3000)
            cls.dp("History size set to 3000")

            # Put a marker for the starting time.
            readline.add_history("# starting %s" % cls.strtime())
            cls.dp("Marked start of history file")

            # Allow Tab Completion

            readline.parse_and_bind("tab: complete")
            cls.dp("Started completion")
        else:
            cls.dp("No readline available")

        # Set the prompts
        import sys

        sys.ps1 = "python%s> " % ".".join(map(str, sys.version_info[:2]))
        sys.ps2 = " " * (len(sys.ps1) - 2) + "> "
        cls.dp("Set prompts")

        # The the exit function
        import atexit

        atexit.register(cls.exit)
        cls.dp("Registered exit function")

    init = classmethod(init)

    def dp(cls, *msgs):
        """Debugging Print."""
        if cls.debug:
            for msg in msgs:
                print("PYTHONRC: %s" % msg)

    dp = classmethod(dp)

    def strtime(cls):
        """Return the time in a nicely formatted string."""
        import time

        fmtstr = "%A %I:%M %p, %B %d, %Y %Z"
        return time.strftime(fmtstr)

    strtime = classmethod(strtime)

    def exit(cls):
        """Run when everything exits."""
        cls.dp("Exiting...")
        if cls.readline:
            cls.readline.add_history("# leaving %s" % cls.strtime())
            cls.readline.write_history_file(cls.histfile)
        print("Bye now. Love Ya!")

    exit = classmethod(exit)


if __name__ == "__main__":
    PythonStartup.init()
