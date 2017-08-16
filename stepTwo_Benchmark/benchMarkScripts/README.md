# Explanation of Scripts

## BenchmarkTableVenn.R

* Reads in outputs from CLARK, Kraken and Kaiju.
* Creates benchmark tables and Venn diagrams
* This script was one of the first scripts to be created during the project and thus contains an abundance of redundant code. Due to time constraints this code was not properly cleaned.

## taxScriptVir.pl

* Used in order to return division/kingdom of a tax ID  
* Queries NCBI and prints both the division/kingdom as well as the tax ID
* Used as part of BenchmarkTableVenn.R originally in order to determine which tax IDs were Viral/Phage and merge frequency/abundance tables in order to retrieve further viral information.
