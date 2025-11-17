#!/usr/bin/env wish
package require Tk 8.6

wm geometry . 400x300

button .b -text "Click" -command {puts "Hello"}
pack .b
