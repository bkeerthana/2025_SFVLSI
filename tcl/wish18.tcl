#!/usr/bin/env wish
package require Tk 8.6

wm title . "Tk Widgets Demo"
wm geometry . 500x500

# ================================
# 1. LABEL
# ================================
label .lbl -text "Enter Your Name:"
pack .lbl -padx 10 -pady 5

# ================================
# 2. ENTRY
# ================================
entry .ent -width 30
pack .ent -padx 10 -pady 5

# ================================
# 3. FRAME (to group radio buttons)
# ================================
frame .f -borderwidth 2 -relief groove
pack .f -padx 10 -pady 10 -fill x

label .f.lbl -text "Select Gender:"
pack .f.lbl -anchor w

# ================================
# 4. RADIOBUTTONS
# ================================
set gender "Male"

radiobutton .f.m -text "Male"   -variable gender -value "Male"
radiobutton .f.f -text "Female" -variable gender -value "Female"

pack .f.m -anchor w
pack .f.f -anchor w

# ================================
# 5. LISTBOX
# ================================
label .lbl2 -text "Select Department:"
pack .lbl2 -padx 10 -pady 5

listbox .lb -height 5
.lb insert end "CSE" "Cybersecurity" "VLSI" "AI/ML" "Networking"
pack .lb -padx 10 -pady 5 -fill x

# ================================
# 6. TEXT WIDGET (Multi-line output)
# ================================
label .lbl3 -text "Output Box:"
pack .lbl3 -padx 10 -pady 5

text .txt -width 40 -height 8
pack .txt -padx 10 -pady 5

# ================================
# 7. BUTTON (Action)
# ================================
button .btn -text "Submit" -command {
    .txt delete 1.0 end        ;# Clear text box

    set name [.ent get]
    set dept [.lb get active]

    .txt insert end "Name: $name\n"
    .txt insert end "Gender: $gender\n"
    .txt insert end "Department: $dept\n"
}
pack .btn -padx 10 -pady 10

