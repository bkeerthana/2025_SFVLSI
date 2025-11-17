set input [open myfile.txt]
set line_num 1
while { [gets $input line] >= 0 } {
	# Process the line of text here
	puts "$line_num: $line"
	incr line_num
}
close $input
