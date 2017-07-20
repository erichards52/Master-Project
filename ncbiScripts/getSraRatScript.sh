mapfile -t myArray < RattusNorvegicusAccNos.txt
while IFS= read -r line; do wget 'http://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&db=sra&rettype=runinfo&term=<$line[uid]>'; done < RattusNorvegicusAccNos.txt


