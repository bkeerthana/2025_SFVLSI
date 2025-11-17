set upper "THIS IS A STRING IN UPPER CASE LETTERS"
set lower "this is a string in lower case letters"
set trailer "This string has trailing dots ...."
set leader "....This string has leading dots"
set both  "((this string is nested in parens )))"

puts "tolower converts this: $upper"
puts "              to this: [string tolower $upper]\n"

puts "toupper converts this: $lower"
puts "              to this: [string toupper $lower]\n"

puts "trimright converts this: $trailer"
puts "                to this: [string trimright $trailer ]\n"

puts "trimleft converts this: $leader"
puts "               to this: [string trimleft $leader .]\n"

puts "trim converts this: $both"
puts "           to this: [string trim $both "()"]\n"

set labels [format "%-20s %+10s " "Item" "Cost"]
set price1 [format "%-20s %10d Cents Each" "Tomatoes" "30"]
set price2 [format "%-20s %10d Cents Each" "Peppers" "20"]
set price3 [format "%-20s %10d Cents Each" "Onions" "10"]
set price4 [format "%-20s %10.2f per Lb." "Steak" "3.59997"]

puts "\n Example of format:\n"
puts "$labels"
puts "$price1"
puts "$price2"
puts "$price3"
puts "$price4"
