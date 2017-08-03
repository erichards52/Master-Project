use Bio::DB::EUtilities;
use Bio::Tools::EUtilities;
use Bio::Tools::EUtilities::Summary::Item;

#searches the SRA database for every entry
my $factory = Bio::DB::EUtilities->new(-eutil => 'esearch',
                                       -db     => 'sra',
                                       -term   => 'public OR controlled',
                                       -email  => '2023085m@student.gla.ac.uk',
					-usehistory => 'y');

#Creates a variable equal to the no. of query hits
my $count = $factory->get_count;

#get history from queue
my $hist = $factory->next_History || die 'No history data returned';

#the new iterative query based upon history
my $factory = Bio::DB::EUtilities->new(-eutil => 'esummary',
                                       -email => '2023085m@student.gla.ac.uk',
                                       -db    => 'sra',
					-history => $hist);
my  $ID;

#headers
print "Id\tOrganism CommonName\tOrganism ScientificName\tOrganism TaxID\tSampleAcc\tCreateDate\tUpdateDate\tPlatform\tModel\tBases\tDesc\tDesign\n";

#iterates: retstart is less that the total hit count.
my $retry = 0; my ($retmax, $retstart) = (10000,0);
while ($retstart < $count) {
    $factory->set_parameters(-retmax => $retmax,
                             -retstart => $retstart);
    eval{
        $factory->get_Response(-cb =>
            sub {my ($data) = @_; print $out $data} );
    };

#if server unresponsive, retries before dying'
    if ($@) {
        die "Server error: $@.  Try again later" if $retry == 5;
        print STDERR "Server error, redo #$retry\n";
        $retry++;
    }
#	print "Retrieved $retstart";
    $retstart += $retmax;


close $out;

#if the query has results 
while (my $ds = $factory->next_DocSum){

  #variables
my ($NCBIname,$ID,$taxId,$id,$name,$design,$platform,$model,$bases,$date,$des,$study);
  $id=$ds->get_id;

  
while (my $item = $ds->next_Item) {
     $name=$item->get_name;
     my $data=$item->get_content;

#Design, model, platform and bases.
if($data=~/\<Summary><Title\>(.+)\<\/Title\>\<Platform instrument_model\=\"(.+)\"\>(.+)\<\/Platform\>\<Statistics total_runs\=\"(.+)\" total_spots\=\"(.+)\" total_bases\=\"(.+)\" total_size/){     
	  $design=$1;
	  $design=~s/\t//g;
          $model=$2;
          $platform=$3;
	  $platform=~s/\t//g;
	  $bases=$6;
}
#Create date and update date      
if ($name="CreateDate"){
	$date=$item->get_content;
	$date1=$item->get_content;
}

#Get study acc no., desc. Tax ID and organism (common name)
if($data=~/\<Study acc\=\"(.+)\" name\=\"(.+)\"\/\>\<Organism taxid\=\"(.+)\" CommonName\=\"(.+)\"\/\>\<Sample/){
	$study=$1;
	$study=~s/\t//g;
	$des=$2;
	$des=~s/\t//g;
	$taxId=$3;
	$taxId=~s/\t//g;
	$organ=$4;
	$organ=~s/\t//g;		
$ID = $taxID;
}}

#Print variables 
print "$id\t$organ\t$$organ\t$taxId\t$study\t$date\t$date1\t$platform\t$model\t$bases\t$des\t$design\n";
}}
