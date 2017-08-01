library(OTUtable)
setwd("/home4/rich01e/ncbi/public/outputDir")
#Gets the file name based on suffix given
files <- list.files(pattern="\\.namescut.out$")

#Reads in the kaiju output
kaijuCut <- read.table(files, header = FALSE, sep="\t", quote = "", fill = TRUE)

#Creates OTU table
MergeTab <- unique(kaijuCut)
colnames(MergeTab) <- c("TaxID", "Lineage")
kaijuTaxVec <- as.data.frame(table(kaijuCut$V1))
colnames(kaijuTaxVec) <- c("TaxID", "Freq")
CountTabKaiju <- merge(MergeTab, kaijuTaxVec, by.x = "TaxID", by.y = "TaxID")
CountTabKaiju <- CountTabKaiju[order(-CountTabKaiju$Freq),]

#Write out table for virus domain check
write.table(CountTabKaiju$TaxID, file='KaijuTax.tsv',row.names = F, col.names = F, sep = "\r\n")


write.table(CountTabKaiju, file = 'OTUTable.tsv', quote=FALSE, row.names=FALSE,sep="\t")