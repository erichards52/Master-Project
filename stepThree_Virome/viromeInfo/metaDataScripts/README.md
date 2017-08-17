# Explanation of Scripts
## copySampleFiles.sh
* Copies abundance tables from all desired samples - based on txt file of filenames

## ViromeMetadata.R
* Filters samples based upon thresholds to return txt file of desired samples
* Returns top 10 viral taxa based upon name 
* Returns top 10 viral taxa based upon reads classified

## readTablesPCA.R
* Reads in all tsv files in a directory (desired samples/samples of interest)
* Logs value of all abundances
* Creates PCA plot

## virTax
* List of all viral taxa as per NCBI
