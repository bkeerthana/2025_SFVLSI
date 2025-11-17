#!/usr/bin/env wish
package require Tk 8.6

button .open -text "Open File" -command {
    set filename [tk_getOpenFile]

    if {$filename eq ""} {
        return   ;# user cancelled
    }

    # Open file and read all lines
    set fp [open $filename r]
    set content [read $fp]
    close $fp

    .txt delete 1.0 end
    .txt insert end "Loaded file: $filename\n\n"
    .txt insert end $content
}
pack .open

text .txt -width 60 -height 20
pack .txt

