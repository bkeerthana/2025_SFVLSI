#!/usr/bin/env wish
package require Tk

wm title . "Scripting for VLSI "
wm geometry . 500x400

label .l -text "Hello"
pack  .l



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
