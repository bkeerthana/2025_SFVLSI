#!/usr/bin/env wish
# ---------------------------------------------------------
# Netlist Browser & Hierarchy Viewer (Tcl/Tk)
# For simple structural Verilog netlists (VLSI)
# ---------------------------------------------------------

package require Tk 8.6

# Use ttk treeview for hierarchy
namespace eval NB {
    variable modules        ;# list of module names
    variable module_body    ;# dict: module -> full text
    variable module_insts   ;# dict: module -> list of {type name}
}

# ---------------------------------------------------------
# GUI Setup
# ---------------------------------------------------------
wm title . "VLSI Netlist Browser & Hierarchy Viewer"
wm geometry . 1000x600

# Top frame with button
frame .top
pack  .top -side top -fill x

button .top.load -text "Load Verilog Netlist (.v)" -command NB::load_netlist
label  .top.info -text "No file loaded" -anchor w
pack   .top.load -side left -padx 10 -pady 5
pack   .top.info -side left -fill x -expand 1 -padx 10

# Main split area: left tree, right text
panedwindow .pw -orient horizontal
pack .pw -fill both -expand 1

# Left frame for treeview
frame .left
label .left.lbl -text "Module Hierarchy"
pack  .left.lbl -side top -fill x

ttk::treeview .left.tree -columns {kind info} -show tree headings
.left.tree heading kind -text "Kind"
.left.tree heading info -text "Cell Type"

scrollbar .left.sb -orient vertical -command ".left.tree yview"
.left.tree configure -yscrollcommand ".left.sb set"

pack .left.sb   -side right -fill y
pack .left.tree -side left  -fill both -expand 1

# Right frame for text (module source)
frame .right
label .right.lbl -text "Module / Instance Details"
pack  .right.lbl -side top -fill x

text .right.txt -wrap none -font {Courier 10}
scrollbar .right.sv -orient vertical -command ".right.txt yview"
scrollbar .right.sh -orient horizontal -command ".right.txt xview"
.right.txt configure -yscrollcommand ".right.sv set" -xscrollcommand ".right.sh set"

pack .right.sv  -side right  -fill y
pack .right.sh  -side bottom -fill x
pack .right.txt -side left   -fill both -expand 1

.pw add .left -weight 1
.pw add .right -weight 2

# Bind selection in tree
bind .left.tree <<TreeviewSelect>> {NB::show_selection}

# ---------------------------------------------------------
# Parsing Logic
# ---------------------------------------------------------
namespace eval NB {

    proc reset_data {} {
        variable modules
        variable module_body
        variable module_insts

        set modules {}
        set module_body {}
        set module_insts {}
    }

    # Simple Verilog parser for:
    #   module <name> (...) ... endmodule
    #   <celltype> <instname> ( ... );
    proc parse_verilog {text} {
        reset_data

        variable modules
        variable module_body
        variable module_insts

        set lines [split $text "\n"]
        set current_module ""
        set current_body ""

        foreach line $lines {
            set trim_line [string trim $line]

            # Detect module start
            if {$current_module eq ""} {
                if {[regexp {^module\s+([A-Za-z_][A-Za-z0-9_]*)} $trim_line -> mname]} {
                    set current_module $mname
                    lappend modules $current_module
                    set current_body "$line\n"
                    set module_insts($current_module) {}
                }
                continue
            } else {
                # Inside a module
                append current_body "$line\n"

                # Detect endmodule
                if {[regexp {^endmodule} $trim_line]} {
                    # Save module body
                    dict set module_body $current_module $current_body
                    set current_module ""
                    set current_body ""
                    continue
                }

                # Try to detect an instance:
                #   CELLTYPE INSTNAME ( ... );
                # Skip lines starting with keywords like input/output/wire/assign/parameter
                if {[regexp {^(input|output|inout|wire|reg|logic|assign|parameter)} $trim_line]} {
                    continue
                }

                # Match: <cell> <inst> (
                if {[regexp {^([A-Za-z_][A-Za-z0-9_]*)\s+([A-Za-z_][A-Za-z0-9_]*)\s*\(} $trim_line -> cell inst]} {
                    # Add instance to this module
                    set inst_list $module_insts($current_module)
                    lappend inst_list [list $cell $inst]
                    set module_insts($current_module) $inst_list
                }
            }
        }
    }

    # Build the tree after parsing
    proc build_tree {} {
        variable modules
        variable module_insts

        .left.tree delete [.left.tree children {}]

        foreach m $modules {
            # Add module as root-level item
            set mid [.left.tree insert {} end -text $m -values [list "module" ""]]

            # Add instances as children
            if {[info exists module_insts($m)]} {
                foreach instRec $module_insts($m) {
                    lassign $instRec cell inst
                    .left.tree insert $mid end -text $inst -values [list "inst" $cell]
                }
            }
        }
    }

    # Called when user selects something in the treeview
    proc show_selection {} {
        variable module_body

        set sel [.left.tree selection]
        if {$sel eq ""} { return }

        set item $sel
        set text [.left.tree item $item -text]
        set vals [.left.tree item $item -values]
        set kind [lindex $vals 0]
        set info [lindex $vals 1]

        .right.txt delete 1.0 end

        if {$kind eq "module"} {
            # Show the module body
            if {[dict exists $module_body $text]} {
                .right.txt insert end "Module: $text\n\n"
                .right.txt insert end [dict get $module_body $text]
            } else {
                .right.txt insert end "No body stored for module $text\n"
            }
        } elseif {$kind eq "inst"} {
            # Show instance info, and try to show referenced module if any
            .right.txt insert end "Instance Name: $text\n"
            .right.txt insert end "Cell Type    : $info\n\n"

            # If cell type is also a module, show its module definition
            variable modules
            if {[lsearch -exact $modules $info] != -1} {
                .right.txt insert end "Cell type '$info' is a module in this netlist.\n\n"
                if {[dict exists $module_body $info]} {
                    .right.txt insert end "Definition of module $info:\n\n"
                    .right.txt insert end [dict get $module_body $info]
                }
            } else {
                .right.txt insert end "Cell type '$info' appears to be a library cell (no module definition in this file).\n"
            }
        } else {
            .right.txt insert end "Unknown item kind: $kind\n"
        }
    }

    # File dialog + parse + tree update
    proc load_netlist {} {
        set fname [tk_getOpenFile -filetypes {{Verilog {.v}} {{All Files} *}}]
        if {$fname eq ""} {
            return
        }

        if {[catch {open $fname r} fd]} {
            tk_messageBox -icon error -message "Cannot open file:\n$fd"
            return
        }
        set txt [read $fd]
        close $fd

        .top.info configure -text "Loaded: $fname"

        parse_verilog $txt
        build_tree

        .right.txt delete 1.0 end
        .right.txt insert end "Netlist loaded: $fname\n"
        .right.txt insert end "Double-click or select a module/instance from the left to view details.\n"
    }
}

