#Load libraries for pielou calculation
library(OTUtable)
library(plyr); library(dplyr)
library(reshape)
library(data.table)
library(ggfortify)
library(cluster)
library(gtools)
memory.size(max = TRUE)

#Read in virome information table - produced by createvirome script
setwd("~/MastersDegree/Thesis/R/RScripts/viromeInfo/")
virTable <- read.table("viromeInfo.tsv",header=T,sep="\t",quote="")

#Read viral tax list - downloaded from NCBI taxonomy
virTax <- read.table("virTax.txt", header = T)
colnames(virTax) <- "TaxID"

#Read frequency table(s) into dataset (list) and remove unneeded values
#Removes lineage for consistency
read.data <- function(file){
  dat <- read.table(file,header=T,sep="\t")
  dat$fname <- file
  return(dat)
}
setwd("~/MastersDegree/Thesis/R/RScripts/viromeFiles/")
dataset <- do.call(bind_rows, lapply(list.files(pattern="tsv$"),read.data))
dataset$Lineage <- NULL

# split based on filename by assigning a column name of filename values to each dataframe in the list
# merge all dataframes into new dataframe
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

# rename column names
colnames(newdf) = gsub(".tsv", "", colnames(newdf))
tester <- newdf

#remove NAs
tester[tester == 0] <- NA
f1 <- function(vec) { 
  m <- mean(vec, na.rm = TRUE) 
  vec[is.na(vec)] <- m 
  return(vec) 
} 

#Perform log scale
tester <- apply(tester,2,f1)
tester <- log(tester)
tester <- as.data.frame(tester)

#PCA plot - 2 types: pam or fanny
viewer <- t(tester)
viewer1 <- data.frame(t(na.omit(t(viewer))))
autoplot(pam(viewer1, 3), frame = TRUE, frame.type = 'norm')
autoplot(fanny(viewer1, 3), frame = TRUE)
