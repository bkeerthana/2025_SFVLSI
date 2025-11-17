#!/usr/bin/env wish
package require Tk 8.6

wm title . "VLSI Timing Report Analyzer"
wm geometry . 800x600

# -------- Top frame: Button + Summary label --------
frame .top
pack .top -side top -fill x -padx 10 -pady 10

button .top.open -text "Open timing.rpt" -command {
    set fname [tk_getOpenFile -title "Select timing report" \
               -filetypes {{"Timing Report" {.rpt .txt}} {"All files" *}}]
    if {$fname eq ""} {
        return   ;# user cancelled
    }
    analyze_timing_file $fname
}
pack .top.open -side left -padx 5

label .top.summary -text "No file loaded yet"
pack .top.summary -side left -padx 20

# -------- Middle: Full file content --------
label .lblFull -text "Full timing report:"
pack .lblFull -anchor w -padx 10

text .txtFull -width 100 -height 15 -wrap none
pack .txtFull -fill both -expand 1 -padx 10 -pady 5

# Add scrollbars for full text
scrollbar .scrollFullY -command ".txtFull yview"
scrollbar .scrollFullX -orient horizontal -command ".txtFull xview"
.txtFull configure -yscrollcommand ".scrollFullY set" -xscrollcommand ".scrollFullX set"

pack .scrollFullY -side right -fill y
pack .scrollFullX -side bottom -fill x

# -------- Bottom: Violating paths only --------
label .lblViol -text "Violating paths (negative slack):"
pack .lblViol -anchor w -padx 10 -pady {10 0}

text .txtViol -width 100 -height 10 -wrap none
pack .txtViol -fill both -expand 0 -padx 10 -pady 5

scrollbar .scrollViolY -command ".txtViol yview"
.txtViol configure -yscrollcommand ".scrollViolY set"
pack .scrollViolY -side right -fill y

# -------- Procedure: Analyze timing file --------
proc analyze_timing_file {filename} {
    # Clear previous content
    .txtFull delete 1.0 end
    .txtViol delete 1.0 end

    # Read file content
    if {[catch {set fp [open $filename r]} err]} {
        tk_messageBox -icon error -title "Error" -message "Cannot open file:\n$err"
        return
    }
    set content [read $fp]
    close $fp

    # Show full content
    .txtFull insert end $content

    # Initialize counters
    set total_paths 0
    set setup_viol 0
    set hold_viol 0

    # Split report into blocks using the separator line
    foreach block [split $content "----------------------------------------------------"] {
        # Check if this block describes a path
        # Example: "Path 1:  Setup Check"
        if {![regexp {Path\s+(\d+):\s+(\w+)\s+Check} $block -> pathno checktype]} {
            continue
        }
        incr total_paths

        # Extract slack value
        # Example line: "Slack:             -0.120   VIOLATED"
        if {![regexp {Slack:\s*([-0-9.]+)} $block -> slack]} {
            continue
        }

        # Extract path type: MAX (Setup) or MIN (Hold)
        # Example: "Path Type:  MAX (Setup)"
        set pathtype ""
        if {[regexp {Path Type:\s*(MAX|MIN)} $block -> pathtype]} {
            # nothing else, just captured
        }

        # Check if slack is negative (violation)
        if {$slack < 0} {
            if {$checktype eq "Setup"} {
                incr setup_viol
            } elseif {$checktype eq "Hold"} {
                incr hold_viol
            }

            # Show this violating block in the bottom text area
            .txtViol insert end "===== Path $pathno ($checktype, $pathtype) =====\n"
            .txtViol insert end "$block\n"
            .txtViol insert end "---------------------------------------------\n"
        }
    }

    # Update summary label
    set summary "File: $filename | Total paths: $total_paths | Setup violations: $setup_viol | Hold violations: $hold_viol"
    .top.summary configure -text $summary
}

