use Bio::DB::EUtilities;

my $factory = Bio::DB::EUtilities->new(-eutil => 'esearch',
                                       -db     => 'sra',
                                       -term   => 'public OR controlled',
                                       -email  => '2274776r@student.gla.ac.uk',
                                       -retmax => 22);

# query terms are mapped; what's the actual query?
print "Query translation: ",$factory->get_query_translation,"\n";

# query hits
print "Count = ",$factory->get_count,"\n";

# UIDs
my @ids = $factory->get_ids;

my $factory = Bio::DB::EUtilities->new(-eutil => 'esummary',
                                       -email => '2274776r@student.gla.ac.uk',
                                       -db    => 'sra',
                                       -id    => \@ids);

while (my $ds = $factory->next_DocSum) {
    print "ID: ",$ds->get_id,"\n";

    # flattened mode
    while (my $item = $ds->next_Item('flattened'))  {
        # not all Items have content, so need to check...
        printf("%-20s:%s\n",$item->get_name,$item->get_content)
          if $item->get_content;
    }
    print "\n";
}
