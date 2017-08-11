#Load libraries for pielou calculation
library(OTUtable)
library(plyr); library(dplyr)
library(reshape)
library(data.table)
library(ggfortify)
library(vegan)
library(labdsv)
memory.size(max = TRUE)

#Read in virome information table - produced by createvirome script
setwd("~/MastersDegree/Thesis/R/RScripts/viromeInfo/")
virTable <- read.table("viromeInfo.tsv",header=T,sep="\t",quote="")

#Read viral tax list - downloaded from NCBI taxonomy
virTax <- read.table("virTax.txt", header = T)
colnames(virTax) <- "TaxID"

#Read frequency table(s) and remove unneeded values
#Stores unique tax values
#Removes lineage
read.data <- function(file){
  dat <- read.table(file,header=T,sep="\t")
  dat$fname <- file
  return(dat)
}
setwd("~/MastersDegree/Thesis/R/RScripts/viromeFiles/")
dataset <- do.call(bind_rows, lapply(list.files(pattern="tsv$"),read.data))
taxVec <- unique(dataset$TaxID)
dataset$Lineage <- NULL

# split based on filename, uses vector of unique filenames
# set taxIDs as rownames & filenames as rownames
# merge all dataframes based on taxIDs
df <- split(dataset, dataset$fname)
for (i in 1:length(df)) {
  df[i] <- lapply(df[i], setNames, nm = c("TaxID", names(df)[i], "fname"))
}
df <- lapply(df, function(x) { x["fname"] <- NULL; x })
func <- function(x,y){merge(x, y, by.x=names(x)[1], by.y=names(y)[1])}
df <- lapply(df, func, virTax)
testdf <- do.call("bind_rows", df)
newdf <- matrix(data = 0, nrow = length(unique(testdf$TaxID)), ncol = length(testdf) - 1 )
rownames(newdf) <- as.character(unique(testdf$TaxID))
colnames(newdf) <- colnames(testdf)[2:length(testdf)]
newdf <- as.data.frame(newdf)

for (i in unique(testdf$TaxID)){
  tempdf <- transpose(as.data.frame(colSums(testdf[which(testdf[,1] == i),2:length(testdf)], na.rm = TRUE)))
  colnames(tempdf) <- colnames(testdf)[2:length(testdf)]
  newdf[as.character(i),] <- tempdf
}

#transpose and rename column names
colnames(newdf) = gsub(".tsv", "", colnames(newdf))
newdfpca <- t(newdf)
pr_comp <- prcomp(newdfpca, scale = F)
autoplot(pr_comp, label = T, label.size = 3, shape = FALSE, colour = 'blue')

#PCA plot
dffinal <- newdfpca[c(1,2,3,4,5,6,7,8,9,10,12,13,14,15,16),]
pr_comp <- prcomp(dffinal, scale = F)
autoplot(pr_comp, label = T, label.size = 3, shape = FALSE, 
         colour = 'blue',  loadings = TRUE,  loadings.label = TRUE, 
         loadings.label.size = 3)

