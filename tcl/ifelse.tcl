set voltage 3.3

if {$voltage > 0} {
    if {$voltage < 1.0} {
        puts "Low voltage (Logic 0)"
    } elseif {$voltage >= 1.0 && $voltage < 2.5} {
        puts "Uncertain range - Check!"
    } else {
        puts "High voltage (Logic 1)"
    }
} else {
    puts "Invalid voltage level"
}
