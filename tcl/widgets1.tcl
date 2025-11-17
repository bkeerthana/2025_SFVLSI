package require Tk

wm title . "Entry Widget Example"

label .lbl -text "Enter Name:"
entry .ent -width 20
button .btn -text "Submit" -command {
    set name [.ent get]
    puts "Entered Name: $name"
}

pack .lbl .ent .btn -padx 10 -pady 5
