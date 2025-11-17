set value " 123 "
puts [string is integer $value]       ;# Output: 1
puts [string is integer -strict $value]  ;# Output: 0

#Without -strict, it returns 1 (true) because Tcl ignores spaces.
#With -strict, it returns 0 (false) because spaces make it invalid.
