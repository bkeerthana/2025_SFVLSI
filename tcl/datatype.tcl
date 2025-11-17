# string 
set greeting "Hello, World!"
puts $greeting

# List 
set mylist {apple banana cherry}
puts [lindex $mylist 1]  ;# Output: banana

# Array Key-value
set student(name) "John"
set student(age) 20
puts "Student Name: $student(name), Age: $student(age)"
