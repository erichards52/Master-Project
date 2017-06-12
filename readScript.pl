#!/usr/bin/env perl
use strict;
use warnings;

my @array;
open(my $fh, "<", "TaxID.txt")
    or die "Failed to open file: $!\n";
while(<$fh>) { 
    chomp; 
    push @array, $_;
} 
close $fh;

print join " ", @array;
