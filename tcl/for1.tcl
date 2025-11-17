set a { 1 2 3 }
for { set i 0 } { $i < [llength $a] } { incr i } {
	puts "The list element at index $i is [lindex $a $i]"
}
