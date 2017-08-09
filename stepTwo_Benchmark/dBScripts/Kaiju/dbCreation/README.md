### Default database Creation
Invoking the command `makeDB.sh -e -v -t 12` will automatically create a Kaiju default database within the current working directory.
This script will create a reference database which includes the arachael genome, human genome, bacterial genome and viral genome.

This script was not used for this project, instead, a custom database was created. Scripts utilised for the purpose of building a custom database as well as the process in which the custom database was created are/is described below.

### KaijuDB.py
This script is self-explanatory. It downloads the human, bacteria and rat genome as well as arachaeal, viral and plasmid genomes in the gbff format. It should be run in a directory where you will later convert all .gbff files into .faa files in order for Kaiju to recognise them. 

### gbk2faaCustom.pl  
This script is self-explanatory. It is able to convert both single as well as all .gbff.gz files in a directory to a .faa file(s). It is used before creating a custom database from custom reference sequences.

### createbwt.sh  
This script converts the concatenated .faa file (proteins.faa) into a bwt file (proteins.bwt) which is necessary for the creation of the fmi (proteins.fmi) file.

### Custom Database Creation
In order to create a custom database, merely change/add/remove the following code in KaijuDB.py before running:

```
print('Downloading <$ANY> genomes'+'\n')  
download_refseq_genome(<$ID>,'<$ANY>_genome_url.txt')
```

Replace `<$ANY>` with whatever you would like to name your genome.
Replace `<$ID>` with the relevant NCBI taxonomy ID (IDs can be found at https://www.ncbi.nlm.nih.gov/taxonomy)

This script should be run in a directory in which the user wishes to keep reference sequences for Kaiju.

Once the previous scripts have successfully completed, and assuming that all reference sequences have been download and converted into .faa files (by invoking `perl gbk2faaCustom.pl`), and all .faa files have been concatenated into a single .faa file (`*.faa > proteins.faa`), you must then run the following commands:

```
mkbwt -n 5 -a ACDEFGHIKLMNPQRSTVWY -o <$DBNAME> <$DBNAME>.faa  
mkfmi <$DBNAME>
```  

`<$DBNAME>` can be changed to whatever you wish to name your database (I used proteins (i.e.: proteins.fmi)).

For an example of this script, please see createbwt.sh.  

