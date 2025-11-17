set file [open "output.txt" r]
set content [read $file]
close $file
puts "File Content: $content"
