## Classification
Classification can be run immediately utilising the custom database created during this project ("HumanVirusBacteriaRat").

In order to run Kraken classification, invoke the following command:


Without explanation:

```
kraken --preload --threads 12 --fastq-input --paired --db <$DIR_DB> sample1.R1.fq sample2.R2.fq
```

------------------------
With explanation:

```
kraken --preload (preloads database) --threads 12 --fastq-input --paired --db <$DIR_DB> sample1.R1.fq sample2.R2.fq
```

  
  
`preload` allows the user to preload the database, useful if carrying out multiple classifications.  

`fastq-input` allows the user to use FASTQ files rather than FASTA.  

`--paired` allows the user to use paired-end reads.  

`<$DIR_DB>` can be replaced with the database that you have made (i.e.: mine is HumanVirusBacteriaRat).



------------------------

In order to store output, you could either create a bash script and concatenante the output: (i.e.: KrakenClassificationScript.sh > KrakenOutput.txt) or simply concatenate the command itself: 

```
kraken --preload --threads 12 --fastq-input --paired --db <$DIR_DB> sample1.R1.fq sample2.R2.fq > KrakenOutput.txt
```

If you wish to see an example of this in use, please see krakOutAll.sh  

### krakReportAll.sh

Creates Kraken reports from Kraken outputs.


Without explanation:  

```
kraken-report --db <$DIR_DB> <$KRAK_OUTPUT> > <$KRAK_REPORT>
```


------------------------

With explanation:  

```
kraken-report --db <$DIR_DB> <$KRAK_OUTPUT> > <$KRAK_REPORT>
```

`<$DIR_DB>` can be replaced with the Kraken database directory (i.e. Mine is HumanVirusBacteriaRat).

`<$KRAK_OUTPUT>` is the resulting output from the original classification of a sequence.

`<$KRAK_REPORT>` is the resulting report file produced by Kraken.

