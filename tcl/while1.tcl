set a { 1 2 3 }
set i 0
while { $i < [llength $a] } { puts "The list element at index $i is [lindex $a $i]"
	incr i
}
