set text "Voltage: 3.3V"
regexp {(\d+\.\d+)V} $text match voltage
puts "Match           : $match"
puts "Detected voltage: $voltage"
