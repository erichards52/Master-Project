## Bracken
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


