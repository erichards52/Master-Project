# Explanation of Scripts
**All scripts in this directory MUST be concatenated**
## sraRet.pl
Returns a variety of metadata which can instantly be read into R in order to generate figures and tables in R. 
Workflow:
* Run sraRet.pl > SRAData.txt
* Run SRATableFigure.R found in RScripts_Output

## eSearch.sh
Returns variety of metadata which can instantly be read into R. 
Workflow:
* Run eSearch.sh > SRADumpTax.txt
* Run GetAccs.R to return a list of sample accessions using taxon ID 10116 as RatSamplAccs.txt

## taxScript.pl
Returns a tax ID and tax name based upon a txt of provided tax IDs
* Creates TaxDF.txt

## taxDF.txt
A list of tax IDs and names as produced by taxScript.pl in conjunction with a list of tax IDs provided in txt format 
