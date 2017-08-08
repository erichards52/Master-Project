library(OTUtable)
setwd("/home4/rich01e/ncbi/public/outputDir/")
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
write.table(CountTabKaiju, file = 'OTUTable.tsv', quote=FALSE, row.names=FALSE,sep="\t")

#Retrieves number of TaxIDs, top TaxID & Top tax ID species
noTax <- length(CountTabKaiju$TaxID)
TopTax <- CountTabKaiju[1,1]
TopTaxName <- CountTabKaiju[1,2]
topTaxHits <- CountTabKaiju[1,3]
totHits <- sum(CountTabKaiju$Freq)
kaijuPielou <- pielou(CountTabKaiju$Freq)

#virus filter
virusFilter <- c("Viruses", "Phages")

#Read domain table and retrieve only those with virus/phage lineage
files <- list.files(pattern="\\.domainnamescut.out$")
kaijuVirusTot <- read.table(files, 
                            header = FALSE, sep="\t", quote = "", fill = TRUE)
colnames(kaijuVirusTot) <- c("TaxID","Lineage")
kaijuVirusTot <- merge(kaijuVirusTot, CountTabKaiju, by = "TaxID")
kaijuVirusTot <- unique(subset(kaijuVirusTot, grepl(paste(virusFilter,collapse="|"),
                                                    kaijuVirusTot[[2]]),drop=FALSE))
totVirTax <- nrow(kaijuVirusTot)
kaijuVirusTotHits <- sum(kaijuVirusTot$Freq)
tempVirKaiju <- kaijuVirusTot[order(-kaijuVirusTot$Freq),]
topVirTaxKaiju <- tempVirKaiju[1,1]
topVirNameKaiju <- tempVirKaiju[1,3]
topVirHitKaiju <- tempVirKaiju[1,4]

is.num <- sapply(kaijuPielou, is.numeric)
kaijuPielou[is.num] <- lapply(kaijuPielou[is.num], round, 2)
kaijuPielou <- kaijuPielou[[1]]

#Print desired output
#print("Total TaxIDs,Total Hits,Pielou's Evenness,Top TaxID,Top TaxID Name,Top TaxID Kmer Hits,Total Viral Hits,Top Viral TaxID, Top Viral TaxID Name, Top Viral TaxID Hits")
cat(c("\t",as.character(noTax),"\t",as.character(totHits),"\t",as.character(kaijuPielou),"\t",as.character(TopTax),"\t"
      ,as.character(TopTaxName),"\t",as.character(topTaxHits),"\t",as.character(totVirTax),"\t",as.character(kaijuVirusTotHits),"\t",topVirTaxKaiju,"\t"
      ,as.character(topVirNameKaiju),"\t",as.character(topVirHitKaiju)))
