set value "yes"
if {[string is boolean -strict $value]} {
    puts "$value is a boolean"
} else {
    puts "$value is not a boolean"
}
