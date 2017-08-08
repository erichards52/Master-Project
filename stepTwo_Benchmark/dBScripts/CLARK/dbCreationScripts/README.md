## Default Database Creation
In all scripts below, `<$DIR_DB>` should be replaced with the directory in which the user wishes to keep their CLARK database.  
Additionally, `Custom`, in all scripts & explanations below, references the Custom directory in which all reference sequences should be kept (which should be kept inside `<$DIR_DB>`)  
  
A default CLARK database which includes the human, viral and bacterial genome(s) is created by invoking the command `sh set_targets.sh <$DIR_DB> human viruses bacteria`.

This command was not used for this project, instead, a custom database was created. Scripts relevant to the creation of a custom database as well as the process in which the custom database was created are/is explained below.

### HumanBacteriaRat.py
This script is self-explanatory. It downloads the human, bacteria and rat genome in the fna format. It should be run in the `Custom` directory.

### archaeaViralPlasmid.sh
This script is self-explanatory. It downloads the arachaeal, viral and plasmid genome in the fna format. It should be run in the `Custom` directory.

## Custom Database Creation  
BEFORE CREATING YOUR OWN DATABASE YOU MUST WIPE THE OLD ONE FROM EXISTENCE. THIS CAN BE DONE BY RUNNING THE COMMAND `sh clean.sh` FROM THE ORIGINAL CLARK DIRECTORY.

If the user wishes to create their own custom database, they merely need to change/add/remove the following code in HumanBacteriaRat.py

```
print('Downloading <$ANY> genomes'+'\n')  
download_refseq_genome(<$ID>,'<$ANY>_genome_url.txt')
```

Replace `<$ANY>` with whatever you would like to name your genome.
Replace `<$ID>` with the relevant NCBI taxonomy ID (IDs can be found at https://www.ncbi.nlm.nih.gov/taxonomy)

If the user wishes to use download a database like the one created during this project, they must use both HumanBacteriaRat.py & archaeaViralPlasmid.sh in order to download the human, bacterial, rat, archaeal, viral & plasmid genome(s). Both scripts must be run in the `Custom` folder inside `<$DIR_DB>`.

Before the user can perform any classifications, they must invoke the command `sh set_targets.sh <$DIR_DB> custom`, which will then allow CLARK to realise the reference sequences/genomes in the `Custom` folder. 

A sample classification must then be run in order for the database to be created (please see Metagenome Classification below).

If the user wishes to use CLARK-S, the database must have already been created via performing a sample classification, after which the command `./buildSpacedDB.sh` should be used in order to create a spaced k-mer database.

