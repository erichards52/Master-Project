#Libraries
library(asbio)
library(vegan)
library(OTUtable)
library(dplyr)
library(plyr)
library(stringi)
library(VennDiagram)

#Create WDs & memory size
memory.size(max=TRUE)
x <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/CLARK/Abundanc&Speeds/"
y <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/Kaiju/Abundances&Speed/"
z <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/Kraken/Abundance&Speeds/"
xx <- "C:/Users/2274776r/Documents/MastersDegree/Thesis/Classifiers/"
yy <- "~/MastersDegree/Thesis/Classifiers/CLARK-S/Abundances&Speeds/"

#Build Respective Sample Tables & Read in their respective files from each Classifier
#------------------------------------------------------------
#HomoResp
HomoResp <- data.frame(matrix(nrow = 8, ncol = 4))
colnames(HomoResp) <- c("Kaiju", "CLARK", "Kraken", "CLARK-S")
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

#Read abundance table for CLARK-S
setwd(yy)
HomoRespAbundClarkS <- read.csv("abundResultshomoResp.csv",header=TRUE,sep=",",
                                quote="",na.strings=c("","NA","n/a"))
#------------------------------------------------------------
#TravChik
TravChik <- data.frame(matrix(nrow = 8, ncol = 4))
colnames(TravChik) <- c("Kaiju", "CLARK", "Kraken", "CLARK-S")
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

#Read abundance table for CLARK-S
setwd(yy)
TravChikAbundClarkS <- read.csv("abundResultstravChik.csv",header=TRUE,sep=",",
                                quote="",na.strings=c("","NA","n/a"))

#------------------------------------------------------------
#MidgeNov
MidgeNov <- data.frame(matrix(nrow = 8, ncol = 4))
colnames(MidgeNov) <- c("Kaiju", "CLARK", "Kraken", "CLARK-S")
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

#Read abundance table for CLARK-S
setwd(yy)
MidgeNovAbundClarkS <- read.csv("abundResultsmidgeNov.csv",header=TRUE,sep=",",
                                quote="",na.strings=c("","NA","n/a"))

#------------------------------------------------------------
#SRR062462
SRR062462 <- data.frame(matrix(nrow = 8, ncol = 4))
colnames(SRR062462) <- c("Kaiju", "CLARK", "Kraken", "CLARK-S")
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

#Read abundance table for CLARK-S
setwd(yy)
SRR062462AbundClarkS <- read.csv("abundResultsSaliva062462.csv",header=TRUE,sep=",",
                                quote="",na.strings=c("","NA","n/a"))

#------------------------------------------------------------
#SRR062415
SRR062415 <- data.frame(matrix(nrow = 8, ncol = 4))
colnames(SRR062415) <- c("Kaiju", "CLARK", "Kraken", "CLARK-S")
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

#Read abundance table for CLARK-S
setwd(yy)
SRR062415AbundClarkS <- read.csv("abundResultsSaliva062415.csv",header=TRUE,sep=",",
                                quote="",na.strings=c("","NA","n/a"))

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

#Calculate CLARK richness for each sample & assign values to tables respectively 
#Subset to remove unknowns and unclassifieds
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
TempTravClark <- TravChikAbund[-c(noRowsTravChikAbundClark),]
totTaxIdTravClark <- nrow(TempTravClark)
TotHitsTravChikClark <- sum(TempTravClark$Count)
TravChik[1,2] <- TotHitsTravChikClark
TravChik[2,2] <- totTaxIdTravClark

#----------------------------------------------------

#Calculate CLARK Pielou 
#Takes vector of kmer counts (doesn't unclude unclassified & unknowns)
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
#Creates file of taxIDs for each benchmarking dataset, the file is read through perl eutils script (taxScriptVir.pl) 
#returns the taxIDs with Virus division/Kingdom, then sums hits for those lineages
#-------------------------------------------------------
#List of lineages related to viruses

#Change WD & define virus filter for whole script
setwd("~/MastersDegree/Thesis/Classifiers/CLARK/Viral/")
virusFilter <- c("Viruses", "Phages")


#Create tables for each dataset - TaxIDs
#If first time running, uncomment and run each table though eutils script
# write.table(HomoRespAbund$TaxID, file='HomoRespClarkTax.tsv', quote=FALSE, row.names = FALSE, col.names = FALSE)
# write.table(TravChikAbund$TaxID, file='TravChikClarkTax.tsv', quote=FALSE, row.names = FALSE, col.names = FALSE)
# write.table(MidgeNovAbund$TaxID, file='MidgeNovClarkTax.tsv', quote=FALSE, row.names = FALSE, col.names = FALSE)
# write.table(SRR062415Abund$TaxID, file='SRR062415ClarkTax.tsv', quote=FALSE, row.names = FALSE, col.names = FALSE)
# write.table(SRR062462Abund$TaxID, file='SRR062462ClarkTax.tsv', quote=FALSE, row.names = FALSE, col.names = FALSE)


#HomoResp
TotClarkHomoVir <- read.table("HomoRespClarkVir.txt", header = FALSE, sep=",")
colnames(TotClarkHomoVir) <- c("Lineage", "TaxID")
TotClarkHomoVir <- merge(TotClarkHomoVir, HomoRespAbund, by = "TaxID")
TotClarkHomoVir <- unique(subset(TotClarkHomoVir, grepl(paste(virusFilter, collapse = "|"),
                                                        TotClarkHomoVir[[2]]),drop=FALSE))
TotClarkHomoVirHits <- sum(TotClarkHomoVir$Count)

#TravChik
TotClarkTravVir <- read.table("TravChikClarkVir.txt", header = FALSE, sep=",")
colnames(TotClarkTravVir) <- c("Lineage", "TaxID")
TotClarkTravVir <- merge(TotClarkTravVir, TravChikAbund, by = "TaxID")
TotClarkTravVir <- unique(subset(TotClarkTravVir, grepl(paste(virusFilter, collapse = "|"),
                                                        TotClarkTravVir[[2]]),drop=FALSE))
TotClarkTravVirHits <- sum(TotClarkTravVir$Count)

#MidgeNov
TotClarkMidgeVir <- read.table("MidgeNovClarkVir.txt", header = FALSE, sep=",")
colnames(TotClarkMidgeVir) <- c("Lineage", "TaxID")
TotClarkMidgeVir <- merge(TotClarkMidgeVir, MidgeNovAbund, by = "TaxID")
TotClarkMidgeVir <- unique(subset(TotClarkMidgeVir, grepl(paste(virusFilter, collapse = "|"),
                                                      TotClarkMidgeVir[[2]]),drop=FALSE))
TotClarkMidgeVirHits <- sum(TotClarkMidgeVir$Count)

#SRR062415
TotClarkSRR062415Vir <- read.table("SRR062415ClarkVir.txt", header = FALSE, sep=",")
colnames(TotClarkSRR062415Vir) <- c("Lineage", "TaxID")
TotClarkSRR062415Vir <- merge(TotClarkSRR062415Vir, SRR062415Abund, by = "TaxID")
TotClarkSRR062415Vir <- unique(subset(TotClarkSRR062415Vir, grepl(paste(virusFilter, collapse = "|"),
                                                          TotClarkSRR062415Vir[[2]]),drop=FALSE))
TotClarkSRR062415VirHits <- sum(TotClarkSRR062415Vir$Count)

#SRR062462
TotClarkSRR062462Vir <- read.table("SRR062462ClarkVir.txt", header = FALSE, sep=",")
colnames(TotClarkSRR062462Vir) <- c("Lineage", "TaxID")
TotClarkSRR062462Vir <- merge(TotClarkSRR062462Vir, SRR062462Abund, by = "TaxID")
TotClarkSRR062462Vir <- unique(subset(TotClarkSRR062462Vir, grepl(paste(virusFilter, collapse = "|"),
                                                                  TotClarkSRR062462Vir[[2]]),drop=FALSE))
TotClarkSRR062462VirHits <- sum(TotClarkSRR062462Vir$Count)

#Assign total no. of viral sequences for each dataset
HomoResp[5,2] <- TotClarkHomoVirHits
TravChik[5,2] <- TotClarkTravVirHits
MidgeNov[5,2] <- TotClarkMidgeVirHits
SRR062415[5,2] <- TotClarkSRR062415VirHits
SRR062462[5,2] <- TotClarkSRR062462VirHits

#Get top CLARK viral hit info from tables made in previous section
#---------------------------
#HomoResp
TotClarkHomoVir <- TotClarkHomoVir[order(-TotClarkHomoVir$Count),]
HomoClarkTopVirTax <- TotClarkHomoVir[1,1]
HomoClarkTopVirHits <- TotClarkHomoVir[1,5]
HomoClarkTopVirName <- TotClarkHomoVir[1,3]

#MidgeNov
TotClarkMidgeVir <- TotClarkMidgeVir[order(-TotClarkMidgeVir$Count),]
MidgeClarkTopVirTax <- TotClarkMidgeVir[1,1]
MidgeClarkTopVirHits <- TotClarkMidgeVir[1,5]
MidgeClarkTopVirName <- TotClarkMidgeVir[1,3]

#TravChik
TotClarkTravVir <- TotClarkTravVir[order(-TotClarkTravVir$Count),]
TravClarkTopVirTax <- TotClarkTravVir[1,1]
TravClarkTopVirHits <- TotClarkTravVir[1,5]
TravClarkTopVirName <- TotClarkTravVir[1,3]

#SRR062415
TotClarkSRR062415Vir <- TotClarkSRR062415Vir[order(-TotClarkSRR062415Vir$Count),]
SRR062415ClarkTopVirTax <- TotClarkSRR062415Vir[1,1]
SRR062415ClarkTopVirHits <- TotClarkSRR062415Vir[1,5]
SRR062415ClarkTopVirName <- TotClarkSRR062415Vir[1,3]

#SRR062462
TotClarkSRR062462Vir <- TotClarkSRR062462Vir[order(-TotClarkSRR062462Vir$Count),]
SRR062462ClarkTopVirTax <- TotClarkSRR062462Vir[1,1]
SRR062462ClarkTopVirHits <- TotClarkSRR062462Vir[1,5]
SRR062462ClarkTopVirName <- TotClarkSRR062462Vir[1,3]

#CLARK-S
#--------------------------------------------------------
#Read in CLARK-S speeds
setwd("~/MastersDegree/Thesis/Classifiers/CLARK-S/Abundances&Speeds/")
clarkSSpeeds <- read.table("speeds.txt", header = TRUE, sep=",")

#Assign CLARK speed values to tables respectively
HomoResp[3,4] <- clarkSSpeeds$HomoResp
MidgeNov[3,4] <- clarkSSpeeds$MidgeNov
TravChik[3,4] <- clarkSSpeeds$travChik
SRR062415[3,4] <- clarkSSpeeds$SRR062415
SRR062462[3,4] <- clarkSSpeeds$SRR062462

#Calculate CLARK-S richness for each sample & assign values to tables respectively 
#Subset to remove unknowns and unclassifieds
#HomoResp
noRowsHomoAbundClarkS <- nrow(HomoRespAbundClarkS)
TempHomoClarkS <- HomoRespAbundClarkS[-c(noRowsHomoAbundClarkS),]
totTaxIdHomoClarkS <- nrow(TempHomoClarkS)
TotHitsHomoRespClarkS <- sum(TempHomoClarkS$Count)
HomoResp[1,4] <- TotHitsHomoRespClarkS
HomoResp[2,4] <- totTaxIdHomoClarkS

#MidgeNov
noRowsMidgeAbundClarkS <- nrow(MidgeNovAbundClarkS)
TempMidgeClarkS <- MidgeNovAbundClarkS[-c(noRowsMidgeAbundClarkS),]
totTaxIdMidgeClarkS <- nrow(TempMidgeClarkS)
TotHitsMidgeNovClarkS <- sum(TempMidgeClarkS$Count)
MidgeNov[1,4] <- TotHitsMidgeNovClarkS
MidgeNov[2,4] <- totTaxIdMidgeClarkS

#SRR062415
noRowsSRR062415AbundClarkS <- nrow(SRR062415AbundClarkS)
TempSRR062415ClarkS <- SRR062415AbundClarkS[-c(noRowsSRR062415AbundClarkS),]
totTaxIdSRR062415ClarkS <- nrow(TempSRR062415ClarkS)
TotHitsSRR062415ClarkS <- sum(TempSRR062415ClarkS$Count)
SRR062415[1,4] <- TotHitsSRR062415ClarkS
SRR062415[2,4] <- totTaxIdSRR062415ClarkS

#SRR062462
noRowsSRR062462AbundClarkS <- nrow(SRR062462AbundClarkS)
TempSRR062462ClarkS <- SRR062462AbundClarkS[-c(noRowsSRR062462AbundClarkS),]
totTaxIdSRR062462ClarkS <- nrow(TempSRR062462ClarkS)
TotHitsSRR062462ClarkS <- sum(TempSRR062462ClarkS$Count)
SRR062462[1,4] <- TotHitsSRR062462ClarkS
SRR062462[2,4] <- totTaxIdSRR062462ClarkS

#TravChik 
noRowsTravChikAbundClarkS <- nrow(TravChikAbundClarkS)
TempTravClarkS <- TravChikAbundClarkS[-c(noRowsTravChikAbundClarkS),]
totTaxIdTravClarkS <- nrow(TempTravClarkS)
TotHitsTravChikClarkS <- sum(TempTravClarkS$Count)
TravChik[1,4] <- TotHitsTravChikClarkS
TravChik[2,4] <- totTaxIdTravClarkS

#----------------------------------------------------
#Calculate CLARK-S Pielou - uses table made in previous section
#Doesn't include unknowns & unclassifieds
#HomoResp
HomoRespVec <- TempHomoClarkS$Count
HomoRespPielou <- pielou(HomoRespVec)
HomoResp[4,4] <- HomoRespPielou

#MidgeNov
MidgeNovVec <- TempMidgeClarkS$Count
MidgeNovPielou <- pielou(MidgeNovVec)
MidgeNov[4,4] <- MidgeNovPielou

#TravChik
TravChikVec <- TempTravClarkS$Count
TravChikPielou <- pielou(TravChikVec)
TravChik[4,4] <- TravChikPielou

#SRR062415
SRR062415Vec <- TempSRR062415ClarkS$Count
SRR062415Pielou <- pielou(SRR062415Vec)
SRR062415[4,4] <- SRR062415Pielou

#SRR062462
SRR062462Vec <- TempSRR062462ClarkS$Count
SRR062462Pielou <- pielou(SRR062462Vec)
SRR062462[4,4] <- SRR062462Pielou


#Retrieve no. of viral sequences for CLARK-S
#-------------------------------------------------------
#List of lineages related to viruses
#change WD
setwd("~/MastersDegree/Thesis/Classifiers/CLARK-S/Viral/")

#Creates file of taxIDs for each benchmarking dataset, the file is read through perl eutils script (taxScriptVir.pl) 
#returns the taxIDs with Virus division/Kingdom, then sums hits for those lineages

#Create files, uncomment if first time running and run files through eutils scripts
# write.table(HomoRespAbundClarkS$TaxID, file='HomoRespClarkSTax.tsv', quote=FALSE, row.names = FALSE, col.names = FALSE)
# write.table(TravChikAbundClarkS$TaxID, file='TravChikClarkSTax.tsv', quote=FALSE, row.names = FALSE, col.names = FALSE)
# write.table(MidgeNovAbundClarkS$TaxID, file='MidgeNovClarkSTax.tsv', quote=FALSE, row.names = FALSE, col.names = FALSE)
# write.table(SRR062415AbundClarkS$TaxID, file='SRR062415ClarkSTax.tsv', quote=FALSE, row.names = FALSE, col.names = FALSE)
# write.table(SRR062462AbundClarkS$TaxID, file='SRR062462ClarkSTax.tsv', quote=FALSE, row.names = FALSE, col.names = FALSE)

#HomoResp
TotClarkSHomoVir <- read.table("HomoRespClarkSVir.txt", header = FALSE, sep=",")
colnames(TotClarkSHomoVir) <- c("Lineage", "TaxID")
TotClarkSHomoVir <- merge(TotClarkSHomoVir, HomoRespAbundClarkS, by = "TaxID")
TotClarkSHomoVir <- unique(subset(TotClarkSHomoVir, grepl(paste(virusFilter, collapse = "|"),
                                                        TotClarkSHomoVir[[2]]),drop=FALSE))
TotClarkSHomoVirHits <- sum(TotClarkSHomoVir$Count)

#TravChik
TotClarkSTravVir <- read.table("TravChikClarkSVir.txt", header = FALSE, sep=",")
colnames(TotClarkSTravVir) <- c("Lineage", "TaxID")
TotClarkSTravVir <- merge(TotClarkSTravVir, TravChikAbundClarkS, by = "TaxID")
TotClarkSTravVir <- unique(subset(TotClarkSTravVir, grepl(paste(virusFilter, collapse = "|"),
                                                        TotClarkSTravVir[[2]]),drop=FALSE))
TotClarkSTravVirHits <- sum(TotClarkSTravVir$Count)

#MidgeNov
TotClarkSMidgeVir <- read.table("MidgeNovClarkSVir.txt", header = FALSE, sep=",")
colnames(TotClarkSMidgeVir) <- c("Lineage", "TaxID")
TotClarkSMidgeVir <- merge(TotClarkSMidgeVir, MidgeNovAbundClarkS, by = "TaxID")
TotClarkSMidgeVir <- unique(subset(TotClarkSMidgeVir, grepl(paste(virusFilter, collapse = "|"),
                                                          TotClarkSMidgeVir[[2]]),drop=FALSE))
TotClarkSMidgeVirHits <- sum(TotClarkSMidgeVir$Count)

#SRR062415
TotClarkSSRR062415Vir <- read.table("SRR062415ClarkSVir.txt", header = FALSE, sep=",")
colnames(TotClarkSSRR062415Vir) <- c("Lineage", "TaxID")
TotClarkSSRR062415Vir <- merge(TotClarkSSRR062415Vir, SRR062415AbundClarkS, by = "TaxID")
TotClarkSSRR062415Vir <- unique(subset(TotClarkSSRR062415Vir, grepl(paste(virusFilter, collapse = "|"),
                                                                  TotClarkSSRR062415Vir[[2]]),drop=FALSE))
TotClarkSSRR062415VirHits <- sum(TotClarkSSRR062415Vir$Count)

#SRR062462
TotClarkSSRR062462Vir <- read.table("SRR062462ClarkSVir.txt", header = FALSE, sep=",")
colnames(TotClarkSSRR062462Vir) <- c("Lineage", "TaxID")
TotClarkSSRR062462Vir <- merge(TotClarkSSRR062462Vir, SRR062462AbundClarkS, by = "TaxID")
TotClarkSSRR062462Vir <- unique(subset(TotClarkSSRR062462Vir, grepl(paste(virusFilter, collapse = "|"),
                                                                  TotClarkSSRR062462Vir[[2]]),drop=FALSE))
TotClarkSSRR062462VirHits <- sum(TotClarkSSRR062462Vir$Count)

#Assign total no. of viral sequences for each dataset
HomoResp[5,4] <- TotClarkSHomoVirHits
TravChik[5,4] <- TotClarkSTravVirHits
MidgeNov[5,4] <- TotClarkSMidgeVirHits
SRR062415[5,4] <- TotClarkSSRR062415VirHits
SRR062462[5,4] <- TotClarkSSRR062462VirHits

#Get top CLARK-S viral hit info by using tables created in previous section
#---------------------------
#HomoResp
TotClarkSHomoVir <- TotClarkSHomoVir[order(-TotClarkSHomoVir$Count),]
HomoClarkSTopVirTax <- TotClarkSHomoVir[1,1]
HomoClarkSTopVirHits <- TotClarkSHomoVir[1,5]
HomoClarkSTopVirName <- TotClarkSHomoVir[1,3]

#MidgeNov
TotClarkSMidgeVir <- TotClarkSMidgeVir[order(-TotClarkMidgeVir$Count),]
MidgeClarkSTopVirTax <- TotClarkSMidgeVir[1,1]
MidgeClarkSTopVirHits <- TotClarkSMidgeVir[1,5]
MidgeClarkSTopVirName <- TotClarkSMidgeVir[1,3]

#TravChik
TotClarkSTravVir <- TotClarkSTravVir[order(-TotClarkSTravVir$Count),]
TravClarkSTopVirTax <- TotClarkSTravVir[1,1]
TravClarkSTopVirHits <- TotClarkSTravVir[1,5]
TravClarkSTopVirName <- TotClarkSTravVir[1,3]

#SRR062415
TotClarkSSRR062415Vir <- TotClarkSSRR062415Vir[order(-TotClarkSSRR062415Vir$Count),]
SRR062415ClarkSTopVirTax <- TotClarkSSRR062415Vir[1,1]
SRR062415ClarkSTopVirHits <- TotClarkSSRR062415Vir[1,5]
SRR062415ClarkSTopVirName <- TotClarkSSRR062415Vir[1,3]

#SRR062462
TotClarkSSRR062462Vir <- TotClarkSSRR062462Vir[order(-TotClarkSSRR062462Vir$Count),]
SRR062462ClarkSTopVirTax <- TotClarkSSRR062462Vir[1,1]
SRR062462ClarkSTopVirHits <- TotClarkSSRR062462Vir[1,5]
SRR062462ClarkSTopVirName <- TotClarkSSRR062462Vir[1,3]

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

#Assign speed values to dataset tables respectively
HomoResp[3,1] <- kaijuHomoRespSpeed
MidgeNov[3,1] <- kaijuMidgeNovSpeed
TravChik[3,1] <- kaijuTravChikSpeed
SRR062415[3,1] <- kaijuSRR062415Speed
SRR062462[3,1] <- kaijuSRR062462Speed

#--------------------------------------------------------
#Kaiju assigned taxon ids & number of assigned taxon ids & number of hits
setwd(y)

#Calculate richness for Kaiju
#Calculate total number of TaxIDs by counting the number of rows in abundance table
TotTaxHomoKaiju <- nrow(HomoRespAbundKaiju)
TotTaxMidgeKaiju <- nrow(MidgeNovAbundKaiju)
TotTaxTravKaiju <- nrow(TravChikAbundKaiju)
TotTaxSRR062462Kaiju <- nrow(SRR062462AbundKaiju)
TotTaxSRR062415Kaiju <- nrow(SRR062415AbundKaiju)

#Read in summaries in order to retrieve kmer counts for each taxID
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
TempSRR062415Kaiju <- kaijuSummarySRR062415[-c(noRowsSRR062415Kaiju, noRowsSRR062415Kaiju-1),]
TempSRR062462Kaiju <- kaijuSummarySRR062462[-c(noRowsSRR062462Kaiju, noRowsSRR062462Kaiju-1),]


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
TempSRR062415Kaiju <- kaijuSummarySRR062415[-c(noRowsSRR062415Kaiju, noRowsSRR062415Kaiju-1,noRowsSRR062415Kaiju-2),]
TempSRR062462Kaiju <- kaijuSummarySRR062462[-c(noRowsSRR062462Kaiju, noRowsSRR062462Kaiju-1,noRowsSRR062462Kaiju-2),]

#Read in cut table in order to standardize virus kmer counts across all classifiers
kaijuCutHomo <- read.table("kaijuHomoRespCut.names.out", header = FALSE, sep="\t", quote = "")
kaijuCutMidge <- read.table("kaijuMidgeCut.names.out", header = FALSE, sep="\t", quote = "")
kaijuCutTrav <- read.table("kaijuTravCut.names.out", header = FALSE, sep="\t", quote = "")
kaijuCutSRR062462 <- read.table("kaijuSRR062462Cut.names.out", header = FALSE, sep="\t", quote = "", fill = TRUE)
kaijuCutSRR062415 <- read.table("kaijuSRR062415Cut.names.out", header = FALSE, sep="\t", quote = "", fill = TRUE)

#No. of tax IDs
totTaxIDKaijuHomo <- length(unique(kaijuCutHomo$V1))
totTaxIDKaijuMidge <- length(unique(kaijuCutMidge$V1))
totTaxIDKaijuTrav <- length(unique(kaijuCutTrav$V1))
totTaxIDKaijuSRR062415 <- length(unique(kaijuCutSRR062415$V1))
totTaxIDKaijuSRR062462 <- length(unique(kaijuCutSRR062462$V1))

#Create kmer counts table for Kaiju 
#takes unique values from output and merges the lineage and counts by TaxID 
#ordered by kmer counts
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
#Total hits
HomoResp[1,1] <- kaijuHomoCountSum
TravChik[1,1] <- kaijuTravCountSum
MidgeNov[1,1] <- kaijuMidgeCountSum
SRR062415[1,1] <- kaijuSRR062415CountSum
SRR062462[1,1] <- kaijuSRR062462CountSum

#Total no. of taxIDs
HomoResp[2,1] <- totTaxIDKaijuHomo
TravChik[2,1] <- totTaxIDKaijuTrav
MidgeNov[2,1] <- totTaxIDKaijuMidge
SRR062415[2,1] <- totTaxIDKaijuSRR062415
SRR062462[2,1] <- totTaxIDKaijuSRR062462


#--------------------------------------------------------
#Calculate Kaiju pielou & assign values to respective sample tables 
#Uses vector of kmer counts for each respective dataset
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
#Change WD
setwd("~/MastersDegree/Thesis/Classifiers/Kaiju/Viral/")

#Creates file of taxIDs for each benchmarking dataset, the file is read through perl eutils script (taxScriptVir.pl) 
#returns the taxIDs with Virus division/Kingdom, then sums hits for those lineages

#Create tables - uncomment if first time running
# write.table(homoCountTabKaiju$TaxID, file='HomoRespKaijuTax.tsv',quote=FALSE, row.names = FALSE, col.names = FALSE)
# write.table(midgeCountTabKaiju$TaxID, file = 'MidgeNovKaijuTax.tsv',quote=FALSE,row.names=FALSE,col.names=FALSE)
# write.table(travCountTabKaiju$TaxID, file = 'TravChikKaijuTax.tsv',quote=FALSE,row.names=FALSE,col.names=FALSE)
# write.table(SRR062462CountTabKaiju$TaxID, file = 'SRR062462KaijuTax.tsv',quote=FALSE,row.names=FALSE,col.names=FALSE)
# write.table(SRR062415CountTabKaiju$TaxID, file = 'SRR062415KaijuTax.tsv',quote=FALSE,row.names=FALSE,col.names=FALSE)

#HomoResp
kaijuVirusTotHomo <- read.table("HomoRespKaijuVir.txt",header=FALSE,sep=",")
colnames(kaijuVirusTotHomo) <- c("Lineage","TaxID")
kaijuVirusTotHomo <- merge(kaijuVirusTotHomo, homoCountTabKaiju, by = "TaxID")
kaijuVirusTotHomo <- unique(subset(kaijuVirusTotHomo, grepl(paste(virusFilter,collapse="|"),
                                                            kaijuVirusTotHomo[[2]]),drop=FALSE))
kaijuVirusTotHomoHits <- sum(kaijuVirusTotHomo$Freq)

HomoResp[5,1] <- kaijuVirusTotHomoHits

#MidgeNov
kaijuVirusTotMidge <- read.table("MidgeNovKaijuVir.txt",header=FALSE,sep=",")
colnames(kaijuVirusTotMidge) <- c("Lineage","TaxID")
kaijuVirusTotMidge <- merge(kaijuVirusTotMidge, midgeCountTabKaiju, by = "TaxID")
kaijuVirusTotMidge <- unique(subset(kaijuVirusTotMidge, grepl(paste(virusFilter,collapse="|"),
                                                             kaijuVirusTotMidge[[2]]),drop=FALSE))
kaijuVirusTotMidgeHits <- sum(kaijuVirusTotMidge$Freq)
MidgeNov[5,1] <- kaijuVirusTotMidgeHits

#TravChik
kaijuVirusTotTrav <- read.table("TravChikKaijuVir.txt",header=FALSE,sep=",")
colnames(kaijuVirusTotTrav) <- c("Lineage","TaxID")
kaijuVirusTotTrav <- merge(kaijuVirusTotTrav, travCountTabKaiju, by = "TaxID")
kaijuVirusTotTrav <- unique(subset(kaijuVirusTotTrav, grepl(paste(virusFilter,collapse="|"),
                                                            kaijuVirusTotTrav[[2]]),drop=FALSE))
kaijuVirusTotTravHits <- sum(kaijuVirusTotTrav$Freq)
TravChik[5,1] <- kaijuVirusTotTravHits

#SRR062462
kaijuVirusTotSRR062462 <- read.table("SRR062462KaijuVir.txt",header=FALSE,sep=",")
colnames(kaijuVirusTotSRR062462) <- c("Lineage","TaxID")
kaijuVirusTotSRR062462 <- merge(kaijuVirusTotSRR062462, SRR062462CountTabKaiju, by = "TaxID")
kaijuVirusTotSRR062462 <- unique(subset(kaijuVirusTotSRR062462, grepl(paste(virusFilter,collapse="|"),
                                                                      kaijuVirusTotSRR062462[[2]]),drop=FALSE))
kaijuVirusTotSRR062462Hits <- sum(kaijuVirusTotSRR062462$Freq)
SRR062462[5,1] <- kaijuVirusTotSRR062462Hits


#SRR062415
kaijuVirusTotSRR062415 <- read.table("SRR062415KaijuVir.txt",header=FALSE,sep=",")
colnames(kaijuVirusTotSRR062415) <- c("Lineage","TaxID")
kaijuVirusTotSRR062415 <- merge(kaijuVirusTotSRR062415, SRR062415CountTabKaiju, by = "TaxID")
kaijuVirusTotSRR062415 <- unique(subset(kaijuVirusTotSRR062415, grepl(paste(virusFilter,collapse="|"),
                                                                      kaijuVirusTotSRR062415[[2]]),drop=FALSE))
kaijuVirusTotSRR062415Hits <- sum(kaijuVirusTotSRR062415$Freq)
SRR062415[5,1] <- kaijuVirusTotSRR062415Hits

#Return top virus hit for Kaiju
#-------------------
#HomoResp
#Subset based upon virus filter (lineage)
#Select top row values (order on kmer count freq.) - This process is repeated
tempHomoVirKaiju <- kaijuVirusTotHomo[order(-kaijuVirusTotHomo$Freq),]
topHomoVirTaxKaiju <- tempHomoVirKaiju[1,1]
topHomoVirNameKaiju <- tempHomoVirKaiju[1,3]
topHomoVirHitKaiju <- tempHomoVirKaiju[1,4]

#MidgeNov
tempMidgeVirKaiju <- kaijuVirusTotMidge[order(-kaijuVirusTotMidge$Freq),]
topMidgeVirTaxKaiju <- tempMidgeVirKaiju[1,1]
topMidgeVirNameKaiju <- tempMidgeVirKaiju[1,3]
topMidgeVirHitKaiju <- tempMidgeVirKaiju[1,4]

#TravChik
tempTravVirKaiju <- kaijuVirusTotTrav[order(-kaijuVirusTotTrav$Freq),]
topTravVirTaxkaiju <- tempTravVirKaiju[1,1]
topTravVirNameKaiju <- tempTravVirKaiju[1,3]
topTravVirHitKaiju <- tempTravVirKaiju[1,4]

#SRR062415
tempSRR062415VirKaiju <- kaijuVirusTotSRR062415[order(-kaijuVirusTotSRR062415$Freq),]
topSRR062415VirTaxKaiju <- tempSRR062415VirKaiju[1,1]
topSRR062415VirNameKaiju <- tempSRR062415VirKaiju[1,3]
topSRR062415VirHitKaiju <- tempSRR062415VirKaiju[1,4]

#SRR062462
tempSRR062462VirKaiju <- kaijuVirusTotSRR062462[order(-kaijuVirusTotSRR062462$Freq),]
topSRR062462VirTaxKaiju <- tempSRR062462VirKaiju[1,1]
topSRR062462VirNameKaiju <- tempSRR062462VirKaiju[1,3]
topSRR062462VirHitKaiju <- tempSRR062462VirKaiju[1,4]

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
#Change WD
setwd("~/MastersDegree/Thesis/Classifiers/Kraken/Viral/")

#Write tables
#write.table(HomoRespAbundKrak$taxonomy_id, file='HomoRespKrakenTax.tsv',quote=FALSE, row.names = FALSE, col.names = FALSE)
# #write.table(TravChikAbundKrak$taxonomy_id, file='TravChikKrakenTax.tsv',quote=FALSE, row.names = FALSE, col.names = FALSE)
# write.table(MidgeNovAbundKrak$taxonomy_id, file='MidgeNovKrakenTax.tsv',quote=FALSE, row.names = FALSE, col.names = FALSE)
# write.table(SRR062415AbundKrak$taxonomy_id, file='SRR062415KrakenTax.tsv',quote=FALSE, row.names = FALSE, col.names = FALSE)
# write.table(SRR062462AbundKrak$taxonomy_id, file='SRR062462KrakenTax.tsv',quote=FALSE, row.names = FALSE, col.names = FALSE)

#Subset & Sum hits
#HomoResp
HomoKrakViral <- read.table("HomoRespKrakVir.txt", header = F, sep = ",")
colnames(HomoKrakViral) <- c("Lineage","taxonomy_id")
HomoKrakViral <- merge(HomoKrakViral, HomoRespAbundKrak, by="taxonomy_id")
HomoKrakViral <- unique(subset(HomoKrakViral, grepl(paste(virusFilter,collapse="|"),
                                                             HomoKrakViral[[2]]),drop=FALSE))
TotKrakHomoVir <- sum(HomoKrakViral$kraken_assigned_reads)

#TravChik
TravKrakViral <- read.table("TravChikKrakVir.txt", header = F, sep = ",")
colnames(TravKrakViral) <- c("Lineage","taxonomy_id")
TravKrakViral <- merge(TravKrakViral, TravChikAbundKrak, by="taxonomy_id",all=T)
TravKrakViral <- unique(subset(TravKrakViral, grepl(paste(virusFilter,collapse="|"),
                                                    TravKrakViral[[2]]),drop=FALSE))
TotKrakTravVir <- sum(TravKrakViral$kraken_assigned_reads)

#MidgeNov
MidgeKrakViral <- read.table("MidgeNovKrakVir.txt", header = F, sep = ",")
colnames(MidgeKrakViral) <- c("Lineage","taxonomy_id")
MidgeKrakViral <- merge(MidgeKrakViral, MidgeNovAbundKrak, by="taxonomy_id")
MidgeKrakViral <- unique(subset(MidgeKrakViral, grepl(paste(virusFilter,collapse="|"),
                                                      MidgeKrakViral[[2]]),drop=FALSE))
TotKrakMidgeVir <- sum(MidgeKrakViral$kraken_assigned_reads)

#SRR062415
SRR062415KrakViral <- read.table("SRR062415KrakVir.txt", header = F, sep = ",")
colnames(SRR062415KrakViral) <- c("Lineage","taxonomy_id")
SRR062415KrakViral <- merge(SRR062415KrakViral, SRR062415AbundKrak, by="taxonomy_id")
SRR062415KrakViral <- unique(subset(SRR062415KrakViral, grepl(paste(virusFilter,collapse="|"),
                                                              SRR062415KrakViral[[2]]),drop=FALSE))
TotKrakSRR062415Vir <- sum(SRR062415KrakViral$kraken_assigned_reads)

#SRR062462
SRR062462KrakViral <- read.table("SRR062462KrakVir.txt", header = F, sep = ",")
colnames(SRR062462KrakViral) <- c("Lineage","taxonomy_id")
SRR062462KrakViral <- merge(SRR062462KrakViral, SRR062462AbundKrak, by="taxonomy_id")
SRR062462KrakViral <- unique(subset(SRR062462KrakViral, grepl(paste(virusFilter,collapse="|"),
                                                              SRR062462KrakViral[[2]]),drop=FALSE))
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
HomoKrakTopVirTax <- HomoKrakViral[1,1]
HomoKrakTopVirHits <- HomoKrakViral[1,5]
HomoKrakTopVirName <- HomoKrakViral[1,3]

#MidgeNov
MidgeKrakViral <- MidgeKrakViral[order(-MidgeKrakViral$kraken_assigned_reads),]
MidgeKrakTopVirTax <- MidgeKrakViral[1,1]
MidgeKrakTopVirHits <- MidgeKrakViral[1,5]
MidgeKrakTopVirName <- MidgeKrakViral[1,3]

#TravChik
TravKrakViral <- TravKrakViral[order(-TravKrakViral$kraken_assigned_reads),]
TravKrakTopVirTax <- TravKrakViral[1,1]
TravKrakTopVirHits <- TravKrakViral[1,5]
TravKrakTopVirName <- TravKrakViral[1,3]

#SRR062415
SRR062415KrakViral <- SRR062415KrakViral[order(-SRR062415KrakViral$kraken_assigned_reads),]
SRR062415TopVirTax <- SRR062415KrakViral[1,1]
SRR062415TopVirHits <- SRR062415KrakViral[1,5]
SRR062415TopVirName <- SRR062415KrakViral[1,3]

#SRR062462
SRR062462KrakViral <- SRR062462KrakViral[order(-SRR062462KrakViral$kraken_assigned_reads),]
SRR062462TopVirTax <- SRR062462KrakViral[1,1]
SRR062462TopVirHits <- SRR062462KrakViral[1,5]
SRR062462TopVirName <- SRR062462KrakViral[1,3]


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

#CLARK-S
#HomoResp
HomoResp[6,4] <- HomoClarkSTopVirTax
HomoResp[7,4] <- as.character(HomoClarkSTopVirName)
HomoResp[8,4] <- HomoClarkSTopVirHits

#MidgeNov
MidgeNov[6,4] <- MidgeClarkSTopVirTax
MidgeNov[7,4] <- as.character(MidgeClarkSTopVirName)
MidgeNov[8,4] <- MidgeClarkSTopVirHits

#TravChik
TravChik[6,4] <- TravClarkSTopVirTax
TravChik[7,4] <- as.character(TravClarkSTopVirName)
TravChik[8,4] <- TravClarkSTopVirHits

#SRR062415
SRR062415[6,4] <- SRR062415ClarkSTopVirTax
SRR062415[7,4] <- as.character(SRR062415ClarkSTopVirName)
SRR062415[8,4] <- SRR062415ClarkSTopVirHits

#SRR062462
SRR062462[6,4] <- SRR062462ClarkSTopVirTax
SRR062462[7,4] <- as.character(SRR062462ClarkSTopVirName)
SRR062462[8,4] <- SRR062462ClarkSTopVirHits

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

#Assign values Kaiju -- split allows for the species name to be taken rather than whole lineage
#HomoResp
HomoResp[6,1] <- topHomoVirTaxKaiju
topHomoVirNameKaiju <- as.character(topHomoVirNameKaiju)
HomoResp[7,1] <- topHomoVirNameKaiju
HomoResp[8,1] <- topHomoVirHitKaiju

#MidgeNov
MidgeNov[6,1] <- topMidgeVirTaxKaiju
topMidgeVirNameKaiju <- as.character(topMidgeVirNameKaiju)
MidgeNov[7,1] <- topMidgeVirNameKaiju
MidgeNov[8,1] <- topMidgeVirHitKaiju

#TravChik
TravChik[6,1] <- topTravVirTaxkaiju
topTravVirNameKaiju <- as.character(topTravVirNameKaiju)
TravChik[7,1] <- topTravVirNameKaiju
TravChik[8,1] <- topTravVirHitKaiju

#SRR062415
SRR062415[6,1] <- topSRR062415VirTaxKaiju
topSRR062415VirNameKaiju <- as.character(topSRR062415VirNameKaiju)
SRR062415[7,1] <- topSRR062415VirNameKaiju
SRR062415[8,1] <- topSRR062415VirHitKaiju

#SRR062462
SRR062462[6,1] <- topSRR062462VirTaxKaiju
topSRR062462VirNameKaiju <- as.character(topSRR062462VirNameKaiju)
SRR062462[7,1] <- topSRR062462VirNameKaiju
SRR062462[8,1] <- topSRR062462VirHitKaiju

#Write out benchmark tables
setwd(xx)
write.table(HomoResp, file='HomoRespBenchmark.tsv', quote=FALSE, sep="\t")
write.table(MidgeNov, file='MidgeNovBenchmark.tsv', quote=FALSE, sep="\t")
write.table(TravChik, file='TravChikBenchmark.tsv', quote=FALSE, sep="\t")
write.table(SRR062415, file='SRR062415Benchmark.tsv', quote=FALSE, sep="\t")
write.table(SRR062462, file='SRR062462Benchmark.tsv', quote=FALSE, sep="\t")

#Create TaxID tables - subset to remove unwanted columns, rename columns 
#Merge subsetted dfs with df containing all unique taxIDs
#HomoResp
TempHomoClark <- TempHomoClark[-c(1,3,5,6)]
colnames(TempHomoClark) <- c("TaxID", "CLARK")
TempHomoKaiju <- homoCountTabKaiju[-2]
colnames(TempHomoKaiju) <- c("TaxID", "Kaiju")
TempHomoKrak <- HomoRespAbundKrak[-c(1,3,5,6,7)]
colnames(TempHomoKrak) <- c("TaxID", "Kraken")
TempHomoClarkS <- TempHomoClarkS[-c(1,3,5,6)]
colnames(TempHomoClarkS) <-c("TaxID","CLARK-S")

TempHomoClark$TaxID <- as.character(TempHomoClark$TaxID)
TempHomoClarkS$TaxID <- as.character(TempHomoClarkS$TaxID)
uniqueIDVecHomo <- unique(c(TempHomoClark$TaxID, TempHomoKaiju$TaxID, TempHomoKrak$TaxID, TempHomoClarkS$TaxID))
HomoTaxDF <- data.frame(uniqueIDVecHomo)
colnames(HomoTaxDF) <- "TaxID"
HomoTaxDF <- merge(HomoTaxDF, TempHomoClark, all=T)
HomoTaxDF <- merge(HomoTaxDF, TempHomoKaiju, all=T)
HomoTaxDF <- merge(HomoTaxDF, TempHomoKrak, all=T)
HomoTaxDF <-merge(HomoTaxDF, TempHomoClarkS, all=T)

#Venn Diagram of different classifiers & overlapping TaxIDs
write.csv(TempHomoClark$TaxID, file="ClarkHomoTax.csv",row.names=F,col.names=F)
ClarkHomoTax <- read.csv("ClarkHomoTax.csv")

write.csv(TempHomoKaiju$TaxID, file="KaijuHomoTax.csv",row.names=F,col.names=F)
KaijuHomoTax <- read.csv("KaijuHomoTax.csv")

write.csv(TempHomoKrak$TaxID, file="KrakHomoTax.csv",row.names=F,col.names=F)
KrakHomoTax <- read.csv("KrakHomoTax.csv")

write.csv(TempHomoClarkS$TaxID, file="ClarkSHomoTax.csv",row.names=F)
ClarkSHomoTax <- read.csv("ClarkSHomoTax.csv")

HomoVenn <- venn.diagram(c(ClarkHomoTax,ClarkSHomoTax,KaijuHomoTax,KrakHomoTax), category.names = c("CLARK","CLARK-S","Kaiju","Kraken"), "HomoRespVenn.tiff", fill=c("blue", "red", "yellow","green"))


#MidgeNov
TempMidgeClark <- TempMidgeClark[-c(1,3,5,6)]
colnames(TempMidgeClark) <- c("TaxID", "CLARK")
TempMidgeKaiju <- midgeCountTabKaiju[-2]
colnames(TempMidgeKaiju) <- c("TaxID", "Kaiju")
TempMidgeKrak <- MidgeNovAbundKrak[-c(1,3,5,6,7)]
colnames(TempMidgeKrak) <- c("TaxID", "Kraken")
TempMidgeClarkS <- TempMidgeClarkS[-c(1,3,5,6)]
colnames(TempMidgeClarkS) <- c("TaxID","CLARK-S")

TempMidgeClark$TaxID <- as.character(TempMidgeClark$TaxID)
TempMidgeClarkS$TaxID <- as.character(TempMidgeClarkS$TaxID)
uniqueIDVecMidge <- unique(c(TempMidgeClark$TaxID, TempMidgeKaiju$TaxID, TempMidgeKrak$TaxID, TempMidgeClarkS$TaxID))
MidgeTaxDF <- data.frame(uniqueIDVecMidge)
colnames(MidgeTaxDF) <- "TaxID"
MidgeTaxDF <- merge(MidgeTaxDF, TempMidgeClark, all=T)
MidgeTaxDF <- merge(MidgeTaxDF, TempMidgeKaiju, all=T)
MidgeTaxDF <- merge(MidgeTaxDF, TempMidgeKrak, all=T)
MidgeTaxDF <- merge(MidgeTaxDF, TempMidgeClarkS, all=T)

#TravChik
TempTravClark <- TempTravClark[-c(1,3,5,6)]
colnames(TempTravClark) <- c("TaxID", "CLARK")
TempTravKaiju <- travCountTabKaiju[-2]
colnames(TempTravKaiju) <- c("TaxID", "Kaiju")
TempTravKrak <- TravChikAbundKrak[-c(1,3,5,6,7)]
colnames(TempTravKrak) <- c("TaxID", "Kraken")
TempTravClarkS <- TempTravClarkS[-c(1,3,5,6)]
colnames(TempTravClarkS) <- c("TaxID","CLARK-S")

TempTravClark$TaxID <- as.character(TempTravClark$TaxID)
TempTravClarkS$TaxID <- as.character(TempTravClarkS$TaxID)
uniqueIDVecTrav <- unique(c(TempTravClark$TaxID, TempTravKaiju$TaxID, TempTravKrak$TaxID,TempTravClarkS$TaxID))
TravTaxDF <- data.frame(uniqueIDVecTrav)
colnames(TravTaxDF) <- "TaxID"
TravTaxDF <- merge(TravTaxDF, TempMidgeClark, all=T)
TravTaxDF <- merge(TravTaxDF, TempMidgeKaiju, all=T)
TravTaxDF <- merge(TravTaxDF, TempMidgeKrak, all=T)
TravTaxDF <- merge(TravTaxDF, TempTravClarkS,all=T)

#SRR062415
TempSRR062415Clark <- TempSRR062415Clark[-c(1,3,5,6)]
colnames(TempSRR062415Clark) <- c("TaxID", "CLARK")
TempSRR062415Kaiju <- SRR062415CountTabKaiju[-2]
colnames(TempSRR062415Kaiju) <- c("TaxID", "Kaiju")
TempSRR062415Krak <- SRR062415AbundKrak[-c(1,3,5,6,7)]
colnames(TempSRR062415Krak) <- c("TaxID", "Kraken")
TempSRR062415ClarkS <- TempSRR062415ClarkS[-c(1,3,5,6)]
colnames(TempSRR062415ClarkS) <- c("TaxID","CLARK-S")

TempSRR062415Clark$TaxID <- as.character(TempSRR062415Clark$TaxID)
TempSRR062415ClarkS$TaxID <- as.character(TempSRR062415ClarkS$TaxID)
uniqueIDVecSRR062415 <- unique(c(TempSRR062415Clark$TaxID, TempSRR062415Kaiju$TaxID, TempSRR062415Krak$TaxID,TempSRR062415ClarkS$TaxID))
SRR062415TaxDF <- data.frame(uniqueIDVecSRR062415)
colnames(SRR062415TaxDF) <- "TaxID"
SRR062415TaxDF <- merge(SRR062415TaxDF, TempSRR062415Clark, all=T)
SRR062415TaxDF <- merge(SRR062415TaxDF, TempSRR062415Kaiju, all=T)
SRR062415TaxDF <- merge(SRR062415TaxDF, TempSRR062415Krak, all=T)
SRR062415TaxDF <- merge(SRR062415TaxDF, TempSRR062415ClarkS,all=T)


#SRR062462
TempSRR062462Clark <- TempSRR062462Clark[-c(1,3,5,6)]
colnames(TempSRR062462Clark) <- c("TaxID", "CLARK")
TempSRR062462Kaiju <- SRR062462CountTabKaiju[-2]
colnames(TempSRR062462Kaiju) <- c("TaxID", "Kaiju")
TempSRR062462Krak <- SRR062462AbundKrak[-c(1,3,5,6,7)]
colnames(TempSRR062462Krak) <- c("TaxID", "Kraken")
TempSRR062462ClarkS <- TempSRR062462ClarkS[-c(1,3,5,6)]
colnames(TempSRR062462ClarkS) <- c("TaxID","CLARK-S")

TempSRR062462Clark$TaxID <- as.character(TempSRR062462Clark$TaxID)
TempSRR062462ClarkS$TaxID <- as.character(TempSRR062462ClarkS$TaxID)
uniqueIDVecSRR062462 <- unique(c(TempSRR062462Clark$TaxID, TempSRR062462Kaiju$TaxID, TempSRR062462Krak$TaxID,TempSRR062462ClarkS$TaxID))
SRR062462TaxDF <- data.frame(uniqueIDVecSRR062462)
colnames(SRR062462TaxDF) <- "TaxID"
SRR062462TaxDF <- merge(SRR062462TaxDF, TempSRR062462Clark, all=T)
SRR062462TaxDF <- merge(SRR062462TaxDF, TempSRR062462Kaiju, all=T)
SRR062462TaxDF <- merge(SRR062462TaxDF, TempSRR062462Krak, all=T)
SRR062462TaxDF <- merge(SRR062462TaxDF, TempSRR062462ClarkS, all=T)

#Write out taxIDs & read in Lineages
# write.table(HomoTaxDF$TaxID, file='HomoRespTax.tsv', quote=FALSE, sep="\n",row.names=F,col.names=F)
# write.table(MidgeTaxDF$TaxID, file='MidgeNovTax.tsv', quote=FALSE, sep="\n",row.names=F,col.names=F)
# write.table(TravTaxDF$TaxID, file='TravChikTax.tsv', quote=FALSE, sep="\n",row.names=F,col.names=F)
# write.table(SRR062415TaxDF$TaxID, file='SRR062415Tax.tsv', quote=FALSE, sep="\n",row.names=F,col.names=F)
# write.table(SRR062462TaxDF$TaxID, file='SRR062462Tax.tsv', quote=FALSE, sep="\n",row.names=F,col.names=F)

#Merge tax tables with NCBI lineage retrieved via EUtils perl script
setwd("~/MastersDegree/Thesis/Classifiers/Tables/")

#HomoResp
HomoTaxLin <- read.table("HomoRespTax.txt", header = TRUE, sep=",")
colnames(HomoTaxLin) <- c("Scientific Name", "TaxID")
HomoTaxDF <- merge(HomoTaxDF, HomoTaxLin)

#MidgeNov
MidgeTaxLin <- read.table("MidgeNovTax.txt", header = TRUE, sep=",", fill = TRUE,quote="")
colnames(MidgeTaxLin) <- c("Scientific Name", "TaxID")
MidgeTaxDF <- merge(MidgeTaxDF, MidgeTaxLin)

#TravChik
TravChikLin <- read.table("TravChikTax.txt", header=TRUE,sep=",",fill=TRUE,quote="")
colnames(TravChikLin) <- c("Scientific Name", "TaxID")
TravTaxDF <- merge(TravTaxDF, TravChikLin)

#SRR062415
SRR062415Lin <- read.table("SRR062415Tax.txt", header=TRUE,sep=",",fill=TRUE,quote="")
colnames(SRR062415Lin) <- c("Scientific Name", "TaxID")
SRR062415TaxDF <- merge(SRR062415TaxDF, SRR062415Lin)

#SRR062462
SRR062462Lin <- read.table("SRR062462Tax.txt",header=TRUE,sep=",",fill=TRUE,quote="")
colnames(SRR062462Lin) <- c("Scientific Name", "TaxID")
SRR062462TaxDF <- merge(SRR062462TaxDF, SRR062462Lin)


#Write out tax tables
# write.table(HomoTaxDF, file='HomoRespTaxTable.tsv', quote=FALSE, sep="\t", row.names = FALSE)
# write.table(MidgeTaxDF, file='MidgeNovTaxTable.tsv', quote=FALSE, sep="\t", row.names = FALSE)
# write.table(TravTaxDF, file='TravChikTaxTable.tsv', quote=FALSE, sep="\t", row.names = FALSE)
# write.table(SRR062415TaxDF, file='SRR062415TaxTable.tsv', quote=FALSE, sep="\t", row.names = FALSE)
# write.table(SRR062462TaxDF, file='SRR062462TaxTable.tsv', quote=FALSE, sep="\t", row.names = FALSE)
