set value "3.14"
if {[string is double -strict $value]} {
    puts "$value is a floating-point number"
} else {
    puts "$value is not a floating-point number"
}
