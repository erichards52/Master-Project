#Libraries
library(asbio)
library(vegan)
library(OTUtable)
x <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/CLARK/Abundanc&Speeds/"
y <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/Kaiju/Abundances&Speed/"
z <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/Kraken/Abundance&Speeds/"
xx <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/"

#Build Respective Sample Tables & Read in their respective files from each Classifier
#------------------------------------------------------------
#HomoResp
HomoResp <- data.frame(matrix(nrow = 5, ncol = 3))
colnames(HomoResp) <- c("Kaiju", "CLARK", "Kraken")
rownames(HomoResp) <- c("Total Hits", "Total TaxIDS", "Time(s)", "Pielou Evenness Index", "Total # Viral")

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
TravChik <- data.frame(matrix(nrow = 5, ncol = 3))
colnames(TravChik) <- c("Kaiju", "CLARK", "Kraken")
rownames(TravChik) <- c("Total Hits", "Total TaxIDS", "Time(s)", "Pielou Evenness Index", "Total # Viral")

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
MidgeNov <- data.frame(matrix(nrow = 5, ncol = 3))
colnames(MidgeNov) <- c("Kaiju", "CLARK", "Kraken")
rownames(MidgeNov) <- c("Total Hits", "Total TaxIDS", "Time(s)", "Pielou Evenness Index", "Total # Viral")

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
SRR062462 <- data.frame(matrix(nrow = 5, ncol = 3))
colnames(SRR062462) <- c("Kaiju", "CLARK", "Kraken")
rownames(SRR062462) <- c("Total Hits", "Total TaxIDS", "Time(s)", "Pielou Evenness Index", "Total # Viral")

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
SRR062415 <- data.frame(matrix(nrow = 5, ncol = 3))
colnames(SRR062415) <- c("Kaiju", "CLARK", "Kraken")
rownames(SRR062415) <- c("Total Hits", "Total TaxIDS", "Time(s)", "Pielou Evenness Index", "Total # Viral")

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
noRowsSRR062415Clark <- nrow(SRR062415Abund)
TempSRR062415Clark <- SRR062415Abund[-c(noRowsSRR062415Clark),]
totTaxIdSRR062415Clark <- nrow(TempSRR062415Clark)
TotHitsSRR062415Clark <- sum(TempSRR062415Clark$Count)
SRR062415[1,2] <- TotHitsSRR062415Clark
SRR062415[2,2] <- totTaxIdSRR062415Clark

#SRR062462
noRowsSRR062462Clark <- nrow(SRR062462Abund)
TempSRR062462Clark <- SRR062462Abund[-c(noRowsSRR062462Clark)]
totTaxIdSRR062462Clark <- nrow(TempSRR062462Clark)
TotHitsSRR062462Clark <- sum(TempSRR062462Clark$Count)
SRR062462[1,2] <- TotHitsSRR062462Clark
SRR062462[2,2] <- totTaxIdSRR062462Clark

#TravChik 
noRowsTravChikClark <- nrow(TravChikAbund)
TempTravClark <- TravChikAbund[-c(noRowsTravChikClark)]
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

#noTaxIds
totTaxIDKaijuHomo <- nrow(TempHomoKaiju)
totTaxIDKaijuMidge <- nrow(TempMidgeKaiju)
totTaxIDKaijuTrav <- nrow(TempTravKaiju)
totTaxIDKaijuSRR062415 <- nrow(TempSRR062415Kaiju)
totTaxIDKaijuSRR062462 <- nrow(TempSRR062462Kaiju)

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

#Calculate Kaiju pielou & assign values to respective sample tables

#HomoResp
HomoRespKaijuVec <- TempHomoKaiju$Reads
HomoRespKaijuPielou <- pielou(HomoRespKaijuVec)
HomoResp[4,1] <- HomoRespKaijuPielou

#MidgeNov
MidgeNovKaijuVec <- TempMidgeKaiju$Reads
MidgeNovKaijuPielou <- pielou(MidgeNovKaijuVec)
MidgeNov[4,1] <- MidgeNovKaijuPielou

#TravChik
TravChikKaijuVec <- TempTravKaiju$Reads
TravChikKaijuPielou <- pielou(TravChikKaijuVec)
TravChik[4,1] <- TravChikKaijuPielou

#SRR062415
SRR062415KaijuVec <- TempSRR062415Kaiju$Reads
SRR062415KaijuPielou <- pielou(SRR062415KaijuVec)
SRR062415[4,1] <- SRR062415KaijuPielou

#SRR062462
SRR062462KaijuVec <- TempSRR062462Kaiju$Reads
SRR062462KaijuPielou <- pielou(SRR062462KaijuVec)
SRR062462[4,1] <- SRR062462KaijuPielou
#-------------------------------------

#Retrieve total number of virus hits for Kaiju
#HomoResp
kaijuVirusTotHomo <- kaijuSummaryHomo[grep("Viruses", kaijuSummaryHomo$Species),]
kaijuVirusTotHomo <- kaijuVirusTotHomo$Reads
HomoResp[5,1] <- kaijuVirusTotHomo

#MidgeNov
kaijuVirusTotMidge <- kaijuSummaryMidge[grep("Viruses", kaijuSummaryMidge$Species),]
kaijuVirusTotMidge <- kaijuVirusTotMidge$Reads
MidgeNov[5,1] <- kaijuVirusTotMidge

#TravChik
kaijuVirusTotTrav <- kaijuSummaryTrav[grep("Viruses", kaijuSummaryTrav$Species),]
kaijuVirusTotTrav <- kaijuVirusTotTrav$Reads
TravChik[5,1] <- kaijuVirusTotTrav

#SRR062462
kaijuVirusTotSRR062462 <- kaijuSummarySRR062462[grep("Viruses", kaijuSummarySRR062462$Species),]
kaijuVirusTotSRR062462 <- kaijuVirusTotSRR062462$Reads
SRR062462[5,1] <- kaijuVirusTotSRR062462

#SRR062415
kaijuVirusTotSRR062415 <- kaijuSummarySRR062415[grep("Viruses", kaijuSummarySRR062415$Species),]
kaijuVirusTotSRR062415 <- kaijuVirusTotSRR062415$Reads
SRR062415[5,1] <- kaijuVirusTotSRR062415

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

#Calculate richness 
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

#Kraken Pielou
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

#Subset & Sum
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

#Perform last curation(s)
#Limit to 2 decimal places
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

#Write out benchmark tables
write.table(HomoResp, file='HomoRespBenchmark.tsv', quote=FALSE, sep='\t')
write.table(MidgeNov, file='MidgeNovBenchmark.tsv', quote=FALSE, sep='\t')
write.table(TravChik, file='TravChikBenchmark.tsv', quote=FALSE, sep='\t')
write.table(SRR062415, file='SRR062415Benchmark.tsv', quote=FALSE, sep='\t')
write.table(SRR062462, file='SRR062462Benchmark.tsv', quote=FALSE, sep='\t')

