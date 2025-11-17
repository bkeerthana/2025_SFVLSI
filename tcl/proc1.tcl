proc multiply { x y } {
    set product [expr { $x * $y }]
    return $product
}

set x 10
set y 15

# Call the proc and print the result
puts "The product is: [multiply $x $y]"
