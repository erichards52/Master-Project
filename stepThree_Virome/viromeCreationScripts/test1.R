#Load libraries for pielou calculation
library(OTUtable)
library(dplyr)


#Read in virome information table - produced by createvirome script
setwd("/home4/rich01e/GitProj/stepThree_Virome/")
virTable <- read.table("viromeInfo.tsv",header=T,sep="\t")

#Read viral tax list - downloaded from NCBI taxonomy
setwd("/home4/rich01e/GitProj/stepThree_Virome/outputStore")
virTax <- read.table("virTax.txt", header = T)
colnames(virTax) <- "TaxID"

#Read frequency table(s) and remove unneeded values
#Stores unique tax values
read.data <- function(file){
  dat <- read.table(file,header=T,sep="\t")
  dat$fname <- file
  return(dat)
}
dataset <- do.call(bind_rows, lapply(list.files(pattern="tsv$"),read.data))
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
for (i in 1:length(df)) {
  df[i] <- lapply(df[i], setNames, nm = c("TaxID", names(df)[i], "fname"))
}
df <- lapply(df, function(x) { x["fname"] <- NULL; x })
df <- lapply(df, function(x){ row.names(x)<- x$TaxID; x})
func <- function(x,y){merge(x, y, by.x=names(x)[1], by.y=names(y)[1])}
df <- lapply(df, func, virTax)
df <- lapply(df, function(x){ row.names(x)<- x$TaxID; x})
df <- lapply(df, function(x) { x["TaxID"] <- NULL; x })
output<-rbind(lapply(df, add_rownames))


write.table(output, "allDataVirMerge.tsv", col.names = T, row.names = T, sep="\t",quote=F)

