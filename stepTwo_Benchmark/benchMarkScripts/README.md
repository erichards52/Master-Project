# Explanation of Scripts

## BenchmarkTableVenn.R

* Reads in outputs from CLARK & Kraken.
* Reads in outputs from Kaiju, but was not used in order to generate values for tables as another script was created to do so.
* Creates benchmark tables and Venn diagrams

Workflow:
* Read in files from CLARK & Bracken output
* Create tables/perform calculations in R using the script BenchmarkTableVenn.R
* Create tables/perform calculations in R using the script KaijuFreqVir.R for cut kaiju output files

## KaijuFreqVir.R

* Reads in outputs from Kaiju (those that have been cut for lineage and tax only)
* Prints desired outputs 

## taxScriptVir.pl

* Used in order to return division/kingdom of a tax ID  
* Queries NCBI and prints both the division/kingdom as well as the tax ID
* Used as part of BenchmarkTableVenn.R originally in order to determine which tax IDs were Viral/Phage and merge frequency/abundance tables in order to retrieve further viral information.
