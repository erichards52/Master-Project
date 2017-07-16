# Classification & Custom Databases Made Easy: Kraken, CLARK & Kaiju 

This project was designed with the Centre for Virus Reseach (CVR) in mind. While it may provide some helpful tips with classification and database creation, it is meant to aid those at the CVR with further interest in this project.

**IMPORTANT: EACH CLASSIFIER LISTED HERE WAS USED WITH A CUSTOM DATABASE CREATED SPECIFICALLY FOR THIS PROJECT. IF YOU WOULD LIKE TO CREATE A CUSTOM DATABASE, PLEASE REFER TO THE DATABASE CREATION SCRIPTS (dbCreation) LISTED UNDER EACH SPECIFIC CLASSIFIER.** 

**IF YOU WISH TO UTILISE THE DATABASE WHICH WAS PREVIOUSLY CREATED IN ORDER TO PERFORM YOUR OWN CLASSIFICATION, MERELY USE THE EXAMPLE CLASSIFICATION SCRIPTS LISTED FOR EACH CLASSIFIER (testDataScripts/Classification Scripts)**  

**LASTLY, YOU SHOULD HAVE KRONATOOLS INSTALLED IF YOU WISH TO CONVERT THE RESULTING OUTPUTS OF EACH CLASSIFIER INTO KRONA OUTPUTS**

## dBScripts
The directory dBScripts contains scripts which create databases for each classifier.

### Kraken

#### dbCreation

##### ratKrakDBCreationScript.py
Invoking the command `python ratKrakDBCreationScript.py` will automatically create a (default) Kraken database with the name HumanVirusBacteriaRat.

It is best to run this command within a separate directory which has already been named appropriately (i.e.: I ran this command once I had created the directory "ratKrakDB").

This script will create an arachael genome, human genome, bacterial genome, viral genome and rat genome.

**Custom Database**  
If you wish to create your own custom database, merely add the following lines to ratKrakDBCreationScript.py such that `<$ID>` is changed to the taxonomic ID for the genome/species/reference sequence you wish to incorporate before running the script. 

`print('Downloading <$ANY> genome'+'\n')  
download_refseq_genome(<$ID>,'<$ANY>_genome_url.txt')  
print('Converting sequences to kraken input format'+'\n')  
get_fasta_in_kraken_format('<$ANY>_genome.fa')`

Replace `<$ANY>` with whatever you would like to name your genome.
Replace `<$ID>` with the relevant NCBI taxonomy ID (IDs can be found at https://www.ncbi.nlm.nih.gov/taxonomy)

#### Classification Scripts/testDataScripts
Classification can be run immediately utilising the custom database created during this project ("HumanVirusBacteriaRat").

In order to run Kraken classification, invoke the following command:

------------------------
Without explanation:

`kraken --preload --threads 12 --fastq-input --paired --db <$DIR_DB> sample1.R1.fq sample2.R2.fq`

------------------------
With explanation:

`kraken --preload (preloads database) --threads 12 (number of threads) --fastq-input (remove for fa/fasta files) --paired (remove if not paired-end reads) --db <$DIR_DB> (replace <$DIR_DB> with database that you have made (i.e.: mine is HumanVirusBacteriaRat) sample1.R1.fq sample2.R2.fq`

------------------------

In order to store output, you could either create a bash script and concatenante the output: (i.e.: KrakenClassificationScript.sh > KrakenOutput.txt) or simply concatenate the command itself: 

`kraken --preload --threads 12 --fastq-input --paired --db <$DIR_DB> sample1.R1.fq sample2.R2.fq > KrakenOutput.txt`

If you wish to see an example of this in use, please see krakOutAll.sh  

#### Kraken Krona/KronaScripts

##### cutKrakResults  
Converts the resulting Kraken classification output files ito krona-friendly files.

If you wish to convert the Kraken output into Krona friendly output, invoke the following command:

------------------------
Without explanation:

`cut -f2,3 <$OUTPUT_INPUT> > <$OUTPUT>`

------------------------
With explanation:

`cut -f2,3 (removes columns not needed) <$OUTPUT_INPUT> > <$OUTPUT>`

`<$OUTPUT_INPUT>` should be renamed to whichever Kraken output the user wishes to convert to Krona-friendly input.
`<$OUTPUT>` should be renamed to whatever the users wishes to name the resulting Krona-friendly output.

------------------------

##### krak2Krona.sh  

Converts the resulting krona-friendly Kraken output file to an html krona file.  
ktImportTaxonomy is part of KronaTools.

------------------------
Without explanation:

`ktImportTaxonomy <$OUTPUT_INPUT> -o <$OUTPUT>.html`

------------------------
With explanation:

`ktImportTaxonomy <$OUTPUT_INPUT> -o <$OUTPUT>.html`

`<$OUTPUT_INPUT>` should be renamed to whichever krona-friendly Kraken classification output the user wishes to convert to a krona html file.  
`<$OUTPUT>` should be renamed to whatever the users wishes to name the resulting krona html file.

------------------------
##### krakReportAll.sh  
Creates Kraken reports from Kraken outputs.  
  
Without explanation:
`kraken-report --db <$DIR_DB> <$KRAK_OUTPUT> > <$KRAK_REPORT>`  
  
With explanation:  
`kraken-report --db <$DIR_DB> <$KRAK_OUTPUT> > <$KRAK_REPORT>` 

`<$DIR_DB>` can be replaced with the Kraken database directory (i.e. Mine is HumanVirusBacteriaRat).  
`<$KRAK_OUTPUT>` is the resulting output from the original classification of a sequence.  
`<$KRAK_REPORT>` is the resulting report file produced by Kraken.

#### Bracken  
BEFORE RUNNING BRACKEN, PLEASE MAKE SURE YOU HAVE THE KRAKEN REPORTS FOR THE SEQUENCES OF INTEREST. KRAKEN REPORTS ARE GENERATED USING KRAKEN-REPORT. PLEASE REFER TO krakReportAll.sh
  
Bracken translates the original Kraken output into a more legible abundance table, detailing counts per tax ID.  
  
In order to use Bracken, several Kraken commands must be run. These are detailed in order below:
  
##### brackScript.sh  
Converts original Kraken database into a Bracken-friendly database.  

Without explanation:  

`kraken --db=<$DIR_DB> --<$FASTA_INPUT> --threads=10 <( find -L <$DIR_DB/FA_SEQ_DIR> -name "*.fna" -exec cat {} + )  > database.kraken`  
  
  
`perl count-kmer-abundances.pl --db=<$DIR_DB> --read-length=75 --threads=10 database.kraken > database75mers.kraken_cnts`  
  
  
`python generate_kmer_distribution.py -i database75mers.kraken_cnts -o abundest_krak.TXT`
  
With explanation:  

`kraken --db=<$DIR_DB> --fasta-input (assumes reference sequences are fasta input) --threads=10 <( find -L <$DIR_DB/FA_SEQ_DIR> -name "*.fna" -exec cat {} + )  > database.kraken`  

`<$DIR_DB>` can be replaced with the directory in which the Kraken database is found (i.e. mine is HumanBacteriaVirusRat).  
`<$DIR_DB/FA_SEQ_DIR>` can be replaced with the directory in which the reference sequences (.fna) reside.  
`database.kraken` is the resulting concatenated output file. The name can be changed but the suffix `.kraken` should be kept.

  
`perl count-kmer-abundances.pl --db=<$DIR_DB> --read-length=75 --threads=10 database.kraken > database75mers.kraken_cnts`  

`<$DIR_DB>` can be replaced with the directory in which the database can be found (i.e. HumanBacteriaVirusRat again).  
`database.kraken` is the concatenated output file from the last command, it can be renamed as previously mentioned.  
`database75mers.kraken_cnts` is the resulting database output required to run Bracken, as it manipulates the original database. Although it can be renamed, keeping these file names is probably a good idea. A read-length of 75 is the default.

`python generate_kmer_distribution.py -i database75mers.kraken_cnts -o abundest_krak.TXT`  

`abundest_krak.TXT` is the resulting abundances output file produced by Bracken.  
`database75mers.kraken_cnts` is the file produced from the previous command.  


For an example, please see dBScripts/Kraken/testDataScripts  

##### brackReports.sh 
Converts Kraken reports to Bracken reports.  

Without explanation:  
`python est_abundance.py -i <$REPORT> -k abundest_krak.txt -o <$OUTPUT_FILE>`  

With explanation:  
`python est_abundance.py -i <$REPORT> -k abundest_krak.txt -o <$OUTPUT_FILE>`  

`<$REPORT>` can be replaced with the resulting Kraken output file from using

#### Extras 

##### krakOutputHelp.txt  
This file details the output from running a Kraken classification.


------------------------

### Kaiju

#### dbCreation

##### makeDB.sh
THIS SCRIPT MUST BE RUN FROM WITHIN THE ORIGINAL KAIJU DIRECTORY WHERE ALL OTHER .SH SCRIPTS ARE CONTAINED. DO NOT ATTEMPT TO RUN THIS SCRIPT OUTSIDE OF THIS ENVIRONMENT.  

Invoking the command `makeDB.sh -e -v -t 12` will automatically create a Kaiju database. The name of
the database is not relevant as it is not included within the commands to query the database.
It is best to run this command within a separate directory which has already been named appropriately (i.e.: I ran this command once I had created a directory called "kaijudb".)
This script will create arachael genome, human genome, bacterial genome and viral genome.

VITAL: YOU MUST COPY ALL CONTENTS FROM THE BIN IN THE ORIGINAL DOWNLOAD TO YOUR WD BEFORE THIS SCRIPT WILL WORK (/home4/rich01e/kaiju/bin).

This script was not used for this project, instead, a custom database was created.

##### HumanBacteriaRat.py
This script is self-explanatory. It downloads the human, bacteria and rat genome in the gbff format. It should be run in a directory where you will later convert all .gbff files into .faa files in order for Kaiju to recognise them. 

##### archaeaViralPlasmid.sh
This script is self-explanatory. It downloads the arachaeal, viral and plasmid genome in the gbff format. It should be run in a directory where you will later convert all .gbff files into .faa files in order for Kaiju to recognise them.

##### gbk2faaCustom.pl  
This script is self-explanatory. It is able to convert both single as well as all .gbff.gz files in a directory to a .faa file(s). It is used before creating a custom database from custom reference sequences.

##### testbwt.sh  
This script converts the concatenated .faa file (proteins.faa) into a bwt file (proteins.bwt) which is necessary for the creation of the fmi (proteins.fmi) file.

**Custom Database**  
If you wish to create your own custom database, which is different to the one created during this project, merely change/add/remove the following code in HumanBacteriaRat.py before running:

`print('Downloading <$ANY> genomes'+'\n')  
download_refseq_genome(<$ID>,'<$ANY>_genome_url.txt')`

Replace `<$ANY>` with whatever you would like to name your genome.
Replace `<$ID>` with the relevant NCBI taxonomy ID (IDs can be found at https://www.ncbi.nlm.nih.gov/taxonomy)

The script should then be run in a separate directory.

**Custom Database Continued**  
Once this has been completed you must tell kaiju which reference sequences you wish to use. Assuming that all reference sequences have been download and converted into .faa files (using gbk2faaCustom.pl), and all .faa files have been concatenated into a single .faa file (\*.faa > proteins.faa), you must then run the following commands:

`mkbwt -n 5 -a ACDEFGHIKLMNPQRSTVWY -o <$DBNAME> <$DBNAME>.faa  
mkfmi <$DBNAME>`  

`<$DBNAME>` can be changed to whatever you wish to name your database (I used proteins (i.e.: proteins.fmi)).

For an example of this script, please see testbwt.sh.  

#### Classification Scripts/testDataScripts

Classification can be run immediately utilising the custom database created during this project (proteins.fmi - located in kaijudb/faaFiles)

In order to run Kaiju classification, invoke the following command:

------------------------
Without explanation:

`kaiju -v -x -z 12 -t nodes.dmp -f <$DBNAME>.fmi -i <$INPUT_FASTQ/A> -j <$PAIRED_READ_INPUT_FASTQ/A -o <$OUTPUT>`

------------------------
With explanation:

`kaiju -v (verbose mode) -x (less false positive hits) -z 12 (12 threads) -t nodes.dmp -f <$DBNAME>.fmi -i <$INPUT_FASTQ/A> (Input file) -j <$PAIRED_READ_INPUT_FASTQ/A> (Only put -j if paired reads) -o <$OUTPUT>`

`<$DBNAME>` can be replaced with whatever you have named your .fmi file.  
`<$INPUT_FASTQ/A>` should be replaced with your input file.  
`<$PAIRED_READ_INPUT_FASTQ/A>` should be replaced with a paired-read file if necessary.  
  
Please see kaijuOutAll.sh for example.

#### Kaiju Krona/KronaScripts
  
##### kaiju2kronaResults.sh  
Converts Kaiju classification output to a krona-friendly output.

------------------------
Without explanation:

`kaiju2krona -t nodes.dmp -n names.dmp -i <$KAIJU_OUTPUT> -o <$KRONA_OUTPUT>`

------------------------
With explanation:

`kaiju2krona -t nodes.dmp -n names.dmp -i <$KAIJU_OUTPUT> -o <$KRONA_OUTPUT>` 
  
`<$KAIJU_OUTPUT>` is replaced with the output originally obtained from Kaiju classification.  
`<$KRONA_OUTPUT>` is the resulting output and can be renamed to whatever the user wishes.

##### kronatoHtml.sh  
Converts the resulting krona-friendly Kaiju classification output to a Krona html file.
ktImportText is part of KronaTools & it should be installed before attempting this.  

------------------------
Without explanation:

`ktImportText -o <$OUTPUT.html> <$OUTPUT_INPUT>`

------------------------
With explanation:

`ktImportText -o <$OUTPUT.html> <$OUTPUT_INPUT>` 

`<$OUTPUT.html>` should be renamed to whatever the user wishes to name the output 
`<$OUTPUT_INPUT>` should be renamed to whatever the user named the relevant kaiju2krona output file

#### Extras  

##### KaijuOutputHelp.txt  
This file details the output from running a Kaiju classification.

------------------------


### CLARK
  
In all scripts below, `<$DIR_DB>` can be replaced with the directory in which you wish to keep your CLARK database.  
Additionally, `Custom`, in all scripts below, references the Custom folder/directory in which all reference sequences should be kept ( which should be kept inside `<$DIR_DB>`)  

#### dbCreationScripts  

##### set_targets.sh
THIS SCRIPT MUST BE RUN FROM WITHIN THE ORIGINAL CLARK DIRECTORY WHERE ALL OTHER .SH SCRIPTS ARE CONTAINED. DO NOT ATTEMPT TO RUN THIS SCRIPT OUTSIDE OF THIS ENVIRONMENT.  

CLARK must be told what genomes/reference sequences you would like to use in order to classify reads of interest.  
This can be done using the command `sh set_targets.sh <$DIR_DB> human viruses bacteria`, which creates a default database containing human, viral and bacteria genome(s).  

This command was not used for this project, instead, a custom database was created.

##### HumanBacteriaRat.py
This script is self-explanatory. It downloads the human, bacteria and rat genome in the fna format. It should be run in the `Custom` directory.

##### archaeaViralPlasmid.sh
This script is self-explanatory. It downloads the arachaeal, viral and plasmid genome in the fna format. It should be run in the `Custom` directory.

**Custom Database**  
BEFORE CREATING YOUR OWN DATABASE YOU MUST WIPE THE OLD ONE FROM EXISTENCE. THIS CAN BE DONE BY RUNNING THE COMMAND `sh clean.sh` FROM THE ORIGINAL CLARK DIRECTORY.

If you wish to create your own custom database, merely change/add/remove the following code in HumanBacteriaRat.py

`print('Downloading <$ANY> genomes'+'\n')`  
`download_refseq_genome(<$ID>,'<$ANY>_genome_url.txt')`

Replace `<$ANY>` with whatever you would like to name your genome.
Replace `<$ID>` with the relevant NCBI taxonomy ID (IDs can be found at https://www.ncbi.nlm.nih.gov/taxonomy)

**Custom Database Continued**  
The command `custom` allows for the selection of a genome or reference sequence of your choosing (it references the custom folder). 
It is possible to invoke the command: `sh set_targets.sh <$DIR_DB> human viruses bacteria custom` if you would still like to download the default human, viral and bacteria genome(s).  
However, if you only wish to utilise the custom database you have created, merely type: `sh set_targets.sh <$DIR_DB> custom`.

`<$DIR_DB>` can be replaced with whatever you would like to name the database directory (I've named this one DBD). You must create this directory inside the original CLARK directory.

In order to include a reference sequence(s)/genome(s) of your choosing, you must create a directory inside `<$DIR_DB>` called `Custom`. 
As stated in the previous scripts (HumanBacteriaRat.py & archaeaViralPlasmid.sh), you must download all reference sequences to the custom folder before running `set_targets.sh` from the original CLARK directory.

#### Classification Scripts  
Classification can be run immediately utilising the custom database created during this project ("DBD").  

In order to run classification, CLARK must first generate a database of specific sized k-mers. Here, only the default size has been used (31-mers). The database is created by simply invoking the main CLARK classification command as follows: 

------------------------
Without explanation:

`CLARK -T <$DIR_DB>/targets.txt -D <$DIR_DB> -P samples.L.txt samples.R.txt -R <$RESULTS_DIR> -m 0 -n 12 --extended`

------------------------

With explanation:

`CLARK -T <$DIR_DB>/targets.txt -D <$DIR_DB> -P (or -O sample.fa for non-paired-end reads) samples.L.txt samples.R.txt -R <$RESULTS_DIR> (replace <$RESULTS_DIR> with wherever you want to keep these results) -m 0 (-m 0 is full mode (more results), use -m 2 for express mode) -n 12 (number of threads) --extended (more results)`

------------------------
The targets.txt file is generated by the initial `set_targets.sh` command and is located in the <$DIR_DB>

A simpler and more streamlined command for those who do not wish to choose any options:

`./classify_metagenome.sh -O (or -P for paired-reads) sample.fa (or samples.L.txt samples.R.txt if using paired reads) -R <$RESULTS_DIR> -m 0 -n 8`

**PAIRED-READS**  
`samples.L.txt` MUST CONTAIN ALL R1 READS IN CORRECT ORDER  
`samples.R.txt` MUST CONTAIN ALL R2 READS IN CORRECT ORDER

Example:  
`samples.L.txt` would contain:  
sample1.R1.txt  
sample2.R1.txt  
sample3.R1.txt

`samples.R.txt` would contain:  
sample1.R2.txt  
sample2.R2.txt  
sample3.R3.txt

------------------------------------------------------------------------------------


## rScripts
The directory rScripts contains scripts which utilise data downloaded by scripts in the 
ncbiScripts directory - curates & generates figures & RMarkdown.

VITAL: PAY ATTENTION TO VARIABLES NAMES, THEY MUST BE EXACTLY AS NAMED IN THE RSCRIPT OR
IT WILL NOT WORK!

#### FigureGen.R
If you have not run this script before you will need to install necessary libraries. This can be found at the bottom of the script.
This R script curates all downloaded metadata from the ncbiScripts and generates a fair amount of figures based upon that data.

Figures include platform abundance, organism abundance, platform utilisation over time (bases
per year), rat sample wordcloud.


#### SRACharMarkdown.RMD

This generates an RMarkdown document to your liking. Can be modified to include whichever 
figures take the user's fancy. At this moment in time includes all relevant figures. Please
run the FigureGen.R before attempting to render the RMarkdown document, all figures must be
generated at least once beforehand.  
  
#### BenchmarkTable.R  

This takes the resulting abundance tables produced from each classifier and tallies as well as performs analytical tests. All data considered is sample data designed to benchmark the classifiers with previously known/realised content. This script could theoretically be used to analyse other data if changed accordingly.

----------------------------------------------------------------------------------
## ncbiScripts
The directory ncbiScripts contains scripts which download all metadata from every dataset
on the SRA (fixScript.pl) as well as scripts which return correct taxonomic classification
for every taxonomic ID given from the original metadata.

VITAL: YOU MUST FIRST GENERATE A LIST OF TAXONOMIC IDS FROM THE METADATA DOWNLOADED VIA
fixScript.pl, A TUTORIAL ON HOW TO DO SO EXISTS IN FigureGen.R, INCLUDES ALL NECESSARY CODE.

#### fixScript.pl

This script downloads all metadata necessary from every dataset on the SRA. Metadata
includes ID, organism common name & scientific name, organism taxonomic ID, sample information,
creation date and update date, platform model used, generic platform name, number of bases,
study title, and study description. 

Generates text file named to your liking, merely invoke 'fixScript.pl > "filename".txt'

#### taxScript.pl

This script returns taxonomic names from the NCBI taxonomy database based upon a text file with provided taxonomic IDs.
Taxonomic IDs must be separated via a newline character. IDs are read in as an array.

#### prefetchSRA.sh

This script downloads the relevant SRA dataset for a specific SRR accession number. If you wish to download a specific dataset, merely change the accession number(s).
Typically stores the files in /home/user/ncbi/sra/public.

#### fastqDump1.sh & fastqDump2.sh

This script extracts the fastq files from the .sra file downloaded in the prefetchSRA.sh script. Merely change the script so that it points to the .sra file(s) downloaded via the prefetchSRA.sh script. 
The second parameter is where the resulting fastq files will be saved.
# KronaFiles.github.io
