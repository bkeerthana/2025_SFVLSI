# create list 
set a {aim brave displine Effort}

# get the item based on index
puts [lindex $a 1]

# to find the length of the list 
puts [llength $a]

# to add the items in the list 
lappend a 4 5 6

# print the list 
puts $a

puts [lindex $a 0]


puts [lindex $a 3]


puts [lindex $a end]


puts [lindex $a end-1]

puts [lrange $a 1 3]


