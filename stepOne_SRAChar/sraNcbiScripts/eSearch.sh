#Returns a variety of metadata for all SRA datasets
esearch -db sra -query 'public OR controlled' | efetch -format runinfo
