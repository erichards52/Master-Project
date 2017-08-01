library(OTUtable)
setwd("/home4/rich01e/ncbi/public/outputDir/")
#setwd("/home4/rich01e/ncbi/public/outputDir")
#Gets the file name based on suffix given

#Reads in the kaiju output
CountTabKaiju <- read.table("OTUTable.tsv", header = T, sep="\t", quote = "",fill=T)

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
kaijuVirusTot <- read.table("kaijuVir.txt",header=FALSE,sep=",")
colnames(kaijuVirusTot) <- c("Lineage","TaxID")
kaijuVirusTot <- merge(kaijuVirusTot, CountTabKaiju, by = "TaxID")
kaijuVirusTot <- unique(subset(kaijuVirusTot, grepl(paste(virusFilter,collapse="|"),
                                                    kaijuVirusTot[[2]]),drop=FALSE))
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
cat(c(",",as.character(noTax),",",as.character(totHits),",",as.character(kaijuPielou),",",as.character(TopTax),","
      ,as.character(TopTaxName),",",as.character(topTaxHits),",",as.character(kaijuVirusTotHits),",",topVirTaxKaiju,","
      ,as.character(topVirNameKaiju),",",as.character(topVirHitKaiju)))
