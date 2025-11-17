#!/usr/bin/env wish
package require Tk

wm title . "Simple Netlist Module Viewer"

button .b -text "Open Netlist" -command {
    set f [tk_getOpenFile -filetypes {{"Verilog" {.v}}}]
    if {$f eq ""} { return }

    set fd [open $f r]
    set data [read $fd]
    close $fd

    .t delete 1.0 end

    foreach line [split $data "\n"] {
        if {[regexp {^module\s+(\w+)} $line -> m]} {
            .t insert end "Module: $m\n"
        }
    }
}
pack .b -padx 10 -pady 10

text .t -width 50 -height 15
pack .t -padx 10 -pady 10

