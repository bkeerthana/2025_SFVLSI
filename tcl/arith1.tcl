set a 10
set b 3

puts "Addition: [expr {$a + $b}]"    ;# 10 + 3 = 13
puts "Subtraction: [expr {$a - $b}]" ;# 10 - 3 = 7
puts "Multiplication: [expr {$a * $b}]" ;# 10 * 3 = 30
puts "Division: [expr {$a / $b}]"   ;# 10 / 3 = 3 (integer division)
puts "Floating-point Division: [expr {double($a) / $b}]" ;# 3.333333
puts "Modulus: [expr {$a % $b}]"    ;# 10 % 3 = 1 (remainder)
puts "Exponentiation: [expr {$a ** $b}]" ;# 10^3 = 1000
