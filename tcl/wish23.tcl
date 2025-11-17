#!/usr/bin/env wish
# Simple PrimeTime Timing Report Viewer
# Shows only paths with NEGATIVE slack.

package require Tk 8.6

# ---------------------------
# Window setup
# ---------------------------
wm title . "PrimeTime Timing Report - Negative Slack Viewer"
wm geometry . 900x600

label .lbl -text "Load a PrimeTime timing.rpt file to list paths with negative slack."
pack .lbl -side top -fill x -padx 10 -pady 5

button .btn -text "Open timing.rpt" -command OpenReport
pack .btn -side top -padx 10 -pady 5

text .txt -width 110 -height 30 -wrap word
scrollbar .sb -orient vertical -command ".txt yview"
.txt configure -yscrollcommand ".sb set"

pack .sb -side right -fill y
pack .txt -side left -fill both -expand 1

# ---------------------------
# Procedure to open and parse the report
# ---------------------------
proc OpenReport {} {
    # Ask user for file
    set filename [tk_getOpenFile -filetypes {{Timing {.rpt}} {{All Files} *}}]
    if {$filename eq ""} {
        return
    }

    # Try to open file
    if {[catch {open $filename r} fd]} {
        tk_messageBox -icon error -message "Cannot open file:\n$fd"
        return
    }

    set data [read $fd]
    close $fd

    # Clear previous output
    .txt delete 1.0 end

    # Variables to hold current path info
    set pathNum ""
    set startpoint ""
    set endpoint ""
    set pathtype ""

    set lines [split $data "\n"]
    set foundNegative 0

    foreach line $lines {
        # Match: Path 1:  Setup Check
        if {[regexp {^Path\s+([0-9]+):} $line -> pnum]} {
            set pathNum $pnum
            set startpoint ""
            set endpoint ""
            set pathtype ""
            continue
        }

        # Match: Startpoint: U_ALU/U1 (rising edge)
        if {[regexp {^Startpoint:\s*(.+)} $line -> sp]} {
            set startpoint [string trim $sp]
            continue
        }

        # Match: Endpoint: U_ALU/U_OUT (rising edge)
        if {[regexp {^Endpoint:\s*(.+)} $line -> ep]} {
            set endpoint [string trim $ep]
            continue
        }

        # Match: Path Type:  MAX (Setup) or MIN (Hold)
        if {[regexp {^Path Type:\s*(.+)} $line -> pt]} {
            set pathtype [string trim $pt]
            continue
        }

        # Match: Slack:             -0.120   VIOLATED
        if {[regexp {^Slack:\s+(-?[0-9]+\.[0-9]+)} $line -> slackVal]} {
            # Convert to number and check if negative
            if {$slackVal < 0} {
                incr foundNegative

                .txt insert end "==== Path $pathNum (NEGATIVE SLACK) ====\n"
                .txt insert end "Slack     : $slackVal\n"
                if {$startpoint ne ""} {
                    .txt insert end "Startpoint: $startpoint\n"
                }
                if {$endpoint ne ""} {
                    .txt insert end "Endpoint  : $endpoint\n"
                }
                if {$pathtype ne ""} {
                    .txt insert end "Path Type : $pathtype\n"
                }
                .txt insert end "----------------------------------------\n\n"
            }
            continue
        }
    }

    if {$foundNegative == 0} {
        .txt insert end "No negative slack paths found in the report.\n"
    } else {
        .txt insert end "Total negative-slack paths: $foundNegative\n"
    }
}

