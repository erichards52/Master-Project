# Classification & Custom Databases Made Easy: Kraken, CLARK & Kaiju 

This project was designed with the Centre for Virus Reseach (CVR) in mind. While it may provide some helpful tips with classification and database creation, it is meant to aid those at the CVR with further interest in this project.

**IMPORTANT: EACH CLASSIFIER LISTED HERE WAS USED WITH A CUSTOM DATABASE CREATED SPECIFICALLY FOR THIS PROJECT. IF YOU WOULD LIKE TO CREATE A CUSTOM DATABASE, PLEASE REFER TO THE DATABASE CREATION SCRIPTS (dbCreation) LISTED UNDER EACH SPECIFIC CLASSIFIER.** 

**IF YOU WISH TO UTILISE THE DATABASE WHICH WAS PREVIOUSLY CREATED IN ORDER TO PERFORM YOUR OWN CLASSIFICATION, MERELY USE THE EXAMPLE CLASSIFICATION SCRIPTS LISTED FOR EACH CLASSIFIER (testDataScripts/Classification Scripts)**  


## dBScripts
The directory dBScripts contains scripts which create databases for each classifier.

### Kraken

#### dbCreation

##### ratKrakDBCreationScript.py
Invoking the command "python ratKrakDBCreationScript.py" will automatically create a (default) Kraken database with the name HumanVirusBacteriaRat.

It is best to run this command within a separate directory which has already been named appropriately (i.e.: I ran this command once I had created the directory "ratKrakDB").

This script will create an arachael genome, human genome, bacterial genome, viral genome and rat genome.

**Custom Database**  
If you wish to create your own custom database, merely add the following lines to ratKrakDBCreationScript.py such that the taxonomic ID is changed to the taxonomic ID for the genome/species/reference sequence you wish to incorporate before running the script. 

print('Downloading <$ANY> genome'+'\n')  
download_refseq_genome(<$ID>,'<$ANY>_genome_url.txt')  
print('Converting sequences to kraken input format'+'\n')  
get_fasta_in_kraken_format('<$ANY>_genome.fa')

Replace <$ANY> with whatever you would like to name your genome.
Replace <$ID> with the relevant NCBI taxonomy ID (IDs can be found at https://www.ncbi.nlm.nih.gov/taxonomy)

#### testDataScripts/Classification Scripts  
Classification can be run immediately utilising the custom database created during this project ("HumanVirusBacteriaRat").

In order to run Kraken classification, invoke the following command:

------------------------
Without explanation:

kraken --preload --threads 12 --fastq-input --paired --db <$DIR_DB> sample1.R1.fq sample2.R2.fq

------------------------
With explanation:

kraken --preload (preloads database) --threads 12 (number of threads) --fastq-input (remove for fa/fasta files) --paired (remove if not paired-end reads) --db <$DIR_DB> (replace <$DIR_DB> with database that you have made (i.e.: mine is HumanVirusBacteriaRat) sample1.R1.fq sample2.R2.fq

------------------------

In order to store output, you could either create a bash script and concatenante the output: (i.e.: KrakenClassificationScript.sh > KrakenOutput.txt) or simply concatenate the command itself: 

kraken --preload --threads 12 --fastq-input --paired --db <$DIR_DB> sample1.R1.fq sample2.R2.fq > KrakenOutput.txt


### Kaiju

#### dbCreation

##### makeDB.sh
THIS SCRIPT MUST BE RUN FROM WITHIN THE ORIGINAL KAIJU DIRECTORY WHERE ALL OTHER .SH SCRIPTS ARE CONTAINED. DO NOT ATTEMPT TO RUN THIS SCRIPT OUTSIDE OF THIS ENVIRONMENT.  

Invoking the command 'makeDB.sh -e -v -t 12' will automatically create a Kaiju database. The name of
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
This script is self-explanatory. It is able to convert both single as well as all .gbff files in a directory to a .faa file(s). It is used before creating a custom database from custom reference sequences.

**Custom Database**  
In order to create a custom database, you must first delete the .faa file, .bwt file & the .fmi file.

If you wish to create your own custom database, merely change/add/remove the following code in HumanBacteriaRat.py before running:

print('Downloading <$ANY> genomes'+'\n')  
download_refseq_genome(<$ID>,'<$ANY>_genome_url.txt')

Replace <$ANY> with whatever you would like to name your genome.
Replace <$ID> with the relevant NCBI taxonomy ID (IDs can be found at https://www.ncbi.nlm.nih.gov/taxonomy)

The script should then be run in a separate directory.

**Custom Database Continued**  
Once this has been completed you must tell kaiju which reference sequences you wish to use. Assuming that all reference sequences have been download and converted into .faa files, you must then run the following commands:

mkbwt -n 5 -a ACDEFGHIKLMNPQRSTVWY -o <$DBNAME> <$DBNAME>.faa  
mkfmi <$DBNAME>  

<$DBNAME> can be changed to whatever you wish to name your database.

In order to add many reference sequences to your database, you must either concantenate them all into one .faa file, or make use of regular expressions in order to add them all at once.

### CLARK

#### dbCreationScripts  

##### set_targets.sh
THIS SCRIPT MUST BE RUN FROM WITHIN THE ORIGINAL CLARK DIRECTORY WHERE ALL OTHER .SH SCRIPTS ARE CONTAINED. DO NOT ATTEMPT TO RUN THIS SCRIPT OUTSIDE OF THIS ENVIRONMENT.  

CLARK must be told what genomes/reference sequences you would like to use in order to classify reads of interest.  
This can be done using the command "sh set_targets.sh <$DIR_DB> human viruses bacteria", which creates a default database containing human, viral and bacteria genome(s).

This command was not used for this project, instead, a custom database was created.

##### HumanBacteriaRat.py
This script is self-explanatory. It downloads the human, bacteria and rat genome in the fna format. It should be run in the "Custom" directory.

##### archaeaViralPlasmid.sh
This script is self-explanatory. It downloads the arachaeal, viral and plasmid genome in the fna format. It should be run in the "Custom" directory.

**Custom Database**  
BEFORE CREATING YOUR OWN DATABASE YOU MUST WIPE THE OLD ONE FROM EXISTENCE. THIS CAN BE DONE BY RUNNING THE COMMAND "sh clean.sh" FROM THE ORIGINAL CLARK DIRECTORY.

If you wish to create your own custom database, merely change/add/remove the following code in HumanBacteriaRat.py

print('Downloading <$ANY> genomes'+'\n')  
download_refseq_genome(<$ID>,'<$ANY>_genome_url.txt')

Replace <$ANY> with whatever you would like to name your genome.
Replace <$ID> with the relevant NCBI taxonomy ID (IDs can be found at https://www.ncbi.nlm.nih.gov/taxonomy)

**Custom Database Continued**  
The command "custom" allows for the selection of a genome or reference sequence of your choosing (it references the custom folder). 
It is possible to invoke the command: "sh set_targets.sh <$DIR_DB> human viruses bacteria custom" if you would still like to download the default human, viral and bacteria genome(s).  
However, if you only wish to utilise the custom database you have created, merely type: "sh set_targets.sh <$DIR_DB> custom".

<$DIR_DB> can be replaced with whatever you would like to name the database directory (I've named this one DBD). You must create this directory inside the original CLARK directory.

In order to include a reference sequence(s)/genome(s) of your choosing, you must create a directory inside <$DIR_DB> called "Custom". 
As stated in the previous scripts (HumanBacteriaRat.py & archaeaViralPlasmid.sh), you must download all reference sequences to the custom folder before running "set_targets.sh" from the original CLARK directory.

#### testDataScripts/Classification Scripts  
Classification can be run immediately utilising the custom database created during this project ("DBD").  

In order to run classification, CLARK must first generate a database of specific sized k-mers. Here, only the default size has been used (31-mers). The database is created by simply invoking the main CLARK classification command as follows (CLARK.exe is located in the exe subdirectory of the main CLARK folder):

------------------------
Without explanation:

CLARK -T <$DIR_DB>/targets.txt -D <$DIR_DB> -P samples.L.txt samples.R.txt -R <$RESULTS_DIR> -m 0 -n 12 --extended

------------------------

With explanation:

CLARK -T <$DIR_DB>/targets.txt -D <$DIR_DB> -P (or -O sample.fa for non-paired-end reads) samples.L.txt samples.R.txt -R <$RESULTS_DIR> (replace <$RESULTS_DIR> with wherever you want to keep these results) -m 0 (-m 0 is full mode (more results), use -m 2 for express mode) -n 12 (number of threads) --extended (more results)

------------------------
The targets.txt file is generated by the initial "set_targets.sh" command and is located in the <$DIR_DB>

A simpler and more streamlined command for those who do not wish to choose any options:

classify_metagenome.sh -O (or -P for paired-reads) sample.fa (or samples.L.txt samples.R.txt if using paired reads) -R <$RESULTS_DIR> -m 0 -n 8.

**PAIRED-READS**

Paired-read command example:  
PAIRED-READS  
samples.L.txt MUST CONTAIN ALL R1 READS IN CORRECT ORDER  
samples.R.txt MUST CONTAIN ALL R2 READS IN CORRECT ORDER

Example:  
samples.L.txt would contain:  
sample1.R1.txt  
sample2.R1.txt  
sample3.R1.txt

samples.R.txt would contain:  
sample1.R2.txt  
sample2.R2.txt  
sample3.R3.txt

------------------------------------------------------------------------------------
## rScripts
The directory rScripts contains scripts which utilise data downloaded by scripts in the 
ncbiScripts directory - curates & generates figures & RMarkdown.

VITAL: PAY ATTENTION TO VARIABLES NAMES, THEY MUST BE EXACTLY AS NAMED IN THE RSCRIPT OR
IT WILL NOT WORK!

### FigureGen.R
If you have not run this script before you will need to install necessary libraries. This can be found at the bottom of the script.
This R script curates all downloaded metadata from the ncbiScripts and generates a fair amount of figures based upon that data.

Figures include platform abundance, organism abundance, platform utilisation over time (bases
per year), rat sample wordcloud.


### SRACharMarkdown.RMD

This generates an RMarkdown document to your liking. Can be modified to include whichever 
figures take the user's fancy. At this moment in time includes all relevant figures. Please
run the FigureGen.R before attempting to render the RMarkdown document, all figures must be
generated at least once beforehand.

----------------------------------------------------------------------------------
## ncbiScripts
The directory ncbiScripts contains scripts which download all metadata from every dataset
on the SRA (fixScript.pl) as well as scripts which return correct taxonomic classification
for every taxonomic ID given from the original metadata.

VITAL: YOU MUST FIRST GENERATE A LIST OF TAXONOMIC IDS FROM THE METADATA DOWNLOADED VIA
fixScript.pl, A TUTORIAL ON HOW TO DO SO EXISTS IN FigureGen.R, INCLUDES ALL NECESSARY CODE.

### fixScript.pl

This script downloads all metadata necessary from every dataset on the SRA. Metadata
includes ID, organism common name & scientific name, organism taxonomic ID, sample information,
creation date and update date, platform model used, generic platform name, number of bases,
study title, and study description. 

Generates text file named to your liking, merely invoke 'fixScript.pl > "filename".txt'

### taxScript.pl

This script returns taxonomic names from the NCBI taxonomy database based upon a text file with provided taxonomic IDs.
Taxonomic IDs must be separated via a newline character. IDs are read in as an array.

### prefetchSRA.sh

This script downloads the relevant SRA dataset for a specific SRR accession number. If you wish to download a specific dataset, merely change the accession number(s).
Typically stores the files in /home/user/ncbi/sra/public.

### fastqDump1.sh & fastqDump2.sh

This script extracts the fastq files from the .sra file downloaded in the prefetchSRA.sh script. Merely change the script so that it points to the .sra file(s) downloaded via the prefetchSRA.sh script. 
The second parameter is where the resulting fastq files will be saved.
