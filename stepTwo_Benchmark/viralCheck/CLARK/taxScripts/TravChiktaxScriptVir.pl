

#!/usr/bin/env perl
use strict;
use warnings;
use Bio::DB::EUtilities;
use Bio::DB::Taxonomy;
use Bio::DB::Taxonomy::entrez;
use Data::Dumper;

my @array;
open(my $fh, "<", "TravChikClarkTax.tsv")
    or die "Failed to open file: $!\n";
select $fh; $| = 1; select STDOUT;
while(<$fh>) {
    chomp;
    push @array, $_;
}
close $fh;

foreach my $array(@array)
{
require Bio::DB::Taxonomy;
my $id = $array;
my $factory = Bio::DB::EUtilities->new(-eutil => 'esummary',
                                       -email => '2274776r@student.gla.ac.uk',
                                       -db    => 'taxonomy',
                                       -id    => $id );

my ($name) = $factory->next_DocSum->get_contents_by_name('ScientificName');


 my $db = Bio::DB::Taxonomy->new(-source => 'entrez');
 my $taxonid = $id;
 my $taxon = $db->get_taxon(-taxonid => $taxonid);

print "",$taxon->division,",$id","\n";
}

