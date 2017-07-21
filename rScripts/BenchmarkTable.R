#Libraries
library(asbio)
library(vegan)
library(OTUtable)
library(dplyr)
library(plyr)
memory.size(max=TRUE)
x <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/CLARK/Abundanc&Speeds/"
y <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/Kaiju/Abundances&Speed/"
z <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/Kraken/Abundance&Speeds/"
xx <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/"

#Build Respective Sample Tables & Read in their respective files from each Classifier
#------------------------------------------------------------
#HomoResp
HomoResp <- data.frame(matrix(nrow = 8, ncol = 3))
colnames(HomoResp) <- c("Kaiju", "CLARK", "Kraken")
rownames(HomoResp) <- c("Total Hits", "Total TaxIDS", "Time(s)", "Pielou Evenness Index", "Total # Viral",
                        "Top Viral TaxID", "Top Viral Name", "Top Viral Kmer Count")

#Read abundance table from CLARK
setwd(x)
HomoRespAbund<-read.csv("abundResultshomoResp.csv",header=TRUE, sep=",", 
                        quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kaiju (richness & evenness)
setwd(y)
HomoRespAbundKaiju <- read.csv("kaijuKronaHomoResp.out.krona", header=FALSE,sep="\n",
                               quote = "", na.strings = c("", "NA", "n/a", ""))

#Read abundance table from Kraken 
setwd(z)
HomoRespAbundKrak <- read.csv("BrackenHomoResp.txt", header=TRUE,sep="\t",
                              quote = "", na.strings = c("", "NA", "n/a", ""))

#------------------------------------------------------------
#TravChik
TravChik <- data.frame(matrix(nrow = 8, ncol = 3))
colnames(TravChik) <- c("Kaiju", "CLARK", "Kraken")
rownames(TravChik) <- c("Total Hits", "Total TaxIDS", "Time(s)", "Pielou Evenness Index", "Total # Viral", 
                        "Top Viral TaxID", "Top Viral Name", "Top Viral Kmer Count")

#Read abundance table from CLARK
setwd(x)
TravChikAbund<-read.csv("abundResultstravChik.csv",header=TRUE, sep=",", 
                        quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kaiju (richness & evenness)
setwd(y)
TravChikAbundKaiju <- read.csv("kaijuKronaTravChik.out.krona", header=TRUE,sep="\n",
                               quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kraken 
setwd(z)
TravChikAbundKrak <- read.csv("BrackenTravChik.txt", header=TRUE,sep="\t",
                              quote = "", na.strings = c("", "NA", "n/a", ""))

#------------------------------------------------------------
#MidgeNov
MidgeNov <- data.frame(matrix(nrow = 8, ncol = 3))
colnames(MidgeNov) <- c("Kaiju", "CLARK", "Kraken")
rownames(MidgeNov) <- c("Total Hits", "Total TaxIDS", "Time(s)", "Pielou Evenness Index", "Total # Viral",
                        "Top Viral TaxID", "Top Viral Name", "Top Viral Kmer Count")

#Read abundance table from CLARK
setwd(x)
MidgeNovAbund<-read.csv("abundResultsmidgeNov.csv",header=TRUE, sep=",", 
                        quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kaiju (richness & evenness)
setwd(y)
MidgeNovAbundKaiju <- read.csv("kaijuKronaMidgeNov.out.krona", header=TRUE,sep="\n",
                               quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kraken 
setwd(z)
MidgeNovAbundKrak <- read.csv("BrackenMidgeNov.txt", header=TRUE,sep="\t",
                              quote = "", na.strings = c("", "NA", "n/a", ""))

#------------------------------------------------------------
#SRR062462
SRR062462 <- data.frame(matrix(nrow = 8, ncol = 3))
colnames(SRR062462) <- c("Kaiju", "CLARK", "Kraken")
rownames(SRR062462) <- c("Total Hits", "Total TaxIDS", "Time(s)", "Pielou Evenness Index", "Total # Viral",
                         "Top Viral TaxID", "Top Viral Name", "Top Viral Kmer Count")

#Read abundance table from CLARK
setwd(x)
SRR062462Abund<-read.csv("abundResultsSaliva62462.csv",header=TRUE, sep=",", 
                        quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kaiju (richness & evenness)
setwd(y)
SRR062462AbundKaiju <- read.csv("kaijuKronaSRR062462.out.krona", header=TRUE,sep="\n",
                               quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kraken 
setwd(z)
SRR062462AbundKrak <- read.csv("BrackenSRR062462.txt", header=TRUE,sep="\t",
                              quote = "", na.strings = c("", "NA", "n/a", ""))

#------------------------------------------------------------
#SRR062415
SRR062415 <- data.frame(matrix(nrow = 8, ncol = 3))
colnames(SRR062415) <- c("Kaiju", "CLARK", "Kraken")
rownames(SRR062415) <- c("Total Hits", "Total TaxIDS", "Time(s)", "Pielou Evenness Index", "Total # Viral", 
                         "Top Viral TaxID", "Top Viral Name", "Top Viral Kmer Count")

#Read abundance table from CLARK
setwd(x)
SRR062415Abund<-read.csv("abundResultsSaliva62415.csv",header=TRUE, sep=",", 
                         quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kaiju (richness & evenness)
setwd(y)
SRR062415AbundKaiju <- read.csv("kaijuKronaSRR062415.out.krona", header=TRUE,sep="\n",
                                quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kraken 
setwd(z)
SRR062415AbundKrak <- read.csv("BrackenSRR062415.txt", header=TRUE,sep="\t",
                               quote = "", na.strings = c("", "NA", "n/a", ""))

#CLARK
#---------------------------------------------------------------------
#Read in CLARK speeds
setwd(x)
clarkSpeeds <- read.table("speeds.txt", header = TRUE, sep=",")
clarkHomoRespSpeed <- clarkSpeeds$HomoResp
clarkMidgeNovSpeed <- clarkSpeeds$midgeNov
clarkSRR062415Speed <- clarkSpeeds$SRR062415
clarkSRR062462Speed <- clarkSpeeds$SRR062462
clarkTravChikSpeed <- clarkSpeeds$TravChik

#Assign CLARK speed values to tables respectively
HomoResp[3,2] <- clarkHomoRespSpeed
MidgeNov[3,2] <- clarkMidgeNovSpeed
TravChik[3,2] <- clarkTravChikSpeed
SRR062415[3,2] <- clarkSRR062415Speed
SRR062462[3,2] <- clarkSRR062462Speed

#----------------------------------------------------

#Calculate CLARK richness for each sample & assign values to tables respectively (#Subset to remove unknowns and unclassifieds)
#HomoResp
noRowsHomoAbundClark <- nrow(HomoRespAbund)
TempHomoClark <- HomoRespAbund[-c(noRowsHomoAbundClark),]
totTaxIdHomoClark <- nrow(TempHomoClark)
TotHitsHomoRespClark <- sum(TempHomoClark$Count)
HomoResp[1,2] <- TotHitsHomoRespClark
HomoResp[2,2] <- totTaxIdHomoClark

#MidgeNov
noRowsMidgeAbundClark <- nrow(MidgeNovAbund)
TempMidgeClark <- MidgeNovAbund[-c(noRowsMidgeAbundClark),]
totTaxIdMidgeClark <- nrow(TempMidgeClark)
TotHitsMidgeNovClark <- sum(TempMidgeClark$Count)
MidgeNov[1,2] <- TotHitsMidgeNovClark
MidgeNov[2,2] <- totTaxIdMidgeClark

#SRR062415
noRowsSRR062415AbundClark <- nrow(SRR062415Abund)
TempSRR062415Clark <- SRR062415Abund[-c(noRowsSRR062415AbundClark),]
totTaxIdSRR062415Clark <- nrow(TempSRR062415Clark)
TotHitsSRR062415Clark <- sum(TempSRR062415Clark$Count)
SRR062415[1,2] <- TotHitsSRR062415Clark
SRR062415[2,2] <- totTaxIdSRR062415Clark

#SRR062462
noRowsSRR062462AbundClark <- nrow(SRR062462Abund)
TempSRR062462Clark <- SRR062462Abund[-c(noRowsSRR062462AbundClark),]
totTaxIdSRR062462Clark <- nrow(TempSRR062462Clark)
TotHitsSRR062462Clark <- sum(TempSRR062462Clark$Count)
SRR062462[1,2] <- TotHitsSRR062462Clark
SRR062462[2,2] <- totTaxIdSRR062462Clark

#TravChik 
noRowsTravChikAbundClark <- nrow(TravChikAbund)
TempTravClark <- TravChikAbund[-c(noRowsTravChikAbundClark)]
totTaxIdTravClark <- nrow(TempTravClark)
TotHitsTravChikClark <- sum(TempTravClark$Count)
TravChik[1,2] <- TotHitsTravChikClark
TravChik[2,2] <- totTaxIdTravClark

#----------------------------------------------------

#Calculate CLARK Pielou 
#HomoResp
HomoRespVec <- TempHomoClark$Count
HomoRespPielou <- pielou(HomoRespVec)
HomoResp[4,2] <- HomoRespPielou

#MidgeNov
MidgeNovVec <- TempMidgeClark$Count
MidgeNovPielou <- pielou(MidgeNovVec)
MidgeNov[4,2] <- MidgeNovPielou

#TravChik
TravChikVec <- TempTravClark$Count
TravChikPielou <- pielou(TravChikVec)
TravChik[4,2] <- TravChikPielou

#SRR062415
SRR062415Vec <- TempSRR062415Clark$Count
SRR062415Pielou <- pielou(SRR062415Vec)
SRR062415[4,2] <- SRR062415Pielou

#SRR062462
SRR062462Vec <- TempSRR062462Clark$Count
SRR062462Pielou <- pielou(SRR062462Vec)
SRR062462[4,2] <- SRR062462Pielou

#Retrieve no. of viral sequences for CLARK
#-------------------------------------------------------
#List of lineages related to viruses
virusFilter <- c('*.viral.*','*.viridae.*','*.virus.*','*.phage.*','*.satellite.*')

#Subset & Sum
#HomoResp
HomoClarkViral <- unique(subset(HomoRespAbund, grepl(paste(virusFilter, collapse = "|"), 
                                                     HomoRespAbund[[3]]), drop = FALSE))
TotClarkHomoVir <- sum(HomoClarkViral$Count)

#TravChik
TravClarkViral <- unique(subset(TravChikAbund, grepl(paste(virusFilter, collapse = "|"), 
                                                     TravChikAbund[[3]]), drop = FALSE))
TotClarkTravVir <- sum(TravClarkViral$Count)

#MidgeNov
MidgeClarkViral <- unique(subset(MidgeNovAbund, grepl(paste(virusFilter, collapse = "|"), 
                                                      MidgeNovAbund[[3]]), drop = FALSE))
TotClarkMidgeVir <- sum(MidgeClarkViral$Count)

#SRR062415
SRR062415ClarkViral <- unique(subset(SRR062415Abund, grepl(paste(virusFilter, collapse = "|"), 
                                                           SRR062415Abund[[3]]), drop = FALSE))
TotClarkSRR062415Vir <- sum(SRR062415ClarkViral$Count)

#SRR062462
SRR062462ClarkViral <- unique(subset(SRR062462Abund, grepl(paste(virusFilter, collapse = "|"), 
                                                           SRR062462Abund[[3]]), drop = FALSE))
TotClarkSRR062462Vir <- sum(SRR062462ClarkViral$Count)

#Assign total no. of viral sequences
HomoResp[5,2] <- TotClarkHomoVir
TravChik[5,2] <- TotClarkTravVir
MidgeNov[5,2] <- TotClarkMidgeVir
SRR062415[5,2] <- TotClarkSRR062415Vir
SRR062462[5,2] <- TotClarkSRR062462Vir

#Get top CLARK viral hit info
#---------------------------
#HomoResp
HomoClarkViral <- HomoClarkViral[order(-HomoClarkViral$Count),]
HomoClarkTopVirTax <- HomoClarkViral[1,2]
HomoClarkTopVirHits <- HomoClarkViral[1,4]
HomoClarkTopVirName <- HomoClarkViral[1,1]

#MidgeNov
MidgeClarkViral <- MidgeClarkViral[order(-MidgeClarkViral$Count),]
MidgeClarkTopVirTax <- MidgeClarkViral[1,2]
MidgeClarkTopVirHits <- MidgeClarkViral[1,4]
MidgeClarkTopVirName <- MidgeClarkViral[1,1]

#TravChik
TravClarkViral <- TravClarkViral[order(-TravClarkViral$Count),]
TravClarkTopVirTax <- TravClarkViral[1,2]
TravClarkTopVirHits <- TravClarkViral[1,4]
TravClarkTopVirName <- TravClarkViral[1,1]

#SRR062415
SRR062415ClarkViral <- SRR062415ClarkViral[order(-SRR062415ClarkViral$Count),]
SRR062415ClarkTopVirTax <- SRR062415ClarkViral[1,2]
SRR062415ClarkTopVirHits <- SRR062415ClarkViral[1,4]
SRR062415ClarkTopVirName <- SRR062415ClarkViral[1,1]

#SRR062462
SRR062462ClarkViral <- SRR062462ClarkViral[order(-SRR062462ClarkViral$Count),]
SRR062462ClarkTopVirTax <- SRR062462ClarkViral[1,2]
SRR062462ClarkTopVirHits <- SRR062462ClarkViral[1,4]
SRR062462ClarkTopVirName <- SRR062462ClarkViral[1,1]

#Kaiju
#--------------------------------------------------------
#Read in kaiju speeds
setwd(y)
kaijuSpeeds <- read.table("speeds.txt", header = TRUE, sep=",")
kaijuHomoRespSpeed <- kaijuSpeeds$HomoResp
kaijuMidgeNovSpeed <- kaijuSpeeds$MidgeNov
kaijuSRR062415Speed <- kaijuSpeeds$SRR062415
kaijuSRR062462Speed <- kaijuSpeeds$SRR062462
kaijuTravChikSpeed <- kaijuSpeeds$TravChik

#Assign speed values to tables respectively
HomoResp[3,1] <- kaijuHomoRespSpeed
MidgeNov[3,1] <- kaijuMidgeNovSpeed
TravChik[3,1] <- kaijuTravChikSpeed
SRR062415[3,1] <- kaijuSRR062415Speed
SRR062462[3,1] <- kaijuSRR062462Speed

#--------------------------------------------------------
#Kaiju assigned taxon ids & number of assigned taxon ids & number of hits
setwd(y)

#Calculate richness for Kaiju
#Calculate total number of TaxIDs
TotTaxHomoKaiju <- nrow(HomoRespAbundKaiju)
TotTaxMidgeKaiju <- nrow(MidgeNovAbundKaiju)
TotTaxTravKaiju <- nrow(TravChikAbundKaiju)
TotTaxSRR062462Kaiju <- nrow(SRR062462AbundKaiju)
TotTaxSRR062415Kaiju <- nrow(SRR062415AbundKaiju)

#Read in summaries in order to retrieve counts
kaijuSummaryHomo <- read.table("HomoResp.out.summary", header = TRUE, sep="\t", quote = "")
kaijuSummaryMidge <- read.table("MidgeNov.out.summary", header = TRUE, sep="\t", quote = "")
kaijuSummaryTrav <- read.table("TravChik.out.summary", header = TRUE, sep="\t", quote = "")
kaijuSummarySRR062462 <- read.table("SRR062462.out.summary", header = TRUE, sep="\t", quote = "")
kaijuSummarySRR062415 <- read.table("SRR062415.out.summary", header = TRUE, sep="\t", quote = "")

#Subset to remove unknowns and unclassifieds
noRowsHomoKaiju <- nrow(kaijuSummaryHomo)
noRowsMidgeKaiju <- nrow(kaijuSummaryMidge)
noRowsTravKaiju <- nrow(kaijuSummaryTrav)
noRowsSRR062462Kaiju <- nrow(kaijuSummarySRR062462)
noRowsSRR062415Kaiju <- nrow(kaijuSummarySRR062415)

TempHomoKaiju <- kaijuSummaryHomo[-c(noRowsHomoKaiju, noRowsHomoKaiju-1),]
TempMidgeKaiju <- kaijuSummaryMidge[-c(noRowsMidgeKaiju, noRowsMidgeKaiju-1),]
TempTravKaiju <- kaijuSummaryTrav[-c(noRowsTravKaiju, noRowsTravKaiju-1),]
TempSRR062415Kaiju <- kaijuSummarySRR062415[-c(noRowsSRR062415Kaiju, noRowsSRR062415Kaiju-1)]
TempSRR062462Kaiju <- kaijuSummarySRR062462[-c(noRowsSRR062462Kaiju, noRowsSRR062462Kaiju-1)]


#Extract count sums
kaijuHomoCountSum <- sum(TempHomoKaiju$Reads)
kaijuMidgeCountSum <- sum(TempMidgeKaiju$Reads)
kaijuTravCountSum <- sum(TempTravKaiju$Reads)
kaijuSRR062462CountSum <- sum(TempSRR062462Kaiju$Reads)
kaijuSRR062415CountSum <- sum(TempSRR062415Kaiju$Reads)

#Get TaxID Counts
TempHomoKaiju <- kaijuSummaryHomo[-c(noRowsHomoKaiju, noRowsHomoKaiju-1,noRowsHomoKaiju-2),]
TempMidgeKaiju <- kaijuSummaryMidge[-c(noRowsMidgeKaiju, noRowsMidgeKaiju-1,noRowsMidgeKaiju-2),]
TempTravKaiju <- kaijuSummaryTrav[-c(noRowsTravKaiju, noRowsTravKaiju-1,noRowsTravKaiju-2),]
TempSRR062415Kaiju <- kaijuSummarySRR062415[-c(noRowsSRR062415Kaiju, noRowsSRR062415Kaiju-1,noRowsSRR062415Kaiju-2)]
TempSRR062462Kaiju <- kaijuSummarySRR062462[-c(noRowsSRR062462Kaiju, noRowsSRR062462Kaiju-1,noRowsSRR062462Kaiju-2)]

#Read in cut table in order to standardize virus counts across all classifiers
kaijuCutHomo <- read.table("kaijuHomoRespCut.names.out", header = FALSE, sep="\t", quote = "")
kaijuCutMidge <- read.table("kaijuMidgeCut.names.out", header = FALSE, sep="\t", quote = "")
kaijuCutTrav <- read.table("kaijuTravCut.names.out", header = FALSE, sep="\t", quote = "")
kaijuCutSRR062462 <- read.table("kaijuSRR062462Cut.names.out", header = FALSE, sep="\t", quote = "", fill = TRUE)
kaijuCutSRR062415 <- read.table("kaijuSRR062415Cut.names.out", header = FALSE, sep="\t", quote = "", fill = TRUE)

#No. tax IDs
totTaxIDKaijuHomo <- length(unique(kaijuCutHomo$V1))
totTaxIDKaijuMidge <- length(unique(kaijuCutMidge$V1))
totTaxIDKaijuTrav <- length(unique(kaijuCutTrav$V1))
totTaxIDKaijuSRR062415 <- length(unique(kaijuCutSRR062415$V1))
totTaxIDKaijuSRR062462 <- length(unique(kaijuCutSRR062462$V1))

#Create counts table Kaiju - takes unique values from output and merges the lineage and counts by TAXID - ordered by freq
#HomoResp
homoMergeTab <- unique(kaijuCutHomo)
colnames(homoMergeTab) <- c("TaxID", "Lineage")
kaijuHomoTaxVec <- as.data.frame(table(kaijuCutHomo$V1))
colnames(kaijuHomoTaxVec) <- c("TaxID", "Freq")
homoCountTabKaiju <- merge(homoMergeTab, kaijuHomoTaxVec, by.x = "TaxID", by.y = "TaxID")
homoCountTabKaiju <- homoCountTabKaiju[order(-homoCountTabKaiju$Freq),]

#MidgeNov
midgeMergeTab <- unique(kaijuCutMidge)
colnames(midgeMergeTab) <- c("TaxID", "Lineage")
kaijuMidgeTaxVec <- as.data.frame(table(kaijuCutMidge$V1))
colnames(kaijuMidgeTaxVec) <- c("TaxID", "Freq")
midgeCountTabKaiju <- merge(midgeMergeTab, kaijuMidgeTaxVec, by.x = "TaxID", by.y = "TaxID")
midgeCountTabKaiju <- midgeCountTabKaiju[order(-midgeCountTabKaiju$Freq),]

#TravChik
travMergeTab <- unique(kaijuCutTrav)
colnames(travMergeTab) <- c("TaxID", "Lineage")
kaijuTravTaxVec <- as.data.frame(table(kaijuCutTrav$V1))
colnames(kaijuTravTaxVec) <- c("TaxID", "Freq")
travCountTabKaiju <- merge(travMergeTab, kaijuTravTaxVec, by.x = "TaxID", by.y = "TaxID")
travCountTabKaiju <- travCountTabKaiju[order(-travCountTabKaiju$Freq),]

#SRR062415
SRR062415MergeTab <- unique(kaijuCutSRR062415)
colnames(SRR062415MergeTab) <- c("TaxID", "Lineage")
kaijuSRR062415TaxVec <- as.data.frame(table(kaijuCutSRR062415$V1))
colnames(kaijuSRR062415TaxVec) <- c("TaxID", "Freq")
SRR062415CountTabKaiju <- merge(SRR062415MergeTab, kaijuSRR062415TaxVec, by.x = "TaxID", by.y = "TaxID")
SRR062415CountTabKaiju <- SRR062415CountTabKaiju[order(-SRR062415CountTabKaiju$Freq),]

#SRR062462
SRR062462MergeTab <- unique(kaijuCutSRR062462)
colnames(SRR062462MergeTab) <- c("TaxID", "Lineage")
kaijuSRR062462TaxVec <- as.data.frame(table(kaijuCutSRR062462$V1))
colnames(kaijuSRR062462TaxVec) <- c("TaxID", "Freq")
SRR062462CountTabKaiju <- merge(SRR062462MergeTab, kaijuSRR062462TaxVec, by.x = "TaxID", by.y = "TaxID")
SRR062462CountTabKaiju <- SRR062462CountTabKaiju[order(-SRR062462CountTabKaiju$Freq),]

#Assign values to benchmark table
#sum no.
HomoResp[1,1] <- kaijuHomoCountSum
TravChik[1,1] <- kaijuTravCountSum
MidgeNov[1,1] <- kaijuMidgeCountSum
SRR062415[1,1] <- kaijuSRR062415CountSum
SRR062462[1,1] <- kaijuSRR062462CountSum

#taxid no.
HomoResp[2,1] <- totTaxIDKaijuHomo
TravChik[2,1] <- totTaxIDKaijuTrav
MidgeNov[2,1] <- totTaxIDKaijuMidge
SRR062415[2,1] <- totTaxIDKaijuSRR062415
SRR062462[2,1] <- totTaxIDKaijuSRR062462


#--------------------------------------------------------

#Calculate Kaiju pielou & assign values to respective sample tables (utilises count vector without clumping)

#HomoResp
HomoRespKaijuVec <- homoCountTabKaiju$Freq
HomoRespKaijuPielou <- pielou(HomoRespKaijuVec)
HomoResp[4,1] <- HomoRespKaijuPielou

#MidgeNov
MidgeNovKaijuVec <- midgeCountTabKaiju$Freq
MidgeNovKaijuPielou <- pielou(MidgeNovKaijuVec)
MidgeNov[4,1] <- MidgeNovKaijuPielou

#TravChik
TravChikKaijuVec <- travCountTabKaiju$Freq
TravChikKaijuPielou <- pielou(TravChikKaijuVec)
TravChik[4,1] <- TravChikKaijuPielou

#SRR062415
SRR062415KaijuVec <- SRR062415CountTabKaiju$Freq
SRR062415KaijuPielou <- pielou(SRR062415KaijuVec)
SRR062415[4,1] <- SRR062415KaijuPielou

#SRR062462
SRR062462KaijuVec <- SRR062462CountTabKaiju$Freq
SRR062462KaijuPielou <- pielou(SRR062462KaijuVec)
SRR062462[4,1] <- SRR062462KaijuPielou
#-------------------------------------
#Retrieve total number of virus hits for Kaiju (based on virus filter)

virusFilter <- c('*.viral.*','*.viridae.*','*.virus.*','*.phage.*','*.satellite.*')

#HomoResp
kaijuVirusTotHomo <-  nrow(subset(kaijuCutHomo, grepl(paste(virusFilter, collapse = "|"), 
                                                             kaijuCutHomo[[2]]), drop = FALSE))
HomoResp[5,1] <- kaijuVirusTotHomo

#MidgeNov
kaijuVirusTotMidge <-  nrow(subset(kaijuCutMidge, grepl(paste(virusFilter, collapse = "|"), 
                                                   kaijuCutMidge[[2]]), drop = FALSE))
MidgeNov[5,1] <- kaijuVirusTotMidge

#TravChik
kaijuVirusTotTrav <- nrow(subset(kaijuCutTrav, grepl(paste(virusFilter, collapse = "|"), 
                                                kaijuCutTrav[[2]]), drop = FALSE))
TravChik[5,1] <- kaijuVirusTotTrav

#SRR062462
kaijuVirusTotSRR062462 <- nrow(subset(kaijuCutSRR062462, grepl(paste(virusFilter, collapse = "|"), 
                                                          kaijuCutSRR062462[[2]]), drop = FALSE))
SRR062462[5,1] <- kaijuVirusTotSRR062462

#SRR062415
kaijuVirusTotSRR062415 <- nrow(subset(kaijuCutSRR062415, grepl(paste(virusFilter, collapse = "|"), 
                                                          kaijuCutSRR062415[[2]]), drop = FALSE))
SRR062415[5,1] <- kaijuVirusTotSRR062415

#Return top virus hit for Kaiju
#-------------------
#HomoResp
#Subset based upon virus filter (lineage)
tempHomoVirKaiju <- subset(homoCountTabKaiju, grepl(paste(virusFilter, collapse = "|"), 
                                                    homoCountTabKaiju[[2]]), drop = FALSE)

#Select top row values (already ordered on count freq.) - This process is repeated
topHomoVirTaxKaiju <- tempHomoVirKaiju[1,1]
topHomoVirNameKaiju <- tempHomoVirKaiju[1,2]
topHomoVirHitKaiju <- tempHomoVirKaiju[1,3]

#MidgeNov
tempMidgeVirKaiju <- subset(midgeCountTabKaiju, grepl(paste(virusFilter, collapse = "|"), 
                                                      midgeCountTabKaiju[[2]]), drop = FALSE)

topMidgeVirTaxKaiju <- tempMidgeVirKaiju[1,1]
topMidgeVirNameKaiju <- tempMidgeVirKaiju[1,2]
topMidgeVirHitKaiju <- tempMidgeVirKaiju[1,3]

#TravChik
tempTravVirKaiju <- subset(travCountTabKaiju, grepl(paste(virusFilter, collapse = "|"), 
                                                    travCountTabKaiju[[2]]), drop = FALSE)

topTravVirTaxkaiju <- tempTravVirKaiju[1,1]
topTravVirNameKaiju <- tempTravVirKaiju[1,2]
topTravVirHitKaiju <- tempTravVirKaiju[1,3]

#SRR062415
tempSRR062415VirKaiju <- subset(SRR062415CountTabKaiju, grepl(paste(virusFilter, collapse = "|"), 
                                                              SRR062415CountTabKaiju[[2]]), drop = FALSE)

topSRR062415VirTaxKaiju <- tempSRR062415VirKaiju[1,1]
topSRR062415VirNameKaiju <- tempSRR062415VirKaiju[1,2]
topSRR062415VirHitKaiju <- tempSRR062415VirKaiju[1,3]

#SRR062462
tempSRR062462VirKaiju <- subset(SRR062462CountTabKaiju, grepl(paste(virusFilter, collapse = "|"), 
                                                              SRR062462CountTabKaiju[[2]]), drop = FALSE)

topSRR062462VirTaxKaiju <- tempSRR062462VirKaiju[1,1]
topSRR062462VirNameKaiju <- tempSRR062462VirKaiju[1,2]
topSRR062462VirHitKaiju <- tempSRR062462VirKaiju[1,3]

#Kraken
#------------------------------------------------------------------
#Read in Kraken speeds & assign values
setwd(z)
krakSpeeds <- read.table("speeds.txt", header = TRUE, sep=",")
krakHomoRespSpeed <- krakSpeeds$HomoResp
krakMidgeNovSpeed <- krakSpeeds$MidgeNov
krakSRR062415Speed <- krakSpeeds$SRR062415
krakSRR062462Speed <- krakSpeeds$SRR062462
krakTravChikSpeed <- krakSpeeds$TravChik

#Assign to respective sample tables
HomoResp[3,3] <- krakHomoRespSpeed
MidgeNov[3,3] <- krakMidgeNovSpeed
TravChik[3,3] <- krakTravChikSpeed
SRR062415[3,3] <- krakSRR062415Speed
SRR062462[3,3] <- krakSRR062462Speed

#Calculate richness (number of taxIDs & hits)
#HomoResp
TotTaxHomoKrak <- nrow(HomoRespAbundKrak)
HomoRichKrak <- sum(HomoRespAbundKrak$kraken_assigned_reads)
HomoResp[1,3] <- HomoRichKrak
HomoResp[2,3] <- TotTaxHomoKrak

#MidgeNov
TotTaxMidgeKrak <- nrow(MidgeNovAbundKrak)
MidgeRichKrak <- sum(MidgeNovAbundKrak$kraken_assigned_reads)
MidgeNov[1,3] <- MidgeRichKrak
MidgeNov[2,3] <- TotTaxMidgeKrak

#TravChik
TotTaxTravKrak <- nrow(TravChikAbundKrak)
TravRichKrak <- sum(TravChikAbundKrak$kraken_assigned_reads)
TravChik[1,3] <- TravRichKrak
TravChik[2,3] <- TotTaxTravKrak

#SRR062415
TotTaxSRR062415Krak <- nrow(SRR062415AbundKrak)
SRR062415RichKrak <- sum(SRR062415AbundKrak$kraken_assigned_reads)
SRR062415[1,3] <- SRR062415RichKrak
SRR062415[2,3] <- TotTaxSRR062415Krak

#SRR062462
TotTaxSRR062462Krak <- nrow(SRR062462AbundKrak)
SRR062462RichKrak <- sum(SRR062462AbundKrak$kraken_assigned_reads)
SRR062462[1,3] <- SRR062462RichKrak
SRR062462[2,3] <- TotTaxSRR062462Krak

#Kraken Pielou (takes vector of counts, removes unknowns and clumping)
#HomoResp
HomoKrakVec <- HomoRespAbundKrak$kraken_assigned_reads
HomoKrakPie <- pielou(HomoKrakVec)
HomoResp[4,3] <- HomoKrakPie

#MidgeNov
MidgeKrakVec <- MidgeNovAbundKrak$kraken_assigned_reads
MidgeKrakPie <- pielou(MidgeKrakVec)
MidgeNov[4,3] <- MidgeKrakPie

#TravChik
TravKrakVec <- TravChikAbundKrak$kraken_assigned_reads
TravKrakPie <- pielou(TravKrakVec)
TravChik[4,3] <- TravKrakPie

#SRR062415
SRR062415KrakVec <- SRR062415AbundKrak$kraken_assigned_reads
SRR062415Pie <- pielou(SRR062415KrakVec)
SRR062415[4,3] <- SRR062415Pie

#SRR062462
SRR062462KrakVec <- SRR062462AbundKrak$kraken_assigned_reads
SRR062462Pie <- pielou(SRR062462KrakVec)
SRR062462[4,3] <- SRR062462Pie

#Retrieve no. of viral sequences for Kraken
#-------------------------------------------------------
#List of lineages related to viruses
virusFilter <- c('*.viral.*','*.viridae.*','*.virus.*','*.phage.*','*.satellite.*')

#Subset & Sum hits
#HomoResp
HomoKrakViral <- unique(subset(HomoRespAbundKrak, grepl(paste(virusFilter, collapse = "|"), 
                                                     HomoRespAbundKrak[[1]]), drop = FALSE))
TotKrakHomoVir <- sum(HomoKrakViral$kraken_assigned_reads)

#TravChik
TravKrakViral <- unique(subset(TravChikAbundKrak, grepl(paste(virusFilter, collapse = "|"), 
                                                     TravChikAbundKrak[[1]]), drop = FALSE))
TotKrakTravVir <- sum(TravKrakViral$kraken_assigned_reads)

#MidgeNov
MidgeKrakViral <- unique(subset(MidgeNovAbundKrak, grepl(paste(virusFilter, collapse = "|"), 
                                                      MidgeNovAbundKrak[[1]]), drop = FALSE))
TotKrakMidgeVir <- sum(MidgeKrakViral$kraken_assigned_reads)

#SRR062415
SRR062415KrakViral <- unique(subset(SRR062415AbundKrak, grepl(paste(virusFilter, collapse = "|"), 
                                                           SRR062415AbundKrak[[1]]), drop = FALSE))
TotKrakSRR062415Vir <- sum(SRR062415KrakViral$kraken_assigned_reads)

#SRR062462
SRR062462KrakViral <- unique(subset(SRR062462AbundKrak, grepl(paste(virusFilter, collapse = "|"), 
                                                           SRR062462AbundKrak[[1]]), drop = FALSE))
TotKrakSRR062462Vir <- sum(SRR062462KrakViral$kraken_assigned_reads)

#Assign total no. of viral sequences
HomoResp[5,3] <- TotKrakHomoVir
TravChik[5,3] <- TotKrakTravVir
MidgeNov[5,3] <- TotKrakMidgeVir
SRR062415[5,3] <- TotKrakSRR062415Vir
SRR062462[5,3] <- TotKrakSRR062462Vir

#Return top viral hit info (Kraken) - orders earlier viral table by freq
#---------------------------
#HomoResp
HomoKrakViral <- HomoKrakViral[order(-HomoKrakViral$kraken_assigned_reads),]
HomoKrakTopVirTax <- HomoKrakViral[1,2]
HomoKrakTopVirHits <- HomoKrakViral[1,4]
HomoKrakTopVirName <- HomoKrakViral[1,1]

#MidgeNov
MidgeKrakViral <- MidgeKrakViral[order(-MidgeKrakViral$kraken_assigned_reads),]
MidgeKrakTopVirTax <- MidgeKrakViral[1,2]
MidgeKrakTopVirHits <- MidgeKrakViral[1,4]
MidgeKrakTopVirName <- MidgeKrakViral[1,1]

#TravChik
TravKrakViral <- TravKrakViral[order(-TravKrakViral$kraken_assigned_reads),]
TravKrakTopVirTax <- TravKrakViral[1,2]
TravKrakTopVirHits <- TravKrakViral[1,4]
TravKrakTopVirName <- TravKrakViral[1,1]

#SRR062415
SRR062415KrakViral <- SRR062415KrakViral[order(-SRR062415KrakViral$kraken_assigned_reads),]
SRR062415TopVirTax <- SRR062415KrakViral[1,2]
SRR062415TopVirHits <- SRR062415KrakViral[1,4]
SRR062415TopVirName <- SRR062415KrakViral[1,1]

#SRR062462
SRR062462KrakViral <- SRR062462KrakViral[order(-SRR062462KrakViral$kraken_assigned_reads),]
SRR062462TopVirTax <- SRR062462KrakViral[1,2]
SRR062462TopVirHits <- SRR062462KrakViral[1,4]
SRR062462TopVirName <- SRR062462KrakViral[1,1]


#Perform last curation(s)
#Limit to 2 decimal places for each value
#HomoResp
setwd(xx)
is.num <- sapply(HomoResp, is.numeric)
HomoResp[is.num] <- lapply(HomoResp[is.num], round, 2)

#MidgeNov
is.num <- sapply(MidgeNov, is.numeric)
MidgeNov[is.num] <- lapply(MidgeNov[is.num], round, 2)

#TravChik
is.num <- sapply(TravChik, is.numeric)
TravChik[is.num] <- lapply(TravChik[is.num], round, 2)

#SRR062415
is.num <- sapply(SRR062415, is.numeric)
SRR062415[is.num] <- lapply(SRR062415[is.num], round, 2)

#SRR062462
is.num <- sapply(SRR062462, is.numeric)
SRR062462[is.num] <- lapply(SRR062462[is.num], round, 2)

#------------------------
#Assign viral values to each table (MUST BE DONE LATER OR ROUNDING WILL NOT WORK)
#CLARK
#HomoResp
HomoResp[6,2] <- HomoClarkTopVirTax
HomoResp[7,2] <- as.character(HomoClarkTopVirName)
HomoResp[8,2] <- HomoClarkTopVirHits

#MidgeNov
MidgeNov[6,2] <- MidgeClarkTopVirTax
MidgeNov[7,2] <- as.character(MidgeClarkTopVirName)
MidgeNov[8,2] <- MidgeClarkTopVirHits

#TravChik
TravChik[6,2] <- TravClarkTopVirTax
TravChik[7,2] <- as.character(TravClarkTopVirName)
TravChik[8,2] <- TravClarkTopVirHits

#SRR062415
SRR062415[6,2] <- SRR062415ClarkTopVirTax
SRR062415[7,2] <- as.character(SRR062415ClarkTopVirName)
SRR062415[8,2] <- SRR062415ClarkTopVirHits

#SRR062462
SRR062462[6,2] <- SRR062462ClarkTopVirTax
SRR062462[7,2] <- as.character(SRR062462ClarkTopVirName)
SRR062462[8,2] <- SRR062462ClarkTopVirHits

#Assign values
#KRAKEN
#HomoResp
HomoResp[6,3] <- HomoKrakTopVirTax
HomoResp[7,3] <- as.character(HomoKrakTopVirName)
HomoResp[8,3] <- HomoKrakTopVirHits

#MidgeNov
MidgeNov[6,3] <- MidgeKrakTopVirTax
MidgeNov[7,3] <- as.character(MidgeKrakTopVirName)
MidgeNov[8,3] <- MidgeKrakTopVirHits

#TravChik
TravChik[6,3] <- TravKrakTopVirTax
TravChik[7,3] <- as.character(TravKrakTopVirName)
TravChik[8,3] <- TravKrakTopVirHits

#SRR062415
SRR062415[6,3] <- SRR062415TopVirTax
SRR062415[7,3] <- as.character(SRR062415TopVirName)
SRR062415[8,3] <- SRR062415TopVirHits

#SRR062462
SRR062462[6,3] <- SRR062462TopVirTax
SRR062462[7,3] <- as.character(SRR062462TopVirName)
SRR062462[8,3] <- SRR062462TopVirHits

#Assign values
#HomoResp
HomoResp[6,1] <- topHomoVirTaxKaiju
HomoResp[7,1] <- as.character(topHomoVirNameKaiju)
HomoResp[8,1] <- topHomoVirHitKaiju

#MidgeNov
MidgeNov[6,1] <- topMidgeVirTaxKaiju
MidgeNov[7,1] <- as.character(topMidgeVirNameKaiju)
MidgeNov[8,1] <- topMidgeVirHitKaiju

#TravChik
TravChik[6,1] <- topTravVirTaxkaiju
TravChik[7,1] <- as.character(topTravVirNameKaiju)
TravChik[8,1] <- topTravVirHitKaiju

#SRR062415
SRR062415[6,1] <- topSRR062415VirTaxKaiju
SRR062415[7,1] <- as.character(topSRR062415VirNameKaiju)
SRR062415[8,1] <- topSRR062415VirHitKaiju

#SRR062462
SRR062462[6,1] <- topSRR062462VirTaxKaiju
SRR062462[7,1] <- as.character(topSRR062462VirNameKaiju)
SRR062462[8,1] <- topSRR062462VirHitKaiju

#Write out benchmark tables
setwd(xx)
write.table(HomoResp, file='HomoRespBenchmark.tsv', quote=FALSE, sep="\t")
write.table(MidgeNov, file='MidgeNovBenchmark.tsv', quote=FALSE, sep="\t")
write.table(TravChik, file='TravChikBenchmark.tsv', quote=FALSE, sep="\t")
write.table(SRR062415, file='SRR062415Benchmark.tsv', quote=FALSE, sep="\t")
write.table(SRR062462, file='SRR062462Benchmark.tsv', quote=FALSE, sep="\t")

#Create TaxID tables - subset to remove unwanted columns, rename columns, and merge subsetted dfs with df containing all unique taxIDs
#HomoResp
TempHomoClark <- TempHomoClark[-c(1,3,5,6)]
colnames(TempHomoClark) <- c("TaxID", "CLARK")
TempHomoKaiju <- homoCountTabKaiju[-2]
colnames(TempHomoKaiju) <- c("TaxID", "Kaiju")
TempHomoKrak <- HomoRespAbundKrak[-c(1,3,5,6,7)]
colnames(TempHomoKrak) <- c("TaxID", "Kraken")

homoTaxTable <- Reduce(function(x, y) merge(x, y, all=TRUE), list(TempHomoClark, TempHomoKaiju, TempHomoKrak))

#MidgeNov
TempMidgeClark <- TempMidgeClark[-c(1,3,5,6)]
colnames(TempMidgeClark) <- c("TaxID", "CLARK")
TempMidgeKaiju <- midgeCountTabKaiju[-2]
colnames(TempMidgeKaiju) <- c("TaxID", "Kaiju")
TempMidgeKrak <- MidgeNovAbundKrak[-c(1,3,5,6,7)]
colnames(TempMidgeKrak) <- c("TaxID", "Kraken")

midgeTaxTable <- Reduce(function(x, y) merge(x, y, all=TRUE), list(TempMidgeClark, TempMidgeKaiju, TempMidgeKrak))


#TravChik
TempTravClark <- TempTravClark[-c(1,3,5,6)]
colnames(TempTravClark) <- c("TaxID", "CLARK")
TempTravKaiju <- travCountTabKaiju[-2]
colnames(TempTravKaiju) <- c("TaxID", "Kaiju")
TempTravKrak <- TravChikAbundKrak[-c(1,3,5,6,7)]
colnames(TempTravKrak) <- c("TaxID", "Kraken")

travTaxTable <- Reduce(function(x, y) merge(x, y, all=TRUE), list(TempTravClark, TempTravKaiju, TempTravKrak))


#SRR062415
TempSRR062415Clark <- TempSRR062415Clark[-c(1,3,5,6)]
colnames(TempSRR062415Clark) <- c("TaxID", "CLARK")
TempSRR062415Kaiju <- SRR062415CountTabKaiju[-2]
colnames(TempSRR062415Kaiju) <- c("TaxID", "Kaiju")
TempSRR062415Krak <- SRR062415AbundKrak[-c(1,3,5,6,7)]
colnames(TempSRR062415Krak) <- c("TaxID", "Kraken")

SRR062415TaxTable <- Reduce(function(x, y) merge(x, y, all=TRUE), list(TempSRR062415Clark, TempSRR062415Kaiju, TempSRR062415Krak))

#SRR062462
TempSRR062462Clark <- TempSRR062462Clark[-c(1,3,5,6)]
colnames(TempSRR062462Clark) <- c("TaxID", "CLARK")
TempSRR062462Kaiju <- SRR062462CountTabKaiju[-2]
colnames(TempSRR062462Kaiju) <- c("TaxID", "Kaiju")
TempSRR062462Krak <- SRR062462AbundKrak[-c(1,3,5,6,7)]
colnames(TempSRR062462Krak) <- c("TaxID", "Kraken")

SRR062462TaxTable <- Reduce(function(x, y) merge(x, y, all=TRUE), list(TempSRR062462Clark, TempSRR062462Kaiju, TempSRR062462Krak))

#Remove rownames
#Write out tax tables
write.table(homoTaxTable, file='HomoRespTaxTable.tsv', quote=FALSE, sep="\t", row.names = FALSE)
write.table(midgeTaxTable, file='MidgeNovTaxTable.tsv', quote=FALSE, sep="\t", row.names = FALSE)
write.table(travTaxTable, file='TravChikTaxTable.tsv', quote=FALSE, sep="\t", row.names = FALSE)
write.table(SRR062415TaxTable, file='SRR062415TaxTable.tsv', quote=FALSE, sep="\t", row.names = FALSE)
write.table(SRR062462TaxTable, file='SRR062462TaxTable.tsv', quote=FALSE, sep="\t", row.names = FALSE)
