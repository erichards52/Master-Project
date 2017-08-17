#!/usr/bin/env perl
use strict;
use warnings;
use Bio::DB::EUtilities;
use Bio::DB::Taxonomy;
use Bio::DB::Taxonomy::entrez;
use Data::Dumper;

#This script returns the division or all taxa it reads in - txt file which is read in must be separated by a newline
my @array;
#Choose file to read in - must be TaxIDs separated by newlines
open(my $fh, "<", "Tax.tsv")
    or die "Failed to open file: $!\n";
select $fh; $| = 1; select STDOUT;
while(<$fh>) {
    chomp;
    push @array, $_;
}
close $fh;
#create array of IDs read in
foreach my $array(@array)
{
require Bio::DB::Taxonomy;
my $id = $array;
my $factory = Bio::DB::EUtilities->new(-eutil => 'esummary',
                                       -email => '2274776r@student.gla.ac.uk',
                                       -db    => 'taxonomy',
                                       -id    => $id );
# get the scientific name
my ($name) = $factory->next_DocSum->get_contents_by_name('ScientificName');


 my $db = Bio::DB::Taxonomy->new(-source => 'entrez');
 my $taxonid = $id;
#get division 
my $taxon = $db->get_taxon(-taxonid => $taxonid);

#Prints division and tax ID
print "",$taxon->division,",$id","\n";
}
