
#!/usr/bin/env perl
use strict;
use warnings;
use Bio::DB::EUtilities;

#Returns the tax ID and name for all taxa which are found on the NCBI
#Reads in file created from R script - txt file which should contain the column of SRA metadata containing unique Tax IDs
my @array;
open(my $fh, "<", "TaxID.txt")
    or die "Failed to open file: $!\n";
select $fh; $| = 1; select STDOUT;
while(<$fh>) { 
    chomp; 
#Creates array of tax IDs
    push @array, $_;
} 
close $fh;

#Prints headers to file
print "Scientific Name,ID\n";

#For loop for each tax ID
foreach my $array(@array)
{
my $id = $array;
my $factory = Bio::DB::EUtilities->new(-eutil => 'esummary',
                                       -email => '2274776r@student.gla.ac.uk',
                                       -db    => 'taxonomy',
                                       -id    => $id );
#Get scientific name for the tax ID
my ($name) = $factory->next_DocSum->get_contents_by_name('ScientificName');

#Print scientific name and Tax ID
print "$name,$id\n";
}


