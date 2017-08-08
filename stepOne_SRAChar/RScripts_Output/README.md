# Explanation of Scripts
## GetAccs.R
Should be run after running "eSearch.pl > SRADumpTax". 

eSearch.pl can be found in sraScripts. 

Returns "RatSampleAccs.txt", a list of sample accession from the SRA which are associated with the tax ID 10116.

## SRATableFigure.R
Should be run after running "sraRet.pl > SRAData.txt". 

sraRet.pl can be found in sraScripts. 

Data should be read in and then TaxID.txt should be produced via last lines of script in SRATableFigure.R before running the rest of code.

Does not produce an updated line plot of bases sequenced by platform per year. Has to be done manually.

Returns the RMardown document: "SRACharMarkdown_16_June_2017.Rmd".


