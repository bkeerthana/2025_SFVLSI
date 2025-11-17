package require Tk

wm title . "VLSI Timing Analysis"

# Labels and Entry Fields for Delay Values
label .lbl1 -text "Gate Delay (ns):"
entry .ent1 -width 10
label .lbl2 -text "Interconnect Delay (ns):"
entry .ent2 -width 10
label .lbl3 -text "Setup Time (ns):"
entry .ent3 -width 10
label .lbl4 -text "Total Path Delay (ns):"
entry .result -width 10 -state disabled

# Function to Compute Total Delay
proc compute_delay {} {
    set gate_delay [.ent1 get]
    set interconnect_delay [.ent2 get]
    set setup_time [.ent3 get]
    
    # Ensure inputs are numeric
    if {![string is double -strict $gate_delay] || 
        ![string is double -strict $interconnect_delay] || 
        ![string is double -strict $setup_time]} {
        tk_messageBox -message "Please enter valid numeric values!" -type ok
        return
    }

    # Calculate Total Delay
    set total_delay [expr {$gate_delay + $interconnect_delay + $setup_time}]

    # Display Result
    .result configure -state normal
    .result delete 0 end
    .result insert 0 $total_delay
    .result configure -state disabled
}

# Button to Compute Delay
button .btn -text "Calculate Delay" -command compute_delay

# Layout
grid .lbl1 -row 0 -column 0 -padx 10 -pady 5
grid .ent1 -row 0 -column 1 -padx 10 -pady 5
grid .lbl2 -row 1 -column 0 -padx 10 -pady 5
grid .ent2 -row 1 -column 1 -padx 10 -pady 5
grid .lbl3 -row 2 -column 0 -padx 10 -pady 5
grid .ent3 -row 2 -column 1 -padx 10 -pady 5
grid .btn  -row 3 -columnspan 2 -padx 10 -pady 10
grid .lbl4 -row 4 -column 0 -padx 10 -pady 5
grid .result -row 4 -column 1 -padx 10 -pady 5


