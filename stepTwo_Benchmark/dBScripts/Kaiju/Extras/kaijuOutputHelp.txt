### Output format
Kaiju will print one line for each read or read pair. 
The default output format contains three columns separated by tabs. Using the option `-v` enables the verbose 
output, which will print additional columns: 
1. either C or U, indicating whether the read is classified or unclassified. 
2. name of the read 
3. NCBI taxon identifier of the assigned taxon 
4. the length or score of the best match used for classification 
5. the taxon identifiers of all database sequences with the best match 
6. the accession numbers of all database sequences with the best match 
7. matching fragment sequence(s) NB: Since the _nr_ database aggregates multiple genes of identical sequences, only the first accession number
for each sequence is kept in Kaiju's database and therefore also in the output file.
