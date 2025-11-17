#!/usr/bin/env wish
package require Tk 8.6

# Main window
wm geometry . 300x200
wm title . "Main Window"

# Second window
toplevel .win2
wm geometry .win2 400x300+200+150
wm title .win2 "Window 2"

label .win2.l -text "This is Window 2"
pack .win2.l
