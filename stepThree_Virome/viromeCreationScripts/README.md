# Explanation of Scripts

## KaijuFreqVir.R
* Creates abundance/frequency table of tax IDs identified by Kaiju and with respective tax names
* Prints general information as well as viral information

## createVirome.pl
* Downloads and extract FASTQ files of all SRA accession associated with tax ID 10116 (*Rattus norvegicus*)
* Performs classification using Kaiju
* Returns/prints general as well as viral information for dataset (utilising KaijuFreqVir.R) and produces krona plot
* Automated upload of information as well as krona plot to GitHub
