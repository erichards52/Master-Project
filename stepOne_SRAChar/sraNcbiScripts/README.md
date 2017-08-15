# Explanation of Scripts
**All scripts in this directory MUST be concatenated**
## sraRet.pl
Returns a variety of metadata which can instantly be read into R in order to generate figures and tables in R. 
Workflow:
* Run sraRet.pl > SRAData.txt
* Run SRATableFigure.R found in RScripts_Output


------------------------------------------------


## eSearch.sh
Returns variety of metadata which can instantly be read into R. 
Workflow:
* Run eSearch.sh > SRADumpTax.txt
* Run GetAccs.R to return a list of sample accessions using taxon ID 10116 as RatSamplAccs.txt
