set value "VLSI"
if {[string is alpha -strict $value]} {
    puts "$value is a string (alphabetic)"
} else {
    puts "$value is not purely alphabetic"
}
