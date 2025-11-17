set gate "AND"

switch $gate {
    "AND"    { puts "AND Gate: A * B" }
    "OR"     { puts "OR Gate: A + B" }
    "NOT"    { puts "NOT Gate: ~A" }
    "NAND"   { puts "NAND Gate: ~(A * B)" }
    "NOR"    { puts "NOR Gate: ~(A + B)" }
    default  { puts "Unknown gate type" }
}
