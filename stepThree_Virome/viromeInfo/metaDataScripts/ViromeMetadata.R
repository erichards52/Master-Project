#libraries
library(data.table)

#Read in virome information table - produced by createvirome script
setwd("~/MastersDegree/Thesis/R/RScripts/viromeInfo/")
virTable <- read.table("viromeInfo.tsv",header=T,sep="\t",quote="")

#Get most abundant viruses by name
virTableSub <- virTable[c(13)]
virTableSub <- sort(table(virTableSub),decreasing=T)
virTableSub <- as.data.frame(virTableSub)
virTableSub <- head(virTableSub,10)
colnames(virTableSub) <- c("Taxon Name", "Frequency")
write.table(virTableSub, file ="virNameFreq.tsv", sep="\t",col.names = T,row.names = F,quote=F)

#get most abundant viruses by hits
virTable[, 14] <- as.numeric(as.character( virTable[, 14] ))
virTableHits <- aggregate(virTable$Top.Viral.TaxID.Hits, by=list(Category=virTable$Top.Viral.TaxID.Name), FUN=sum)
colnames(virTableHits) <- c("Taxon Name", "Reads Classified")
virTableHits <- virTableHits[order(-virTableHits$`Reads Classified`),]
virTableHits <- head(virTableHits,10)
write.table(virTableHits, file ="virHitOrder.tsv", sep="\t",col.names = T,row.names = F,quote=F)

#get samples with the highest pielou's evennness as well as total viral hits for analysis/PCA plot
#Order by pielou and total viral hits
sampleTable <- virTable[c(1,6,11,13,14)]
sampleTable[, 2] <- as.numeric(as.character( sampleTable[, 2] ))
sampleTable[, 3] <- as.numeric(as.character( sampleTable[, 3] ))
threshold <- 2000
hiThreshold <- 8000
pieThreshold <- 0.1
sampleTable <- subset(sampleTable, sampleTable[,3] > threshold)
sampleTable <- subset(sampleTable, sampleTable[,2] > pieThreshold)
sampleTable <- sampleTable[with(sampleTable, order(-Pielou.s.Evenness, -Total.Viral.Hits)), ]
sampleTable <- sampleTable[ order(-sampleTable[,2], -sampleTable[,3]), ]

#Write out
colnames(sampleTable) <- c("Sample Accession No.", "Pielou's Evennness", "Total Viral Read Classified", "Top Viral Read Classified")
write.table(sampleTable, file ="SamplesOfInterest.tsv", sep="\t",col.names = F,row.names = F,quote=F)

#For creating a list of files to be copied (MUST BE DONE BEFORE WRITING CHANGING COLUMN NAMES IN LAST BATCH OF CODE)
sampleTable$Sample.Accession.No. <- paste(sampleTable$Sample.Accession.No., ".tsv", sep="") 
write.table(sampleTable$Sample.Accession.No., file ="SamplesOfInteresttoCopy.tsv", sep="\t",col.names = F,row.names = F,quote=F)

