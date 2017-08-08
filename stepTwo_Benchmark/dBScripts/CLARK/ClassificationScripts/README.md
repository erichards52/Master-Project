# Explanation of Scripts
## metaClarkOutAllSamplesFull.sh & metaClarkSOutAllSamplesFull.sh
### Performs classification on all sample files which were provided during the project

This command should be used directly after running the command `sh set_targets.sh`

Without explanation:

```
./classify_metagenome.sh -O sample.fa -R <$RESULTS_DIR> -m 0 -n 8 --spaced
```  

--------------------

With explanation:

```
./classify_metagenome.sh -O sample.fa -R <$RESULTS_DIR> -m 0 -n 8 --spaced
```  

`-O` is used when using non-paired-end reads - `-P sample1.fa sample2.fa` should be used when using paired-end reads.

`<$RESULTS_DIR>` should be replaced with the directory in which the user wishes to keep the results. 

`--spaced` is a flag which should only be added if the user is performing a classification using a spaced DB created specifically for CLARK-S.


### getAbundance.sh & getAbundanceClarkS.sh  
Calculates & creates an abundance table as well as krona file (.krn) from the CLARK results.

Without explanation:  

```
./estimate_abundance.sh -F <$CLARK_OUTPUT> -D <$DB_DIR> --krona > <$RESULT_FILE>.csv
```  


------------------------

With explanation:  

```
./estimate_abundance.sh -F <$CLARK_OUTPUT> -D <$DB_DIR> --krona > <$RESULT_FILE>.csv
``` 
`<$CLARK_OUTPUT>` should be replaced with the output from a CLARK classification.  

`<$DB_DIR>` should be replaced with the CLARK database directory.  

`<$RESULT_FILE>` should be replaced with the desired output filename.  

A krona file is automatically generated in the directory where the script is run.

------------------------
 

