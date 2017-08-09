#Load libraries for pielou calculation
library(OTUtable)

#Set working directory to where cut Kaiju outputs are stored
setwd("/home4/rich01e/GitProj/stepThree_Virome/outputStore/")

#Read viral tax list
virTax <- read.table("virTax.txt", header = T)
colnames(virTax) <- "TaxID"

#set working directory to where virome table is located
setwd("/home4/rich01e/GitProj/stepThree_Virome/")

#Read in virome table and create dataframe that will be used for PCA
virTable <- read.table("viromeInfo.tsv",header=T, sep= "\t")
taxVec <- virTax$TaxID
pcaDF <- matrix(nrow = length(taxVec))
rownames(pcaDF) <- taxVec
pcaDF <- as.data.frame(pcaDF)

#Set working directory to where cut Kaiju outputs are stored
setwd("/home4/rich01e/GitProj/stepThree_Virome/outputStore/")

#Read frequency table(s)
files <- list.files(path="/home4/rich01e/GitProj/stepThree_Virome/outputStore/", pattern="*.tsv", full.names=T, recursive=FALSE)
lapply(files, function(x) {
  t <- read.table(files, header=T, sep="\t")
  #Merge with viral taxID table and recover sample name
  t <- merge(virTax, t)
  samp <- sub(".*/", "", files)
  samp <- gsub("\\..*","",samp)
  samp <- gsub("OTUTable","",samp)
  #Assign taxIDs as rownames and sample as column name
  rownames(t) <- t$TaxID
  t <- t[c(-1,-2)]
  colnames(t) <- samp
  #merge with pca dataframe
  pcaDF <- merge(t, pcaDF, by = 0)
})
write.table(pcaDF, "testOut.tsv", sep="\t",header=T,col.names = T,row.names = T)
  