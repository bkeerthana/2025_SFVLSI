#!/usr/bin/perl
$fname=<>;
$lname=<>;
chomp($fname);
chomp($fname);
#chop($fname);
$name=$fname.$lname;
print $name;
