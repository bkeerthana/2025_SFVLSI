package require Tk
package require Tcllib
package require Plotchart

wm title . "VLSI Timing Analysis - Enhanced"

# Labels and Entry Fields
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

    # Call Plot Function
    plot_delays $gate_delay $interconnect_delay $setup_time
}

# Function to Read Delays from File
proc read_file {} {
    set filename [tk_getOpenFile -title "Select Delay File"]
    if {$filename eq ""} { return }

    set file [open $filename r]
    set data [split [read $file] "\n"]
    close $file

    # Assume file contains three lines: gate, interconnect, setup
    if {[llength $data] < 3} {
        tk_messageBox -message "Invalid file format!" -type ok
        return
    }

    .ent1 delete 0 end
    .ent1 insert 0 [lindex $data 0]
    .ent2 delete 0 end
    .ent2 insert 0 [lindex $data 1]
    .ent3 delete 0 end
    .ent3 insert 0 [lindex $data 2]
}

# Function to Plot Delays
proc plot_delays {g i s} {
    .canvas delete all
    set chart [::Plotchart::createBarchart .canvas {0 3 1} {0 10 2}]
    
    $chart dataconfig delays -fill blue
    $chart plot delays 0 $g
    $chart plot delays 1 $i
    $chart plot delays 2 $s
}

# Buttons
button .btn_calculate -text "Calculate Delay" -command compute_delay
button .btn_read -text "Read from File" -command read_file

# Canvas for Plotting
canvas .canvas -width 300 -height 200

# Layout
grid .lbl1 -row 0 -column 0 -padx 10 -pady 5
grid .ent1 -row 0 -column 1 -padx 10 -pady 5
grid .lbl2 -row 1 -column 0 -padx 10 -pady 5
grid .ent2 -row 1 -column 1 -padx 10 -pady 5
grid .lbl3 -row 2 -column 0 -padx 10 -pady 5
grid .ent3 -row 2 -column 1 -padx 10 -pady 5
grid .btn_calculate -row 3 -columnspan 2 -padx 10 -pady 10
grid .btn_read -row 4 -columnspan 2 -padx 10 -pady 5
grid .lbl4 -row 5 -column 0 -padx 10 -pady 5
grid .result -row 5 -column 1 -padx 10 -pady 5
grid .canvas -row 6 -columnspan 2 -padx 10 -pady 10

