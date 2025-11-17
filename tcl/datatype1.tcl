# string
set technology "5nm FinFET"
puts "Technology used: $technology"


# numbers 
set nodes 7
puts "Node size: $nodes nm"


# float
set capacitance 0.25
set resistance 1.5
set delay [expr $capacitance * $resistance]
puts "Propagation delay: $delay ns"


#Boolean
#multiple ways True: true,yes,1  False: false, no, 0

set enable 1
if {$enable} {
    puts "Feature enabled"
}

# type conversion 

set x "10"
set y "20"
puts "Sum: [expr {$x + $y}]"


set num 42
set str "$num"  ;# Implicit conversion
puts "String value: $str"

