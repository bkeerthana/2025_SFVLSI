# Matches
string match * foo

# Matches
string match f?? foo

# Doesn't match
string match f foo

# Returns a big list of files on my Debian system.
set bins [glob //bin/]
    
