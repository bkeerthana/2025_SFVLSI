#!/usr/bin/env wish
package require Tk 8.6

text .t -width 30 -height 5
pack .t

button .b -text "Click Here!" -command {
    .t insert end "Hello World\n"
}
pack .b
