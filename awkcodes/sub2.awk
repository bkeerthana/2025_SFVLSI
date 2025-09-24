#!/usr/bin/awk -f
BEGIN {
    # Need: pattern, replacement, and at least one file → ARGC >= 4
    if (ARGC < 4) {
        print "Usage: awk -f sub2.awk pattern_to_search replace_pattern apply_to_this_file"
        exit 1
    }

    pat = ARGV[1]
    rep = ARGV[2]

    # Remove the two CLI args so AWK doesn't treat them as filenames
    delete ARGV[1]
    delete ARGV[2]
}
{
    # sub() changes the FIRST match in $0 by default
    sub(pat, rep)    # use gsub(pat, rep) for ALL matches
    print            # prints the modified $0
}
