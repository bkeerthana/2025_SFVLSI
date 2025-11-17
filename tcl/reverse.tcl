# reverse.tcl
if {$argc == 0} {
 puts "Need to provide at least one argument"
 puts "Usage: [info nameofexecutable] $argv0 arg ?arg ...?"
 exit 1
}
proc print_reversed {str} {
 puts [string reverse $str]
}
foreach arg $argv {
 print_reversed $arg
}

