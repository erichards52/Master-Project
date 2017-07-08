#Libraries
library(asbio)
library(vegan)
library(OTUtable)
x <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/CLARK/Abundanc&Speeds/"
y <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/Kaiju/Abundances&Speed/"
#Build Respective Sample Tables & Read in their respective files from each Classifier
#------------------------------------------------------------
#HomoResp
HomoResp <- data.frame(matrix(nrow = 4, ncol = 3))
colnames(HomoResp) <- c("Kaiju", "CLARK", "Kraken")
rownames(HomoResp) <- c("Richness (Total Hits/Total no. of TaxIDs", "Time(s)", "Pielou Evenness Index", "Total # Viral")

#Read abundance table from CLARK
setwd(x)
HomoRespAbund<-read.csv("abundResultshomoResp.csv",header=TRUE, sep=",", 
                        quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kaiju (richness & evenness)
setwd(y)
HomoRespAbundKaiju <- read.csv("kaijuKronaHomoResp.out.krona", header=FALSE,sep="\n",
                               quote = "", na.strings = c("", "NA", "n/a", ""))

#------------------------------------------------------------
#TravChik
TravChik <- data.frame(matrix(nrow = 4, ncol = 3))
colnames(TravChik) <- c("Kaiju", "CLARK", "Kraken")
rownames(TravChik) <- c("Richness (Total Hits/Total no. of TaxIDs", "Time(s)", "Pielou Evenness Index", "Total # Viral")

#Read abundance table from CLARK
setwd(x)
TravChikAbund<-read.csv("abundResultstravChik.csv",header=TRUE, sep=",", 
                        quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kaiju (richness & evenness)
setwd(y)
TravChikAbundKaiju <- read.csv("kaijuKronaTravChik.out.krona", header=TRUE,sep="\n",
                               quote = "", na.strings = c("", "NA", "n/a"))

#------------------------------------------------------------
#MidgeNov
MidgeNov <- data.frame(matrix(nrow = 4, ncol = 3))
colnames(MidgeNov) <- c("Kaiju", "CLARK", "Kraken")
rownames(MidgeNov) <- c("Richness (Total Hits/Total no. of TaxIDs", "Time(s)", "Pielou Evenness Index", "Total # Viral")

#Read abundance table from CLARK
setwd(x)
MidgeNovAbund<-read.csv("abundResultsmidgeNov.csv",header=TRUE, sep=",", 
                        quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kaiju (richness & evenness)
setwd(y)
MidgeNovAbundKaiju <- read.csv("kaijuKronaMidgeNov.out.krona", header=TRUE,sep="\n",
                               quote = "", na.strings = c("", "NA", "n/a"))

#------------------------------------------------------------
#SRR062462
SRR062462 <- data.frame(matrix(nrow = 4, ncol = 3))
colnames(SRR062462) <- c("Kaiju", "CLARK", "Kraken")
rownames(SRR062462) <- c("Richness (Total Hits/Total no. of TaxIDs", "Time(s)", "Pielou Evenness Index", "Total # Viral")

#Read abundance table from CLARK
setwd(x)
SRR062462Abund<-read.csv("abundResultsSaliva62462.csv",header=TRUE, sep=",", 
                        quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kaiju (richness & evenness)
setwd(y)
SRR062462AbundKaiju <- read.csv("kaijuKronaSRR062462.out.krona", header=TRUE,sep="\n",
                               quote = "", na.strings = c("", "NA", "n/a"))

#------------------------------------------------------------
#SRR062415
SRR062415 <- data.frame(matrix(nrow = 4, ncol = 3))
colnames(SRR062415) <- c("Kaiju", "CLARK", "Kraken")
rownames(SRR062415) <- c("Richness (Total Hits/Total no. of TaxIDs", "Time(s)", "Pielou Evenness Index", "Total # Viral")

#Read abundance table from CLARK
setwd(x)
SRR062415Abund<-read.csv("abundResultsSaliva62415.csv",header=TRUE, sep=",", 
                         quote = "", na.strings = c("", "NA", "n/a"))

#Read abundance table from Kaiju (richness & evenness)
setwd(y)
SRR062415AbundKaiju <- read.csv("kaijuKronaSRR062415.out.krona", header=TRUE,sep="\n",
                                quote = "", na.strings = c("", "NA", "n/a"))

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
HomoResp[2,2] <- clarkHomoRespSpeed
MidgeNov[2,2] <- clarkMidgeNovSpeed
TravChik[2,2] <- clarkTravChikSpeed
SRR062415[2,2] <- clarkSRR062415Speed
SRR062462[2,2] <- clarkSRR062462Speed

#----------------------------------------------------

#Calculate CLARK richness for each sample & assign values to tables respectively
#HomoResp
TotHitsHomoRespClark <- sum(HomoRespAbund$Count)
HomoRespRichClark <- TotHitsHomoRespClark/(nrow(HomoRespAbund)-1)
HomoResp[1,2] <- HomoRespRichClark

#MidgeNov
TotHitsMidgeNovClark <- sum(MidgeNovAbund$Count)
MidgeNovRichClark <- TotHitsMidgeNovClark/(nrow(MidgeNovAbund)-1)
MidgeNov[1,2] <- MidgeNovRichClark

#SRR062415
TotHitsSRR062415Clark <- sum(SRR062415Abund$Count)
SRR062415RichClark <- TotHitsSRR062415Clark/(nrow(SRR062415Abund)-1)
SRR062415[1,2] <- SRR062415RichClark

#SRR062462
TotHitsSRR062462Clark <- sum(SRR062462Abund$Count)
SRR062462RichClark <- TotHitsSRR062462Clark/(nrow(SRR062462Abund)-1)
SRR062462[1,2] <- SRR062462RichClark

#TravChik 
TotHitsTravChikClark <- sum(TravChikAbund$Count)
TravChikRichClark <- TotHitsTravChikClark/(nrow(TravChikAbund)-1)
TravChik[1,2] <- TravChikRichClark

#----------------------------------------------------

#Calculate CLARK Pielou Evenness
#HomoResp
HomoRespVec <- HomoRespAbund$Count
HomoRespPielou <- pielou(HomoRespVec)
HomoResp[3,2] <- HomoRespPielou

#MidgeNov
MidgeNovVec <- MidgeNovAbund$Count
MidgeNovPielou <- pielou(MidgeNovVec)
MidgeNov[3,2] <- MidgeNovPielou

#TravChik
TravChikVec <- TravChikAbund$Count
TravChikPielou <- pielou(TravChikVec)
TravChik[3,2] <- TravChikPielou

#SRR062415
SRR062415Vec <- SRR062415Abund$Count
SRR062415Pielou <- pielou(SRR062415Vec)
SRR062415[3,2] <- SRR062415Pielou

#SRR062462
SRR062462Vec <- SRR062462Abund$Count
SRR062462Pielou <- pielou(SRR062462Vec)
SRR062462[3,2] <- SRR062462Pielou

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
HomoResp[2,1] <- kaijuHomoRespSpeed
MidgeNov[2,1] <- kaijuMidgeNovSpeed
TravChik[2,1] <- kaijuTravChikSpeed
SRR062415[2,1] <- kaijuSRR062415Speed
SRR062462[2,1] <- kaijuSRR062462Speed

#--------------------------------------------------------

#Calculate richness for Kaiju
#Calculate total number of TaxIDs
TotTaxHomoKaiju <- nrow(HomoRespAbundKaiju)
TotTaxMidgeKaiju <- nrow(MidgeNovAbundKaiju)
TotTaxTravKaiju <- nrow(TravChikAbundKaiju)
TotTaxSRR062462Kaiju <- nrow(SRR062462AbundKaiju)
TotTaxSRR062415Kaiju <- nrow(SRR062415AbundKaiju)

#Read in summaries in order to retrieve counts
kaijuSumHomo <- read.table("HomoResp.out.summary", header = TRUE, sep="\t", quote = "")
kaijuSumMidge <- read.table("MidgeNov.out.summary", header = TRUE, sep="\t", quote = "")
kaijuSumTrav <- read.table("TravChik.out.summary", header = TRUE, sep="\t", quote = "")
kaijuSumSRR062462 <- read.table("SRR062462.out.summary", header = TRUE, sep="\t", quote = "")
kaijuSumSRR062415 <- read.table("SRR062415.out.summary", header = TRUE, sep="\t", quote = "")

#Extract count sums
kaijuHomoCountSum <- sum(kaijuSumHomo$Reads)
kaijuMidgeCountSum <- sum(kaijuSumMidge$Reads)
kaijuTravCountSum <- sum(kaijuSumTrav$Reads)
kaijuSRR062462CountSum <- sum(kaijuSumSRR062462$Reads)
kaijuSRR062415CountSum <- sum(kaijuSumSRR062415$Reads)

#Calculate richness
KaijuHomoRich <- kaijuHomoCountSum/TotTaxHomoKaiju
KaijuMidgeRich <- kaijuMidgeCountSum/TotTaxMidgeKaiju
KaijuTravRich <- kaijuTravCountSum/TotTaxTravKaiju
KaijuSRR062462Rich <- kaijuSRR062462CountSum/TotTaxSRR062462Kaiju
kaijuSRR062415Rich <- kaijuSRR062415CountSum/TotTaxSRR062415Kaiju

#Assign values to benchmark table
HomoResp[1,1] <- KaijuHomoRich
TravChik[1,1] <- KaijuTravRich
MidgeNov[1,1] <- KaijuMidgeRich
SRR062415[1,1] <- kaijuSRR062415Rich
SRR062462[1,1] <- KaijuSRR062462Rich

#--------------------------------------------------------

#Calculate Kaiju pielou & assign values to respective sample tables
#HomoResp
HomoRespKaijuVec <- kaijuSumHomo$Reads
HomoRespKaijuPielou <- pielou(HomoRespKaijuVec)
HomoResp[3,1] <- HomoRespKaijuPielou

#MidgeNov
MidgeNovKaijuVec <- kaijuSumMidge$Reads
MidgeNovKaijuPielou <- pielou(MidgeNovKaijuVec)
MidgeNov[3,1] <- MidgeNovKaijuPielou

#TravChik
TravChikKaijuVec <- kaijuSumTrav$Reads
TravChikKaijuPielou <- pielou(TravChikKaijuVec)
TravChik[3,1] <- TravChikKaijuPielou

#SRR062415
SRR062415KaijuVec <- kaijuSumSRR062415$Reads
SRR062415KaijuPielou <- pielou(SRR062415KaijuVec)
SRR062415[3,1] <- SRR062415KaijuPielou

#SRR062462
SRR062462KaijuVec <- kaijuSumSRR062462$Reads
SRR062462KaijuPielou <- pielou(SRR062462KaijuVec)
SRR062462[3,1] <- SRR062462KaijuPielou
#-------------------------------------

#Retrieve total number of virus hits for Kaiju
#HomoResp
kaijuVirusTotHomo <- kaijuSumHomo[grep("Viruses", kaijuSumHomo$Species),]
kaijuVirusTotHomo <- kaijuVirusTot$Reads
HomoResp[4,1] <- kaijuVirusTotHomo

#MidgeNov
kaijuVirusTotMidge <- kaijuSumMidge[grep("Viruses", kaijuSumMidge$Species),]
kaijuVirusTotMidge <- kaijuVirusTotMidge$Reads
MidgeNov[4,1] <- kaijuVirusTotMidge

#TravChik
kaijuVirusTotTrav <- kaijuSumTrav[grep("Viruses", kaijuSumTrav$Species),]
kaijuVirusTotTrav <- kaijuVirusTotTrav$Reads
TravChik[4,1] <- kaijuVirusTotTrav

#SRR062462
kaijuVirusTotSRR062462 <- kaijuSumSRR062462[grep("Viruses", kaijuSumTrav$Species),]
kaijuVirusTotSRR062462 <- kaijuVirusTotSRR062462$Reads
SRR062462[4,1] <- kaijuVirusTotSRR062462

#SRR062415
kaijuVirusTotSRR062415 <- kaijuSumSRR062415[grep("Viruses", kaijuSumTrav$Species),]
kaijuVirusTotSRR062415 <- kaijuSumSRR062415$Reads
SRR062415[4,1] <- kaijuVirusTotSRR062415



#Perform last curation(s)
#Limit to 2 decimal places
#HomoResp
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


