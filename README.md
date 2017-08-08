# Database Characterization, Benchmarking, Virome Assembly
## Step One: Database Characterization - stepOne_SRAChar
#### Contains:
* Script for downloading SRA metadata 
* Script for creating figures and tables from SRA metadata


-------------------------------------------------


## Step Two: Benchmarking - stepTwo_Benchmark
#### Contains:
* Script for downloading datasets from the SRA and extracting datasets in order to create FASTQ files.
* Script for creating custom databases for CLARK, Kraken & Kaiju
* Script for performing classification with CLARK, Kraken & Kaiju
* Information about classifier outputs
* Script for creating Krona plots from CLARK, Kraken & Kaiju outputs
* Script for reading outputs for each classifier and creating benchmark tables as well as taxon ID overlap Venn diagrams
* Script for returning taxon names from taxon IDs


-------------------------------------------------


## Step Three: Virome Assembly - stepThree_Virome
#### Contains:
* Script to retrieve sample accession numbers based upon desired factors
* Text file containing all SRA sample accession numbers associated with taxon ID 10116
* Script which returns a variety of information based upon classification output of Kaiju
* Script which downloads and extracts datasets from the SRA, performs classification using Kaiju and retrieves variety of information about classification based on output
