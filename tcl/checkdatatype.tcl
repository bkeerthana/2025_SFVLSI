set value "123"
if {[string is integer -strict $value]} {
    puts "$value is an integer"
} else {
    puts "$value is not an integer"
}
