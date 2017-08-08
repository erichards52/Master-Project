## Krona Scripts
### kaiju2kronaResults.sh  
Converts Kaiju classification output to a krona-friendly output.

Without explanation:

```
kaiju2krona -t nodes.dmp -n names.dmp -i <$KAIJU_OUTPUT> -o <$KRONA_OUTPUT>
```


------------------------
With explanation:

```
kaiju2krona -t nodes.dmp -n names.dmp -i <$KAIJU_OUTPUT> -o <$KRONA_OUTPUT>
``` 
  
`<$KAIJU_OUTPUT>` is replaced with the output originally obtained from Kaiju classification.

`<$KRONA_OUTPUT>` is the resulting output and can be renamed to whatever the user wishes.


------------------------
### kronatoHtml.sh  
Converts the resulting krona-friendly Kaiju classification output to a Krona html file.

ktImportText is part of KronaTools & it should be installed before attempting this.  

Without explanation:

```
ktImportText -o <$OUTPUT.html> <$OUTPUT_INPUT>
```


------------------------
With explanation:

```
ktImportText -o <$OUTPUT.html> <$OUTPUT_INPUT>
``` 

`<$OUTPUT.html>` should be renamed to whatever the user wishes to name the output.  

`<$OUTPUT_INPUT>` should be renamed to whatever the user named the relevant kaiju2krona output file.

