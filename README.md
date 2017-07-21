# Classification & Custom Databases: Kraken, CLARK & Kaiju
## An explanation & walkthrough 

This project was designed with the Centre for Virus Reseach (CVR) in mind. While it may provide some helpful tips with classification and database creation, it is meant to aid those at the CVR with further interest in this project.

**IMPORTANT: EACH CLASSIFIER LISTED HERE WAS USED WITH A CUSTOM DATABASE CREATED SPECIFICALLY FOR THIS PROJECT. IF YOU WOULD LIKE TO CREATE A CUSTOM DATABASE, PLEASE REFER TO THE DATABASE CREATION SCRIPTS (dbCreation) AS WELL AS WALKTHROUGHS LISTED UNDER EACH SPECIFIC CLASSIFIER.** 

**IF YOU WISH TO UTILISE THE DATABASE WHICH WAS PREVIOUSLY CREATED IN ORDER TO PERFORM YOUR OWN CLASSIFICATION, MERELY USE THE EXAMPLE CLASSIFICATION SCRIPTS LISTED FOR EACH CLASSIFIER (testDataScripts/Classification Scripts)**  

**KRONATOOLS SHOULD BE INSTALLED IF YOU WISH TO CONVERT THE RESULTING OUTPUTS OF EACH CLASSIFIER INTO KRONA OUTPUTS**

**FINALLY, IN EACH CLASSIFICATION WALKTHROUGH, IT IS ASSUMED THE USER HAS AT LEAST DOWNLOADED AND INSTALLED EACH CLASSIFIER AND HAD A LOOK AT THE SCRIPTS & MANUALS CONTAINED IN EACH, AS SOME FLAGS ARE NOT INCLUDED**

--------------------------------------------------------------------------------------------------------

# Kraken

## dbScripts/Kraken/dbCreation

### ratKrakDBCreationScript.py
### Default Database Creation
Invoking the command `python ratKrakDBCreationScript.py` will automatically create a (default) Kraken database with the name HumanVirusBacteriaRat within the current working directory.

This script will create a reference database consisting of the arachael genome, human genome, bacterial genome, viral genome and rat genome.

### Custom Database Creation 
If you wish to create your own custom database, merely add the following lines to ratKrakDBCreationScript.py such that `<$ID>` is changed to the taxonomic ID for the genome/species/reference sequence you wish to incorporate before running the script. 

```
print('Downloading <$ANY> genome'+'\n')  
download_refseq_genome(<$ID>,'<$ANY>_genome_url.txt')  
print('Converting sequences to kraken input format'+'\n')  
get_fasta_in_kraken_format('<$ANY>_genome.fa')
```

Replace `<$ANY>` with whatever you would like to name your genome.

Replace `<$ID>` with the relevant NCBI taxonomy ID (IDs can be found at https://www.ncbi.nlm.nih.gov/taxonomy)

## dbScripts/Kraken/testDataScripts  
### Classification
Classification can be run immediately utilising the custom database created during this project ("HumanVirusBacteriaRat").

In order to run Kraken classification, invoke the following command:


Without explanation:

```
kraken --preload --threads 12 --fastq-input --paired --db <$DIR_DB> sample1.R1.fq sample2.R2.fq
```

------------------------
With explanation:

```
kraken --preload (preloads database) --threads 12 --fastq-input --paired --db <$DIR_DB> sample1.R1.fq sample2.R2.fq
```

  
  
`preload` allows the user to preload the database, useful if carrying out multiple classifications.  

`fastq-input` allows the user to use FASTQ files rather than FASTA.  

`--paired` allows the user to use paired-end reads.  

`<$DIR_DB>` can be replaced with the database that you have made (i.e.: mine is HumanVirusBacteriaRat).



------------------------

In order to store output, you could either create a bash script and concatenante the output: (i.e.: KrakenClassificationScript.sh > KrakenOutput.txt) or simply concatenate the command itself: 

```
kraken --preload --threads 12 --fastq-input --paired --db <$DIR_DB> sample1.R1.fq sample2.R2.fq > KrakenOutput.txt
```

If you wish to see an example of this in use, please see dBScripts/Kraken/testDataScripts/krakOutAll.sh  

------------------------

## dbScripts/Kraken/KronaScripts

### cutKrakResults  
Converts the resulting Kraken classification output files ito krona-friendly files by retrieving desired columns.

If you wish to convert the Kraken output into Krona friendly output, invoke the following command:

Without explanation:

```
cut -f2,3 <$OUTPUT_INPUT> > <$OUTPUT>
```


------------------------
With explanation:

```
cut -f2,3 (removes columns not needed) <$OUTPUT_INPUT> > <$OUTPUT>
```

`<$OUTPUT_INPUT>` should be renamed to whichever Kraken output the user wishes to convert to Krona-friendly input.

`<$OUTPUT>` should be renamed to whatever the users wishes to name the resulting Krona-friendly output.


------------------------

### krak2Krona.sh  

Converts the resulting krona-friendly Kraken output file to an html krona file.  
ktImportTaxonomy is part of KronaTools.

Without explanation:

```
ktImportTaxonomy <$OUTPUT_INPUT> -o <$OUTPUT>.html
```


------------------------
With explanation:

```
ktImportTaxonomy <$OUTPUT_INPUT> -o <$OUTPUT>.html
```

`<$OUTPUT_INPUT>` should be renamed to whichever krona-friendly Kraken classification output the user wishes to convert to a krona html file.  

`<$OUTPUT>` should be renamed to whatever the users wishes to name the resulting krona html file.

------------------------
### krakReportAll.sh

Creates Kraken reports from Kraken outputs.


Without explanation:  

```
kraken-report --db <$DIR_DB> <$KRAK_OUTPUT> > <$KRAK_REPORT>
```


------------------------

With explanation:  

```
kraken-report --db <$DIR_DB> <$KRAK_OUTPUT> > <$KRAK_REPORT>
```

`<$DIR_DB>` can be replaced with the Kraken database directory (i.e. Mine is HumanVirusBacteriaRat).

`<$KRAK_OUTPUT>` is the resulting output from the original classification of a sequence.

`<$KRAK_REPORT>` is the resulting report file produced by Kraken.


------------------------

## dbScripts/Kraken/Bracken
BEFORE RUNNING BRACKEN, PLEASE MAKE SURE YOU HAVE THE KRAKEN REPORTS FOR THE SEQUENCES OF INTEREST. KRAKEN REPORTS ARE GENERATED USING KRAKEN-REPORT. PLEASE REFER TO dBScripts/Kraken/testDataScripts/krakReportAll.sh
  
Bracken translates the original Kraken output into a more legible abundance table, detailing counts per tax ID.  
  
In order to use Bracken, several Kraken commands must be run. These are detailed in order below:
  
### brackScript.sh  
Converts original Kraken database into a Bracken-friendly database.  

Without explanation:  
```
kraken --db=<$DIR_DB> --<$FASTA_INPUT> --threads=10 <( find -L <$DIR_DB/FA_SEQ_DIR> -name "*.fna" -exec cat {} + )  > database.kraken

perl count-kmer-abundances.pl --db=<$DIR_DB> --read-length=75 --threads=10 database.kraken > database75mers.kraken_cnts

python generate_kmer_distribution.py -i database75mers.kraken_cnts -o abundest_krak.TXT
```


With explanation:  

```
kraken --db=<$DIR_DB> --fasta-input (assumes reference sequences are fasta input) --threads=10 <( find -L <$DIR_DB/FA_SEQ_DIR> -name "*.fna" -exec cat {} + )  > database.kraken
```  

`<$DIR_DB>` can be replaced with the directory in which the Kraken database is found (i.e. mine is HumanBacteriaVirusRat). 

`<$DIR_DB/FA_SEQ_DIR>` can be replaced with the directory in which the reference sequences (.fna) reside.  

`database.kraken` is the resulting concatenated output file. The name can be changed but the suffix `.kraken` should be kept.


------------------------
```
perl count-kmer-abundances.pl --db=<$DIR_DB> --read-length=75 --threads=10 database.kraken > database75mers.kraken_cnts
```  

`<$DIR_DB>` can be replaced with the directory in which the database can be found (i.e. HumanBacteriaVirusRat again).  

`database.kraken` is the concatenated output file from the last command, it can be renamed as previously mentioned.  

`database75mers.kraken_cnts` is the resulting database output required to run Bracken, as it manipulates the original database. Although it can be renamed, keeping these file names is probably a good idea. A read-length of 75 is the default.


------------------------

```
python generate_kmer_distribution.py -i database75mers.kraken_cnts -o abundest_krak.TXT
```  

`abundest_krak.TXT` is the resulting abundances output file produced by Bracken.  

`database75mers.kraken_cnts` is the file produced from the previous command.    


------------------------
### brackReports.sh 
Converts Kraken reports to Bracken reports.  

Without explanation:  

```
python est_abundance.py -i <$REPORT> -k abundest_krak.txt -o <$OUTPUT_FILE>
``` 


------------------------
With explanation:  

```
python est_abundance.py -i <$REPORT> -k abundest_krak.txt -o <$OUTPUT_FILE>
```  

`<$REPORT>` can be replaced with a Kraken report file.  

`<$OUTPUT_FILE>` can be replaced with the desired name for the resulting Bracken report.


------------------------

## Extras 

### krakOutputHelp.txt  
This file details the output from running a Kraken classification.


------------------------

# Kaiju

## dBScripts/Kaiju/dbCreation 
### Default database Creation
Invoking the command `makeDB.sh -e -v -t 12` will automatically create a Kaiju default database within the current working directory.
This script will create a reference database which includes the arachael genome, human genome, bacterial genome and viral genome.

This script was not used for this project, instead, a custom database was created. Scripts utilised for the purpose of building a custom database as well as the process in which the custom database was created are/is described below.

### HumanBacteriaRat.py
This script is self-explanatory. It downloads the human, bacteria and rat genome in the gbff format. It should be run in a directory where you will later convert all .gbff files into .faa files in order for Kaiju to recognise them. 

### archaeaViralPlasmid.sh
This script is self-explanatory. It downloads the arachaeal, viral and plasmid genome in the gbff format. It should be run in a directory where you will later convert all .gbff files into .faa files in order for Kaiju to recognise them.

### gbk2faaCustom.pl  
This script is self-explanatory. It is able to convert both single as well as all .gbff.gz files in a directory to a .faa file(s). It is used before creating a custom database from custom reference sequences.

### testbwt.sh  
This script converts the concatenated .faa file (proteins.faa) into a bwt file (proteins.bwt) which is necessary for the creation of the fmi (proteins.fmi) file.

### Custom Database Creation
In order to create a custom database, merely change/add/remove the following code in HumanBacteriaRat.py before running:

```
print('Downloading <$ANY> genomes'+'\n')  
download_refseq_genome(<$ID>,'<$ANY>_genome_url.txt')
```

Replace `<$ANY>` with whatever you would like to name your genome.
Replace `<$ID>` with the relevant NCBI taxonomy ID (IDs can be found at https://www.ncbi.nlm.nih.gov/taxonomy)

Running the script HumanBacteriaRat.py without changing anything will result in the download of the human, bacteria & rat genome(s).

If the user wishes to incorporate the archaeal, viral and plasmid genome(s), the script arachaeaViralPlasmid.sh should also be run.

These scripts should be run in a directory in which the user wishes to keep reference sequences for Kaiju.

Once the previous scripts have successfully completed, and assuming that all reference sequences have been download and converted into .faa files (by invoking `perl gbk2faaCustom.pl`), and all .faa files have been concatenated into a single .faa file (`*.faa > proteins.faa`), you must then run the following commands:

```
mkbwt -n 5 -a ACDEFGHIKLMNPQRSTVWY -o <$DBNAME> <$DBNAME>.faa  
mkfmi <$DBNAME>
```  

`<$DBNAME>` can be changed to whatever you wish to name your database (I used proteins (i.e.: proteins.fmi)).

For an example of this script, please see dBScripts/Kaiju/dbCreation/testbwt.sh.  

## dBScripts/Kaiju/testDataScripts
### Classification
Classification can be run immediately utilising the custom database created during this project (proteins.fmi - located in kaijudb/faaFiles).

In order to run Kaiju classification, invoke the following command:


------------------------
Without explanation:

```
kaiju -v -x -z 12 -t nodes.dmp -f <$DBNAME>.fmi -i <$INPUT_FASTQ/A> -j <$PAIRED_READ_INPUT_FASTQ/A -o <$OUTPUT>
```


------------------------
With explanation:

```
kaiju -v -x -z 12 -t nodes.dmp -f <$DBNAME>.fmi -i <$INPUT_FASTQ/A> -j <$PAIRED_READ_INPUT_FASTQ/A> -o <$OUTPUT>
```

`-v` provides an extended output (verbose mode).  

`-x` leads to less false positive hits (enabled by default).  

`<$DBNAME>` can be replaced with whatever you have named your .fmi file.  

`<$INPUT_FASTQ/A>` should be replaced with your input file.  

The flag `-j` should only be used when using paired-reads.  

`<$PAIRED_READ_INPUT_FASTQ/A>` should be replaced with a paired-read file if necessary.  

 `<$OUTPUT>` should be replaced with the desired output filename.
  
Please see kaijuOutAll.sh for example.


------------------------

### kaijuSummaries.sh  
This script converts all Kaiju outputs to Kaiju summaries.  

Without explanation:  

```
./kaijuReport -t kaijudb/nodes.dmp -n kaijudb/names.dmp -i <$KAIJU_OUTPUT>.out -r <$TAX_LEVEL> -o <$RESULT_FILE>.out.summary
```  



------------------------
With explanation:  

```
./kaijuReport -t kaijudb/nodes.dmp -n kaijudb/names.dmp -i <$KAIJU_OUTPUT>.out -r <$TAX_LEVEL> -o <$RESULT_FILE>.out.summary
```  

`<$KAIJU_OUTPUT>` should be replaced with the output resulting from a Kaiju classificaton.  

`<$TAX_LEVEL>` should be replaced with the desired level of taxonomy for the resulting summary file (i.e. species). 

`<$RESULT_FILE>` should be replaced with the desired summary output filename.  


------------------------

### kaijuAddTaxNames2Out.sh  
This script adds taxonomy names to a Kaiju output file.

Without explanation: 

```
./addTaxonNames -u -t nodes.dmp -n names.dmp -i <$INPUT_FILE> -o <$OUTPUT_FILE>
```


--------------------
With explanation:

```
./addTaxonNames -u -t nodes.dmp -n names.dmp -i <$INPUT_FILE> -o <$OUTPUT_FILE>
```

`-u` removes all reads which are unclassified.  

`<$INPUT_FILE>` should be replaced with the relevant Kaiju output file.  

`<$OUTPUT_FILE>` should be replaced with the desired output filename. 


-----------------------
### kaijuTaxCut.sh  
This script removes columns from the Kaiju output produced via kaijuAddTaxNames2Out.sh in order to create an abundance table-friendly output for the RScript: BenchmarkTable.R. No explanation included as this is fairly self-explanatory, only keeps TaxID & lineage.

## dBScript/Kaiju/kronaScripts
  
### kaiju2kronaResults.sh  
Converts Kaiju classification output to a krona-friendly output.

Without explanation:

```
kaiju2krona -t nodes.dmp -n names.dmp -i <$KAIJU_OUTPUT> -o <$KRONA_OUTPUT>
```


------------------------
With explanation:

```
kaiju2krona -t nodes.dmp -n names.dmp -i <$KAIJU_OUTPUT> -o <$KRONA_OUTPUT>
``` 
  
`<$KAIJU_OUTPUT>` is replaced with the output originally obtained from Kaiju classification.

`<$KRONA_OUTPUT>` is the resulting output and can be renamed to whatever the user wishes.


------------------------
### kronatoHtml.sh  
Converts the resulting krona-friendly Kaiju classification output to a Krona html file.

ktImportText is part of KronaTools & it should be installed before attempting this.  

Without explanation:

```
ktImportText -o <$OUTPUT.html> <$OUTPUT_INPUT>
```


------------------------
With explanation:

```
ktImportText -o <$OUTPUT.html> <$OUTPUT_INPUT>
``` 

`<$OUTPUT.html>` should be renamed to whatever the user wishes to name the output.  

`<$OUTPUT_INPUT>` should be renamed to whatever the user named the relevant kaiju2krona output file.

## Extras  

### KaijuOutputHelp.txt  
This file details the output from running a Kaiju classification.


------------------------

# CLARK
  
## dBScripts/CLARK/dbCreation
### Default Database Creation
In all scripts below, `<$DIR_DB>` should be replaced with the directory in which the user wishes to keep their CLARK database.  
Additionally, `Custom`, in all scripts & explanations below, references the Custom directory in which all reference sequences should be kept (which should be kept inside `<$DIR_DB>`)  
  
A default CLARK database which includes the human, viral and bacterial genome(s) is created by invoking the command `sh set_targets.sh <$DIR_DB> human viruses bacteria`.

This command was not used for this project, instead, a custom database was created. Scripts relevant to the creation of a custom database as well as the process in which the custom database was created are/is explained below.

### HumanBacteriaRat.py
This script is self-explanatory. It downloads the human, bacteria and rat genome in the fna format. It should be run in the `Custom` directory.

### archaeaViralPlasmid.sh
This script is self-explanatory. It downloads the arachaeal, viral and plasmid genome in the fna format. It should be run in the `Custom` directory.

**Custom Database Creation**  
BEFORE CREATING YOUR OWN DATABASE YOU MUST WIPE THE OLD ONE FROM EXISTENCE. THIS CAN BE DONE BY RUNNING THE COMMAND `sh clean.sh` FROM THE ORIGINAL CLARK DIRECTORY.

If the user wishes to create their own custom database, they merely need to change/add/remove the following code in HumanBacteriaRat.py

```
print('Downloading <$ANY> genomes'+'\n')  
download_refseq_genome(<$ID>,'<$ANY>_genome_url.txt')
```

Replace `<$ANY>` with whatever you would like to name your genome.
Replace `<$ID>` with the relevant NCBI taxonomy ID (IDs can be found at https://www.ncbi.nlm.nih.gov/taxonomy)

If the user wishes to use download a database like the one created during this project, they must use both HumanBacteriaRat.py & archaeaViralPlasmid.sh in order to download the human, bacterial, rat, archaeal, viral & plasmid genome(s). Both scripts must be run in the `Custom` folder inside `<$DIR_DB>`.

Before the user can perform any classifications, they must invoke the command `sh set_targets.sh <$DIR_DB> custom`, which will then allow CLARK to realise the reference sequences/genomes in the `Custom` folder. 

A sample classification must then be run in order for the database to be created (please see Metagenome Classification below).

If the user wishes to use CLARK-S, the database must have already been created via performing a sample classification, after which the command `./buildSpacedDB.sh` should be used in order to create a spaced k-mer database.

In order to perform classification using CLARK-S, please see Metagenome Classification below.

## dBScripts/CLARK/testDataScripts
### Classification
Classification can be run immediately utilising the custom database created during this project ("DBD"). For a more streamlined command which utilises only default parameters (and the one which was used during this project), please see Metagenome Classification below.  

------------------------
Without explanation:

```
CLARK -T <$DIR_DB>/targets.txt -D <$DIR_DB> -P samples.L.txt samples.R.txt -R <$RESULTS_DIR> -m 0 -n 12 --extended
```


------------------------

With explanation:

```
CLARK -T <$DIR_DB>/targets.txt -D <$DIR_DB> -P samples.L.txt samples.R.txt -R <$RESULTS_DIR> -m 0 -n 12 --extended
```  

`-P` is only for paired-end reads. The command `-O` should be used for reads which are not paired-end.  

`<$RESULTS_DIR>` can be replaced with wherever you want to keep these results.  

`-m 0` is full mode (more results), use `-m 2` for express mode.  

`--extended` provides further results in the output file.  

The `targets.txt` file is generated by the initial "set_targets.sh" command and is located in the `<$DIR_DB>`.  

For `samples.L.txt` and `samples.R.txt` please have a look at the paired-reads example below.

Please have a look at any of the ClarkOutAllSamples.sh scripts for more information.


------------------------

### Metagenome Classification
This command should be used directly after running the command `sh set_targets.sh`

A simpler and more streamlined command of CLARK was used during this project. It is as follows:

Without explanation:

```
./classify_metagenome.sh -O sample.fa -R <$RESULTS_DIR> -m 0 -n 8 --spaced
```  

--------------------

With explanation:

```
./classify_metagenome.sh -O sample.fa -R <$RESULTS_DIR> -m 0 -n 8 --spaced
```  

`-O` is used when using non-paired-end reads - `-P sample1.fa sample2.fa` should be used when using paired-end reads.

`<$RESULTS_DIR>` should be replaced with the directory in which the user wishes to keep the results. 

`--spaced` is a flag which should only be added if the user is performing a classification using a spaced DB created specifically for CLARK-S.

Please have a look at metaClarkOutAllSamplesFull.sh & metaClarkSOutAllSampleFull.sh for an example. 


------------------------

### getAbundance.sh  
Calculates & creates an abundance table as well as krona file (.krn) from the CLARK results.

Without explanation:  

```
./estimate_abundance.sh -F <$CLARK_OUTPUT> -D <$DB_DIR> --krona > <$RESULT_FILE>.csv
```  


------------------------

With explanation:  

```
./estimate_abundance.sh -F <$CLARK_OUTPUT> -D <$DB_DIR> --krona > <$RESULT_FILE>.csv
``` 
`<$CLARK_OUTPUT>` should be replaced with the output from a CLARK classification.  

`<$DB_DIR>` should be replaced with the CLARK database directory.  

`<$RESULT_FILE>` should be replaced with the desired output filename.  

A krona file is automatically generated in the directory where the script is run.

------------------------

## dBScripts/CLARK/kronaScripts

### kronaScripts.sh  
Converts the krona file(s) generated in the previous script into an html file.  

Without explanation:  

```
ktImportTaxonomy -o <$HTML_FILE>.html -m 3 <$KRONA_FILE>.krn
```  


------------------------

With explanation: 

```
ktImportTaxonomy -o <$HTML_FILE>.html -m 3 <$KRONA_FILE>.krn
```  
`<$HTML_FILE>` can be replaced with the output HTML file desired.  

`<$KRONA_FILE>` can be replaced with the krona file generated from the previous script.  

getAbundance.sh & kronaScripts.sh are written twice with slight variation in both their names and scripts for each of the different CLARK types (CLARK & CLARK-S). Please refer to the scripts in the relevant sub-directories for more information.


------------------------
## Extras  

### clarkOutHelp.txt  
Details the output of a CLARK classification.


------------------------------------------------------------------------------------


# rScripts
The directory rScripts contains scripts which utilise data downloaded by scripts in the 
ncbiScripts directory - curates & generates figures & RMarkdown.

VITAL: PAY ATTENTION TO VARIABLES & FILE NAMES, THEY MUST BE EXACTLY AS NAMED IN THE RSCRIPT OR
IT WILL NOT WORK!

## FigureGen.R
If you have not run this script before you will need to install necessary libraries. This can be found at the bottom of the script.
This R script curates all downloaded metadata from the ncbiScripts and generates a fair amount of figures based upon that data.

Figures include platform abundance, organism abundance, platform utilisation over time (bases
per year), rat sample wordcloud.


## SRACharMarkdown.RMD
This generates an RMarkdown document to your liking. Can be modified to include whichever 
figures take the user's fancy. At this moment in time includes all relevant figures. Please
run the FigureGen.R before attempting to render the RMarkdown document, all figures must be
generated at least once beforehand.  
  
## BenchmarkTable.R  
This takes the resulting abundance tables & outputs produced from each classifier and creates the tables found in BenchmarkTables & taxTables. All data considered is sample data designed to benchmark the classifiers with previously known/realised content. This script could theoretically be used to analyse other data if changed accordingly.


----------------------------------------------------------------------------------
# ncbiScripts
The directory ncbiScripts contains scripts which download all metadata from every dataset
on the SRA (fixScript.pl) as well as scripts which return correct taxonomic classification
for every taxonomic ID given from the original metadata.

VITAL: YOU MUST FIRST GENERATE A LIST OF TAXONOMIC IDS FROM THE METADATA DOWNLOADED VIA
fixScript.pl, A TUTORIAL ON HOW TO DO SO EXISTS IN FigureGen.R, INCLUDES ALL NECESSARY CODE.

## fixScript.pl
This script downloads all metadata necessary from every dataset on the SRA. Metadata
includes ID, organism common name & scientific name, organism taxonomic ID, sample information,
creation date and update date, platform model used, generic platform name, number of bases,
study title, and study description. 

Generates text file named to your liking, merely invoke 'fixScript.pl > "filename".txt'

## taxScript.pl
This script returns taxonomic names from the NCBI taxonomy database based upon a text file with provided taxonomic IDs.
Taxonomic IDs must be separated via a newline character. IDs are read in as an array.

## prefetchSRA.sh
This script downloads the relevant SRA dataset for a specific SRR accession number. If you wish to download a specific dataset, merely change the accession number(s).
Typically stores the files in /home/user/ncbi/sra/public.

## fastqDump1.sh & fastqDump2.sh
This script extracts the fastq files from the .sra file downloaded in the prefetchSRA.sh script. Merely change the script so that it points to the .sra file(s) downloaded via the prefetchSRA.sh script. 
The second parameter is where the resulting fastq files will be saved.
