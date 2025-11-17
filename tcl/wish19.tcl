#!/usr/bin/env wish
package require Tk 8.6

wm title . "VLSI Timing Path Filter"
wm geometry . 650x450

# -----------------------------
# Sample timing data (like timing.rpt)
# path_id  start_point   end_point    slack   type
# -----------------------------
set timing_data {
    {P001 U_ALU/U1      U_ALU/U_OUT   0.120  SETUP}
    {P002 U_ALU/U2      U_ALU/U_OUT  -0.045  SETUP}
    {P003 U_REG/UQ      U_ALU/U3     -0.010  HOLD}
    {P004 U_CTRL/U1     U_CTRL/U2     0.250  SETUP}
    {P005 U_CTRL/U2     U_CTRL/U3    -0.080  HOLD}
    {P006 U_REG/UQ      U_OUT         0.000  SETUP}
    {P007 U_MEM/U1      U_MEM/U_OUT  -0.150  SETUP}
    {P008 U_MEM/U2      U_MEM/U_OUT   0.050  HOLD}
    {P009 U_IO/UIN      U_IO/UOUT     0.300  SETUP}
}

# -----------------------------
# TOP FRAME – Slack threshold + analysis type
# -----------------------------
frame .top
pack .top -fill x -padx 10 -pady 10

# Label + Entry for slack threshold
label .top.lblSlack -text "Slack threshold (ns):"
entry .top.entSlack -width 10
.top.entSlack insert 0 "-0.050"   ;# default

pack .top.lblSlack .top.entSlack -side left -padx 5

# Frame for radiobuttons (SETUP / HOLD)
frame .top.fType
pack .top.fType -side left -padx 20

label .top.fType.lbl -text "Analysis type:"
pack .top.fType.lbl -anchor w

set analysis_type "SETUP"
radiobutton .top.fType.rbSetup -text "SETUP" -variable analysis_type -value "SETUP"
radiobutton .top.fType.rbHold  -text "HOLD"  -variable analysis_type -value "HOLD"
pack .top.fType.rbSetup .top.fType.rbHold -anchor w

# -----------------------------
# LEFT – Corner list (LISTBOX)
# -----------------------------
frame .left
pack .left -side left -fill y -padx 10 -pady 10

label .left.lblCorner -text "Select Corner:"
pack .left.lblCorner -anchor w

listbox .left.lbCorner -height 5
.left.lbCorner insert end "tt_1v0_25c" "ss_0p8v_125c" "ff_1p2v_0c"
pack .left.lbCorner -fill x -pady 5

# -----------------------------
# RIGHT – Text output (TEXT)
# -----------------------------
frame .right
pack .right -side left -fill both -expand 1 -padx 10 -pady 10

label .right.lblOut -text "Filtered timing paths:"
pack .right.lblOut -anchor w

text .right.txt -width 60 -height 18
pack .right.txt -fill both -expand 1

# -----------------------------
# BUTTON – Run filter
# -----------------------------
button .btnFilter -text "Filter Violating Paths" -command {
    .right.txt delete 1.0 end

    # Get user inputs
    set threshStr [.top.entSlack get]
    if {[catch {set threshold [expr {double($threshStr)}]}]} {
        .right.txt insert end "Invalid threshold value: $threshStr\n"
        return
    }

    set corner [.left.lbCorner get active]
    if {$corner eq ""} {
        set corner "<no corner selected>"
    }

    .right.txt insert end "Corner: $corner\n"
    .right.txt insert end "Analysis: $::analysis_type\n"
    .right.txt insert end "Show paths with slack < $threshold ns\n\n"

    # Scan timing_data
    set found 0
    foreach path $::timing_data {
        lassign $path pid start end slack typ
        if {$typ eq $::analysis_type && [expr {$slack < $threshold}]} {
            incr found
            .right.txt insert end [format "Path %s  %s -> %s  slack=%0.3f (%s)\n" \
                                        $pid $start $end $slack $typ]
        }
    }

    if {$found == 0} {
        .right.txt insert end "\nNo violating paths found.\n"
    }
}
pack .btnFilter -side bottom -pady 10

