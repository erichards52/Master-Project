## Classification
Classification can be run immediately utilising the custom database created during this project (proteins.fmi - located in kaijudb/faaFiles).

In order to run Kaiju classification, invoke the following command:


------------------------
Without explanation:

```
kaiju -v -x -z 12 -t nodes.dmp -f <$DBNAME>.fmi -i <$INPUT_FASTQ/A> -j <$PAIRED_READ_INPUT_FASTQ/A -o <$OUTPUT>
```


------------------------
With explanation:

```
kaiju -v -x -z 12 -t nodes.dmp -f <$DBNAME>.fmi -i <$INPUT_FASTQ/A> -j <$PAIRED_READ_INPUT_FASTQ/A> -o <$OUTPUT>
```

`-v` provides an extended output (verbose mode).  

`-x` leads to less false positive hits (enabled by default).  

`<$DBNAME>` can be replaced with whatever you have named your .fmi file.  

`<$INPUT_FASTQ/A>` should be replaced with your input file.  

The flag `-j` should only be used when using paired-reads.  

`<$PAIRED_READ_INPUT_FASTQ/A>` should be replaced with a paired-read file if necessary.  

 `<$OUTPUT>` should be replaced with the desired output filename.
  
Please see kaijuOutAll.sh for example.


------------------------

### kaijuSummaries.sh  
This script converts all Kaiju outputs to Kaiju summaries.  

Without explanation:  

```
./kaijuReport -t kaijudb/nodes.dmp -n kaijudb/names.dmp -i <$KAIJU_OUTPUT>.out -r <$TAX_LEVEL> -o <$RESULT_FILE>.out.summary
```  



------------------------
With explanation:  

```
./kaijuReport -t kaijudb/nodes.dmp -n kaijudb/names.dmp -i <$KAIJU_OUTPUT>.out -r <$TAX_LEVEL> -o <$RESULT_FILE>.out.summary
```  

`<$KAIJU_OUTPUT>` should be replaced with the output resulting from a Kaiju classificaton.  

`<$TAX_LEVEL>` should be replaced with the desired level of taxonomy for the resulting summary file (i.e. species). 

`<$RESULT_FILE>` should be replaced with the desired summary output filename.  


------------------------

### kaijuAddTaxNames2Out.sh  
This script adds taxonomy names to a Kaiju output file.

Without explanation: 

```
./addTaxonNames -u -t nodes.dmp -n names.dmp -i <$INPUT_FILE> -o <$OUTPUT_FILE>
```


--------------------
With explanation:

```
./addTaxonNames -u -t nodes.dmp -n names.dmp -i <$INPUT_FILE> -o <$OUTPUT_FILE>
```

`-u` removes all reads which are unclassified.  

`<$INPUT_FILE>` should be replaced with the relevant Kaiju output file.  

`<$OUTPUT_FILE>` should be replaced with the desired output filename. 


-----------------------
### kaijuTaxCut.sh  
This script removes columns from the Kaiju output produced via kaijuAddTaxNames2Out.sh in order to create an abundance table-friendly output for the RScript: BenchmarkTable.R. No explanation included as this is fairly self-explanatory, only keeps TaxID & lineage.

