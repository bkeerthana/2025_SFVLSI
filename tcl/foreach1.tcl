set netlist {AND OR NOT XOR NAND NOR}

foreach gate $netlist {
    puts "Processing: $gate Gate"
}
