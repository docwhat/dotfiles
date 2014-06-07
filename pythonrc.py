# -*- coding: iso-8859-15 -*-
""" ~/.pythonrc.py
PYTHONRC - Really Neat way to make the python shell fun and usable!

Copy this file to $HOME/.pythonrc.py
In windows, copy it to $HOMEDRIVE:$HOMEPATH\.pythonrc.py

This is called when interactive python interpreter is instructed to:
    import user
You can force this to import everytime by setting an environment variable:
    export PYTHONSTARTUP="$HOME/.pythonrc.py"
It makes command history persistent, allows TAB expansion, adds time
stamp.
"""

"""
Copyright (c) 2005 Christian Höltje

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
"""

class pythonrc:
    histfile = None
    debug = None

    def init(cls):
        """Initialize a nice environment to run in
        """
        import os
        cls.debug = os.getenv('PYTHONRC_DEBUG')

        if os.getenv('NOPYTHONRC'):
            # Not loading the python environment
            cls.dp( "Skipping loading the pythonrc environment stuff" )
            return

        try:
            import readline
        except ImportError:
            print("Failed to load readline")
            readline = None
        cls.readline = readline

        if readline:
            # Set the history file
            cls.histfile = os.path.join( os.getenv('HOME', '.'),
                                         '.python_history' )
            cls.dp( "Using history file '%s'" % cls.histfile )

            # Read the history file
            if os.path.exists( cls.histfile ):
                readline.read_history_file(cls.histfile)
                cls.dp( "Using existing history information" )
            else:
                cls.dp( "Creating new history file" )

            # Set the number of history items to 3000
            readline.set_history_length(3000)
            cls.dp( "History size set to 3000" )

            # Put a marker for the starting time.
            readline.add_history("# starting %s" % cls.strtime() )
            cls.dp( "Marked start of history file" )

            # Allow Tab Completion
            import rlcompleter # This sets up python specific completion
            readline.parse_and_bind("tab: complete")
            cls.dp( "Started completion" )
        else:
            cls.dp( "No readline available" )

        # Set the prompts
        import sys
        sys.ps1 = "python%s> " % ".".join( map( str, sys.version_info[:2] ) )
        sys.ps2 = " " * ( len( sys.ps1 ) - 2 ) + "> "
        cls.dp( "Set prompts" )

        # The the exit function
        import atexit
        atexit.register(cls.exit)
        cls.dp( "Registered exit function" )
    init = classmethod( init )

    def dp(cls, *msgs):
        "Debugging Print"
        if cls.debug:
            for msg in msgs:
                print("PYTHONRC: %s" % msg)
    dp = classmethod( dp )

    def strtime(cls):
        "Returns the time in a nicely formatted string"
        import time
        format = "%A %I:%M %p, %B %d, %Y %Z"
        return time.strftime( format )
    strtime = classmethod( strtime )

    def exit(cls):
        "Method to run when everything exits"
        cls.dp( "Exiting..." )
        if cls.readline:
            cls.readline.add_history("# leaving %s" % cls.strtime() )
            cls.readline.write_history_file(cls.histfile)
        print("Bye now. Love Ya!")
    exit = classmethod( exit )

if __name__ == "__main__":
    pythonrc.init()
