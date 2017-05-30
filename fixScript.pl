use LWP::Simple;
use Bio::DB::EUtilities;
use Bio::Tools::EUtilities;
use Bio::Tools::EUtilities::Summary::Item;

#Searches the SRA database for all entries
my $factory = Bio::DB::EUtilities->new(-eutil => 'esearch',
                                       -db     => 'sra',
                                       -term   => 'public OR controlled',
                                       -email  => '2274776r@student.gla.ac.uk',
                                       -usehistory => 'y');


# Returns the total number of query hits
print "Count = ",$factory->get_count,"\n";

#Creates a variable equal to the number of query hits
my $count = $factory->get_count;

# Get history in order to search through all hits
my $hist = $factory->next_History || die;
print "History returned\n";


#Botched code, may return to later
#--------------------------------------------------------
# UIDs

#my @items = $factory-> get_all_Items;

#sub my_function {
#my $url = "https://www.ncbi.nlm.nih.gov/sra/?term=" . $id;
#my $content = get($url);
#$content =~ s/ /%20/g;
#chomp $content;
#return $content;
#}
#---------------------------------------------------------

#The iterative query based upon history
my $factory = Bio::DB::EUtilities->new(-eutil => 'esummary',
                                       -email => '2274776r@student.gla.ac.uk',
                                       -db    => 'sra',
                                       -history    => $hist);
#Iterates through history by 500 each time
my $retry = 0; my ($retmax, $retstart) = (2000,0);


#While count is less than the total count, iterates
while ($retstart < $count) {
    $factory->set_parameters(-retmax => $retmax,
                             -retstart => $retstart);

    eval{
        $factory->get_Response(-cb =>
            sub {my ($data) = @_; print $out $data} );
    };

#If the server is not responding, retries 5 times then dies
    if ($@) {
        die "Server error: $@.  Try again later" if $retry == 5;
        print STDERR "Server error, redo #$retry\n";
        $retry++;
    }

#Iterative code, adds the amount on that was just searched (retmax)
    print "Retrieved $retstart";
    $retstart += $retmax;

#Self-explanatory
close $out;
		
#While there are results						
while (my $ds = $factory->next_DocSum){
  
#Creates necessary variables and gets them
my ($id,$name,$title,$platform,$model,$date);
  $id=$ds->get_id;

  while (my $item = $ds->next_Item) {
	          $name=$item->get_name;

if ($name eq 'CreateDate')
{
$date=$item->get_content;
$date1=$item->get_content;
}

 my $data=$item->get_content;    
    
 if ($data=~/\<Summary><Title\>(.+)\<\/Title\>\<Platform instrument_model\=\"(.+)\"\>(.+)\<\/Platform\>\<Statistics total_runs\=\"(.+)\" total_spots\=\"(.+)\" total_bases\=\"(.+)\" total_size/){
       $seq=$1;
	$model=$2;
       $platform=$3;
	$bases=$6;
       	}
if ($data=~/\<Study acc\=\"(.+)\" name\=\"(.+)\"\/\>\<Organism taxid\=\"(.+)\" CommonName\=\"(.+)\"\/\>\<Sample/) {
	$acc=$1;
	$study=$2;
	$org=$4;
		}     
   }

#Prints variables for each database submission in the SRA
  print "\nId $id\nDesign: $seq\nDesc: $study\nOrganism: $org\nCreateDate: $date\nUpdateDate: $date1\nPlatform: $model\nModel: $platform\nNumber of Bases: $bases\n\n";
}
}
