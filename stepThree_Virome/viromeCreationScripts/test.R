#Load libraries for pielou calculation
library(OTUtable)
library(dplyr)

#Read in virome information table
setwd("/home4/rich01e/GitProj/stepThree_Virome/")
virTable <- read.table("viromeInfo.tsv",header=T,sep="\t")

#Set working directory to where cut Kaiju outputs are stored
setwd("/home4/rich01e/GitProj/stepThree_Virome/outputStore/")

#Read viral tax list
virTax <- read.table("virTax.txt", header = T)
colnames(virTax) <- "TaxID"

#Read frequency table(s) and remove unneeded values
#Stores unique tax values
#Removes lineage
files <- list.files(path="/home4/rich01e/GitProj/stepThree_Virome/outputStore/", pattern="*.tsv", full.names=T, recursive=FALSE)
read.data <- function(file){
  dat <- read.table(file,header=T,sep="\t")
  dat$fname <- file
  return(dat)
}
dataset <- do.call(rbind.fill, lapply(list.files(pattern="tsv$"),read.data))
taxVec <- unique(dataset$TaxID)
dataset$Lineage <- NULL

#Create dataframe that will be used with PCA plot, unlist the vectors in columns and rownames
pcaDF <- matrix(ncol = length(unique(dataset$fname)), nrow = length(taxVec))
colnames(pcaDF) <- unique(dataset$fname)
rownames(pcaDF) <- taxVec

# split based on filename, uses vector of unique filenames
# set taxIDs as rownames & filenames as rownames
# merge all dataframes based on taxIDs
df <- split(dataset, dataset$fname)
c <- unique(dataset$fname)
for(i in c){
df <- lapply(df, setNames, nm = c("TaxID", i, "fname"))
}
df <- lapply(df, function(x) { x["fname"] <- NULL; x })
df <- lapply(df, function(x){ row.names(x)<- x$TaxID; x})
merge.all <- function(x, y) {
  merge(x, y, all=F, by="TaxID")
}
output <- Reduce(merge.all, df, virTax)
rownames(output) <- output$TaxID
output$TaxID <- NULL

write.table(output, "allDataVirMerge.tsv", col.names = T, row.names = T, sep="\t",quote=F)
