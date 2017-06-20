# Scripts: A Walkthrough

## dBScripts
The directory dBScripts contains scripts which create databases for each classifier.

-------------------------
### Kraken

Invoking the command 'python pythonKrakDB.py' will automatically create a Kraken database
with the name EdKrakDB. It is best to run this command within a separate directory which
has already been named appropriately (i.e.: I typically run this command once I have created
a directory called "KrakDB"). 

This script will create an arachael genome, human genome, bacterial genome, viral genome and rat genome

-------------------------
### Kaiju

Invoking the command 'makeDB.sh -e -r -v' will automatically create a Kaiju database. The name of
the database is not relevant as it is not included within the commands to query the database.
It is best to run this command within a separate directory which has already been named 
appropriately (i.e.: I typically run this command once i Have created a directory called 
"kaijudb".)

The script will create arachael genome, human genome, bacterial genome and viral genome. The
rat genome still has to be incorporated. 

VITAL: YOU MUST COPY ALL CONTENTS FROM THE BIN IN THE ORIGINAL DOWNLOAD TO YOUR WD BEFORE THIS SCRIPT WILL WORK (/home4/rich01e/kaiju/bin).
-------------------------
### CLARK

No commands necessary (so far), uses database already created by Kraken.

------------------------------------------------------------------------------------
## rScripts
The directory rScripts contains scripts which utilise data downloaded by scripts in the 
ncbiScripts directory - curates & generates figures & RMarkdown.

VITAL: PAY ATTENTION TO VARIABLES NAMES, THEY MUST BE EXACTLY AS NAMED IN THE RSCRIPT OR
IT WILL NOT WORK!

-------------------------
### FigureGen.R

This R script curates all downloaded metadata from the ncbiScripts and generates a fair
amount of figures based upon that data.

Figures include platform abundance, organism abundance, platform utilisation over time (bases
per year), rat sample wordcloud.

------------------------
### SRACharMarkdown.RMD

This generates an RMarkdown document to your liking. Can be modified to include whichever 
figures take the user's fancy. At this moment in time includes all relevant figures. Please
run the FigureGen.R before attempting to render the RMarkdown document, all figures must be
generated at least once beforehand.

----------------------------------------------------------------------------------
## ncbiScripts
The directory ncbiScripts contains scripts which download all metadata from every dataset
on the SRA (fixScript.pl) as well as scripts which return correct taxonomic classification
for every taxonomic ID given from the original metadata.

VITAL: YOU MUST FIRST GENERATE A LIST OF TAXONOMIC IDS FROM THE METADATA DOWNLOADED VIA
fixScript.pl, A TUTORIAL ON HOW TO DO SO EXISTS IN FigureGen.R, INCLUDES ALL NECESSARY CODE.

------------------------
### fixScript.pl

This script downloads all metadata necessary from every single dataset on the SRA. Metadata
includes ID, organism common name & scientific name, organism taxonomic ID, sample information,
creation date and update date, platform model used, generic platform name, number of bases,
study title, and study description. 

Generates text file named to your liking, merely invoke 'fixScript.pl > "filename".txt'

------------------------
### taxScript.pl

This script returns taxonomic names based upon a text file with provided taxonomic IDs.
Taxonomic IDs must be separated via a newline character. IDs are read in as an array.


