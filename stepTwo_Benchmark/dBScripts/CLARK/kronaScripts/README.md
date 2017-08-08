# Explanation of Scripts
## kronaScripts.sh & kronaScriptsClarks.sh
 
Converts the krona file(s) generated in the previous scripts (getAbundance.sh) into an html file.  

Without explanation:  

```
ktImportTaxonomy -o <$HTML_FILE>.html -m 3 <$KRONA_FILE>.krn
```  


------------------------

With explanation: 

```
ktImportTaxonomy -o <$HTML_FILE>.html -m 3 <$KRONA_FILE>.krn
```  
`<$HTML_FILE>` can be replaced with the output HTML file desired.  

`<$KRONA_FILE>` can be replaced with the krona file generated from the previous script.  


