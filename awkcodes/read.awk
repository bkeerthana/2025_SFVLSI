#!/usr/bin/awk -f
BEGIN {
    printf "Enter pattern: " > "/dev/tty"
    getline pat < "/dev/tty"

    printf "Enter replacement: " > "/dev/tty"
    getline rep < "/dev/tty"
}
{
    gsub(pat, rep)   # use the user-provided values
    print
}
