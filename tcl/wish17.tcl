#!/usr/bin/env wish
package require Tk 8.6

# Main window
wm title . "Main App"
label .labelMain -text "This is main window"
button .open -text "Open Window2" -command {
    toplevel .win2
    wm title .win2 "Second Window"
    label .win2.msg -text "Hello from Window2"
    pack .win2.msg
}
pack .labelMain .open

