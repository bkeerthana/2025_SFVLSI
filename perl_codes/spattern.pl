  #!/usr/bin/perl
    use strict;
    use warnings;

# this code is used to introduce arithmetic operator, pattern-matching operators and conditional statements, usage of pragmas

    my $string1 = 'Perl has 196,905 modules, written by 14100 authors ';

    my $avg_contr = 196905/14100; 
    
    print $avg_contr; 
    
    print "\n";
    
    if ($string1 !~ m/\d/ ) # pattern matching 
    {
        print "Doesn't contain numbers\n";
    } else { 
        print "Does contain numbers\n";
    }

    exit 0;
    
    
    
    
