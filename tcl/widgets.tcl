package require Tk

# Create a window
wm title . "Tcl/Tk GUI Example"

# Add a label
label .lbl -text "Hello, VLSI!" -font "Arial 14 bold"
pack .lbl -padx 10 -pady 10

# Add a button
button .btn -text "Click Me" -command {puts "Button clicked!"}
pack .btn -padx 10 -pady 10

# Run the application
tkwait window .
