# Explanation of Scripts

## KaijuFreqVir.R
* Creates abundance tables from Kaiju output
* Prints classification metadata

## createVirome.pl
* Downloads and extract FASTQ files of all SRA accession associated with tax ID 10116 (*Rattus norvegicus*)
* Performs classification using Kaiju
* Returns/prints metadata (utilising KaijuFreqVir.R) and produces krona plot
* Automated upload to GitHub

## addKronaLinks.R
* Adds krona links to viromeInfo.tsv
