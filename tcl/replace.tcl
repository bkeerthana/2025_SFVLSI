set circuit "NAND gate"
regsub {NAND} $circuit "AND" newCircuit
puts $newCircuit  ;# Output: AND gate
