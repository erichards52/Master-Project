# Set working dir to where virome info is located
setwd("~/GitProj/stepThree_Virome")

# Open viromeInfo.tsv and create vector of sample acc. numbers
virTable <- read.delim("viromeInfo.tsv", header = T)
accVec <- virTable$Sample.Accession.No.

#Create links from sample acc no.s
links <- paste("https://erichards52.github.io/Master-Project/kronaOutputs/ratNorv/", accVec, ".html", sep="")
virTable$KronaPlot <- links

#Write out new table
write.table(virTable, "viromeTable.tsv",quote = F,col.names = T,row.names = F, sep="\t")
