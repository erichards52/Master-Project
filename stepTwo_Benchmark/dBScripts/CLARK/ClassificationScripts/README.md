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

 

