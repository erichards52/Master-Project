#!/usr/bin/env perl
use warnings;
use strict;
use LWP::Simple;
use 5.010;

#Open file with all accession numbers & create an array
my @array;
open(my $fh, "<", "testAccs.txt")
    or die "Failed to open file: $!\n";
#select $fh; $| = 1; select STDOUT;
while(<$fh>) {
    chomp;
    push @array, $_;
}
close $fh;

#Print headers to outfile
my $printer = "Sample Accession No.\tPrefetch & FastQDump Runtime\tClassification Time\tTotal TaxIDs\tTotal Hits\tPielou's Evenness\tTop TaxID\tTop TaxID Name\tTop TaxID Hits\tTotal Viral Hits\tTop Viral TaxID\tTop Viral TaxID Name\tTop Viral TaxID Hits\n";
my $outputFile =  "nosense.txt";
# Use the open() function to create the file.
unless(open FILE, '>'.$outputFile) {
    # Die with error message 
    # if we can't open it.
    die "\nUnable to create $outputFile\n";
}
# Write some text to the file.
print FILE $printer;

# close the file.
close FILE;

#Iterate through each accession number 
for my $i (0 .. $#array)
{
#Download each dataset & use fastq-dump to extract the .fastq files
my $prefetch_dump_startrun = time();
system("prefetch -q $array[$i]");
system("fastq-dump --split-files ~/ncbi/public/sra/*.sra -O ~/ncbi/public/sra/fastqDir");
my $prefetch_dump_endrun = time();

#Time it takes to perform dataset download & fastq extraction
my $prefetch_dump_runtime = $prefetch_dump_endrun - $prefetch_dump_startrun;

#Check for the number of files in directory where fastq files are downloaded & create array out of filenames
my @files;
my $dir = "/home4/rich01e/ncbi/public/sra/fastqDir/";
	+			opendir(DIR, $dir) or die "couldn't open $dir: $!\n";
@files = grep { $_ ne '.' && $_ ne '..' } readdir DIR;
closedir DIR;

#If number of fastq files is one, performs a single read classification 
#If number of fastq files is two, performs a paired-read classification
#Classification is timed ($classif_time)
#Also outputs an html using kronatools
#All variables are printed, can be concatenated
if (scalar(@files)==1){
my $classif_startrun = time();
system("/home4/rich01e/kaiju/kaiju/kaijudb/kaiju -v -x -z 12 -t /home4/rich01e/kaiju/kaiju/kaijudb/nodes.dmp -f /home4/rich01e/kaiju/kaiju/kaijudb/faaFiles/proteins.fmi -i ~/ncbi/public/sra/fastqDir/$files[0] -o /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].out");
my $classif_endrun = time();
my $classif_time = $classif_endrun - $classif_startrun;
system("/home4/rich01e/kaiju/kaiju/bin/addTaxonNames -u -t /home4/rich01e/kaiju/kaiju/kaijudb/nodes.dmp -n /home4/rich01e/kaiju/kaiju/kaijudb/names.dmp -i /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].out -o /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].names.out");

#Cuts out lineage & taxa
system("cut -f3,8 /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].names.out > /home4/rich01e/ncbi/public/outputDir/$files[0].namescut.out");

system("/home4/rich01e/kaiju/kaiju/kaijudb/kaiju2krona -t /home4/rich01e/kaiju/kaiju/kaijudb/nodes.dmp -n /home4/rich01e/kaiju/kaiju/kaijudb/names.dmp -i /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].out -o /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].out.krona");

#Convert to krona
system("ktImportText -o /home4/rich01e/GitProj/$files[0].out.html /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].out.krona");

#Generate OTU table & taxa table
system("Rscript /home4/rich01e/ncbi/public/outputDir/createOTUTableTaxID.R");

#DOS friendly text-encoding
system("unix2dos /home4/rich01e/ncbi/public/outputDir/KaijuTax.tsv");

#Viral domain check
#system("perl /home4/rich01e/ncbi/public/outputDir/taxScriptVir.pl > /home4/rich01e/ncbi/public/outputDir/kaijuVir.txt");

#open and append to file
my $print1 = "$array[$i]\t$classif_time\t$prefetch_dump_runtime\t";
system("echo $print1 >> nosense.txt");
#Remove newline
system("perl -pi -e 'chomp if eof' /home4/rich01e/sraData/nosense.txt");

#Print viral results
system("Rscript /home4/rich01e/ncbi/public/outputDir/VirMerge.R/g >> nosense.txt");

#Remove files 
system("rm ~/ncbi/public/sra/*.sra");
system("rm ~/ncbi/public/outputDir/*.namescut.out");
system("rm /home4/rich01e/ncbi/public/sra/fastqDir/*");
#system("rm /home4/rich01e/ncbi/public/outputDir/kaijuVir.txt");
system("rm /home4/rich01e/ncbi/public/outputDir/KaijuTax.tsv");
system("rm /home4/rich01e/ncbi/public/outputDir/OTUTable.tsv");
}elsif(scalar(@files)==2){
my $classif_startrun = time();
system("/home4/rich01e/kaiju/kaiju/kaijudb/kaiju -v -x -z 12 -t /home4/rich01e/kaiju/kaiju/kaijudb/nodes.dmp -f /home4/rich01e/kaiju/kaiju/kaijudb/faaFiles/proteins.fmi -i /home4/rich01e/ncbi/public/sra/fastqDir/$files[0] -j /home4/rich01e/ncbi/public/sra/fastqDir/$files[1] -o /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].$files[1].out");
my $classif_endrun = time();
my $classif_time = $classif_endrun - $classif_startrun;
system("/home4/rich01e/kaiju/kaiju/bin/addTaxonNames -u -t /home4/rich01e/kaiju/kaiju/kaijudb/nodes.dmp -n /home4/rich01e/kaiju/kaiju/kaijudb/names.dmp -i /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].$files[1].out -o /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].$files[1].names.out");

#Cuts out lineage and taxa
system("cut -f3,8 /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].$files[1].names.out > /home4/rich01e/ncbi/public/outputDir/$files[0].$files[1].namescut.out");

system("/home4/rich01e/kaiju/kaiju/kaijudb/kaiju2krona -t /home4/rich01e/kaiju/kaiju/kaijudb/nodes.dmp -n /home4/rich01e/kaiju/kaiju/kaijudb/names.dmp -i /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].$files[1].out -o /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].$files[1].out.krona");

#Convert to krona
system("ktImportText -o /home4/rich01e/GitProj/$files[0].$files[1].out.html /home4/rich01e/ncbi/public/sra/fastqDir/$files[0].$files[1].out.krona");

#Generate OTU table and taxa table
system("Rscript /home4/rich01e/ncbi/public/outputDir/createOTUTableTaxID.R");

#DOS friendly text-encoding
system("unix2dos /home4/rich01e/ncbi/public/outputDir/KaijuTax.tsv");

#Viral domain check
#system("perl /home4/rich01e/ncbi/public/outputDir/taxScriptVir.pl > /home4/rich01e/ncbi/public/outputDir/kaijuVir.txt");

#open and append to file
my $print1 = "$array[$i]\t$classif_time\t$prefetch_dump_runtime";
system("echo $print1 >> nosense.txt");

#remove newline
system("perl -pi -e 'chomp if eof' /home4/rich01e/sraData/nosense.txt");

#Print viral results
system("Rscript /home4/rich01e/ncbi/public/outputDir/VirMerge.R >> nosense.txt");
#system("echo -n $syscommand >> nosense.txt");

#my $syscommand = system("Rscript /home4/rich01e/ncbi/public/outputDir/VirMerge.R");
#system("echo -n $syscommand");
#system("echo '\n' >> nosense.txt");


#Remove files
system("rm ~/ncbi/public/sra/*.sra");
system("rm ~/ncbi/public/outputDir/*.namescut.out");
system("rm /home4/rich01e/ncbi/public/sra/fastqDir/*");
#system("rm /home4/rich01e/ncbi/public/outputDir/kaijuVir.txt");
system("rm /home4/rich01e/ncbi/public/outputDir/KaijuTax.tsv");
system("rm /home4/rich01e/ncbi/public/outputDir/OTUTable.tsv");

}elsif(scalar(@files)==0){
print "No files found! Ignore prefetch output above. Either all accession numbers have been exhausted or an error occurred.\n";
}else{
  print "error to log files";
} 
}

