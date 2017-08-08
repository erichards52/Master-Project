## Default Database Creation

### ratKrakDBCreationScript.py
Invoking the command `python ratKrakDBCreationScript.py` will automatically create a (default) Kraken database with the name HumanVirusBacteriaRat within the current working directory.

This script will create a reference database consisting of the arachael genome, human genome, bacterial genome, viral genome and rat genome.

### Custom Database Creation 
If you wish to create your own custom database, merely add the following lines to ratKrakDBCreationScript.py such that `<$ID>` is changed to the taxonomic ID for the genome/species/reference sequence you wish to incorporate before running the script. 

```
print('Downloading <$ANY> genome'+'\n')  
download_refseq_genome(<$ID>,'<$ANY>_genome_url.txt')  
print('Converting sequences to kraken input format'+'\n')  
get_fasta_in_kraken_format('<$ANY>_genome.fa')
```

Replace `<$ANY>` with whatever you would like to name your genome.

Replace `<$ID>` with the relevant NCBI taxonomy ID (IDs can be found at https://www.ncbi.nlm.nih.gov/taxonomy)

