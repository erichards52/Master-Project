use Bio::DB::EUtilities;
use Bio::Tools::EUtilities::Summary;
use Bio::Tools::EUtilities::Summary::DocSum;
use Bio::Tools::EUtilities::Summary::Item;

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

# retrieve nested docsum data
# iterate through the individual DocSum objects (one per ID)
while (my $ds = $factory->next_DocSum) {
    print "ID: ",$ds->get_id,"\n";

        while (my $item = $ds->next_Item) {
            print "Name: ",$item->get_name,"\n";
            print "Data: ",$item->get_content,"\n";
            print "Type: ",$item->get_type,"\n";
            while (my $ls = $item->next_ListItem) {
            #parse something else
               while (my $struct = $ls->next_StructureItem) {
                  #parse something else
               }
            }
         }


#flattened mode, iterates through all Item objects
    while (my $item = $ds->next_Item('flattened'))  {
        # not all Items have content, so need to check...
        printf("%-20s:%s\n",$item->get_name,$item->get_content)
          if $item->get_content;
    }

    print "\n";
}
