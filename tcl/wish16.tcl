#!/usr/bin/env wish
package require Tk 8.6

# Main window widgets
label .mainLabel -text "This is MAIN window"
pack .mainLabel

# Second window
toplevel .win2
label .win2.label -text "This is WINDOW 2"
pack .win2.label
