
#!/usr/bin/env perl
use strict;
use warnings;
use Bio::DB::EUtilities;

my @array;
open(my $fh, "<", "TaxID.txt")
    or die "Failed to open file: $!\n";
while(<$fh>) { 
    chomp; 
    push @array, $_;
} 
close $fh;

print join " ", @array;


print "Scientific Name,ID\n";
foreach my $array(@array)
{
my $id = $array;

my $factory = Bio::DB::EUtilities->new(-eutil => 'esummary',
                                       -email => '2274776r@student.gla.ac.uk',
                                       -db    => 'taxonomy',
                                       -id    => $id );

my ($name) = $factory->next_DocSum->get_contents_by_name('ScientificName');

print "$name,$id\n";
}
