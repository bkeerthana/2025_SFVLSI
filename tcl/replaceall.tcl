set netlist "AND OR AND XOR AND"
regsub -all {AND} $netlist "NAND" updatedNetlist
puts $updatedNetlist   ;# Output: NAND OR NAND XOR NAND
