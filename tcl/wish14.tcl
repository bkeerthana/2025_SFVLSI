#!/usr/bin/env wish
package require Tk

wm title . "Scripting for VLSI "
wm geometry . 500x400
# wm geometry .win2 400x300

toplevel .win2
label .win2.msg -text "This is another window"
pack .win2.msg


# wm <subcommand> <window> <options>
# subcommands  - geomentry , title 
# windows      - . (main) 
# options      - 300X400  , "Myapp"

if 0 {
    This is a multi-line comment
    You can write any text here
    Even Tcl code inside will not execute
    
    Symbol	Meaning
     .	        Main window (root window)
     .b	Button inside main window
     -l        label 
}
