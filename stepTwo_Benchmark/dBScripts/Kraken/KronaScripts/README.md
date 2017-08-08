## KronaScripts

### cutKrakResults.sh  
Converts the resulting Kraken classification output files ito krona-friendly files by retrieving desired columns.

If you wish to convert the Kraken output into Krona friendly output, invoke the following command:

Without explanation:

```
cut -f2,3 <$OUTPUT_INPUT> > <$OUTPUT>
```


------------------------
With explanation:

```
cut -f2,3 (removes columns not needed) <$OUTPUT_INPUT> > <$OUTPUT>
```

`<$OUTPUT_INPUT>` should be renamed to whichever Kraken output the user wishes to convert to Krona-friendly input.

`<$OUTPUT>` should be renamed to whatever the users wishes to name the resulting Krona-friendly output.


------------------------

### krak2Krona.sh  

Converts the resulting krona-friendly Kraken output file to an html krona file.  
ktImportTaxonomy is part of KronaTools.

Without explanation:

```
ktImportTaxonomy <$OUTPUT_INPUT> -o <$OUTPUT>.html
```


------------------------
With explanation:

```
ktImportTaxonomy <$OUTPUT_INPUT> -o <$OUTPUT>.html
```

`<$OUTPUT_INPUT>` should be renamed to whichever krona-friendly Kraken classification output the user wishes to convert to a krona html file.  

`<$OUTPUT>` should be renamed to whatever the users wishes to name the resulting krona html file.

