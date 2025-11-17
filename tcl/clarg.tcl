  if { $argc != 2 } {
        puts "The clarg.tcl script requires two numbers to be inputed."
        puts "For example, tclsh clarg.tcl 2 5".
        puts "Please try again."
    } else {
        puts [expr [lindex $argv 0] + [lindex $argv 1]]
        }
