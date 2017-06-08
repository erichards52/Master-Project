#Set up workspace/load all necessary libraries
setwd("/Users/2274776r/Documents/MastersDegree/Thesis/R/")
library(ggplot2)
library(plyr)
library(stringi)
library(tm)
library(Rgraphviz) 
library(gtools) 
library(XML)
library(qdap) 
library(tm) 
library(SnowballC)
library(RWeka)
library(rJava)
library(RWekajars)  
library(Rstem) 
library(stringr)
library(devtools)
library(slam)
library(setattr)
library(data.table)
library("reshape2")
library(scales)

#RUN THE NEXT TWO BATCHES OF CODE ONLY ONCE
#------------------------------------------------------------------------------
#Packages necessary for text datamining ONLY RUN ONCE
install.packages("gtools", dependencies = T)
install.packages("qdap")
#Answer no to compliation for XML
install.packages("XML")
install.packages("Rgraphviz")
install.packages("SnowballC")
install.packages("RWeka")
install.packages("rJava")
install.packages("RWekajars")
install.packages("Rstem")
install.packages("stringr")
install.packages("slam")
install.packages("reshape2")
install.packages("scales")

#Slam must be installed forcefully first or tm package wont work
#DO NOT RUN THIS IF YOU HAVE ALREADY INSTALLED, THIS IS JUST A NOTE
install.packages('devtools')
slam_url <- "https://cran.r-project.org/src/contrib/Archive/slam/slam_0.1-37.tar.gz"
install_url(slam_url)

#Read in the file
tab<-read.csv("SRATest.txt",header=TRUE, sep=",", 
              quote = "", na.strings = c("", "NA", "n/a"))

#Curation
#------------------------------------------------------------------------------
#Date curation
tab$CreateDate <- as.Date(tab$CreateDate)
tab$CreateDate <- as.numeric(format(tab$CreateDate, "%Y"))
tab$CreateDate <- as.factor(tab$CreateDate)

tab$UpdateDate <- as.Date(tab$UpdateDate)
tab$UpdateDate <- as.numeric(format(tab$UpdateDate, "%Y"))
tab$UpdateDate <- as.factor(tab$UpdateDate)


#Platform curation
tab$Platform <- sub("Illumina NextSeq.*", "Illumina NextSeq", tab$Platform)
tab$Platform <- sub("NextSeq 500", "Illumina NextSeq", tab$Platform)
tab$Platform <- sub("MinION", "Oxford Nanopore", tab$Platform)
tab$Platform <- sub("454.*", "454 GS", tab$Platform)
tab$Platform <- sub("AB 3.*", "AB GA", tab$Platform)
tab$Platform <- sub("AB 5.*", "AB GA", tab$Platform)
tab$Platform <- sub("AB S.*", "AB SOLiD", tab$Platform)
tab$Platform <- sub("Illumina G.*", "Illumina GA", tab$Platform)
tab$Platform <- sub("Illumina HiSeq.*", "Illumina HiSeq", tab$Platform)
tab$Platform <- sub("HiSeq X.*", "Illumina HiSeq", tab$Platform)
tab$Platform <- sub("PacBio.*", "PacBio", tab$Platform)
tab$Platform <- sub("Illumina MiSeq ", "Illumina MiSeq", tab$Platform)
tab$Platform <- sub("BGI.*", "Complete Genomics", tab$Platform)
tab$Platform <- sub("Ion.*", "Ion Torrent", tab$Platform)
tab$Platform <- sub("Illumina HiScanSQ", "Illumina HiSeq", tab$Platform)
tab$Platform <- sub("NextSeq 550", "Illumina NextSeq", tab$Platform)
tab$Platform <- sub("Sequel", "PacBio", tab$Platform)
tab$Platform[tab$Platform == "NA"] <- NA
tab$Platform[tab$Platform == "unspecified"] <- NA

#Define platforms as factors
tab$Platform <- as.factor(tab$Platform)

#Organism curation
tab$Organism.CommonName. <- sub("human", "Homo sapiens", tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("H. sapiens", "Homo sapiens", tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("house mouse", "House Mouse",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("mus musculus", "House Mouse",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("Mus musculus", "House Mouse",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("M. musculus", "House Mouse",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("m. musculus", "House Mouse",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("domesticated barley", "Domesticated Barley",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("thale cress", "Thale Cress",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("arabidopsis thaliana", "Thale Cress",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("baker's yeast", "Baker's Yeast",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("rice", "Rice",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("pneumococcus", "Streptococcus penumoniae",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("human herpesvirus 4", "Epstein-Barr virus",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("human herpesvirus-4", "Epstein-Barr virus",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("HHV-4", "Epstein-Barr virus",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("hhv-4", "Epstein-Barr virus",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("hhv-5", "Human cytomegalovirus",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("HHV-5", "Human cytomegalovirus",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("human herpesvirus-5", "Human cytomegalovirus",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("human herpesvirus 5", "Human cytomegalovirus",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("zebrafish", "Danio rerio",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("Zebrafish", "Danio rerio",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("D. rerio", "Danio rerio",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("D rerio", "Danio rerio",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("d rerio", "Danio rerio",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("d. rerio", "Danio rerio",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("fruit fly", "Fruit fly",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("Drosophila melanogaster", "Fruit fly",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("D. melanogaster", "Fruit fly",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("D melanogaster", "Fruit fly",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("d melanogaster", "Fruit fly",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("d. melanogaster", "Fruit fly",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("ice krill", "Ice krill",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("Euphausia crystallorophias", "Ice krill",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("E crystallorophias", "Ice krill",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("E.crystallorophias", "Ice krill",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("e. crystallorophias", "Ice krill",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("e crystallorophias", "Ice krill",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("Roundworm", "Caenorhabditis elegans",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("roundworm", "Caenorhabditis elegans",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("C elegans", "Caenorhabditis elegans",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("C. elegans", "Caenorhabditis elegans",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("c elegans", "Caenorhabditis elegans",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("c. elegans", "Caenorhabditis elegans",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("Sus scrofa domesticus", "Pig",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("pig", "Pig",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("Sus", "Pig",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("E. coli", "Escherichia coli",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("E coli", "Escherichia coli",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("e. coli", "Escherichia coli",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("e coli", "Escherichia coli",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("cattle", "Cattle",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("Bos taurus", "Cattle",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("B taurus", "Cattle",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("B. taurus", "Cattle",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("Bos primigenius taurus", "Cattle",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("B primigenius taurus", "Cattle",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("B. primigenius taurus", "Cattle",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("horse", "Horse",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("*.sativa japonica.*", "Japanese Rice",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("dog", "Dog",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("Canis lupus familiaris", "Dog",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("Canis familiaris", "Dog",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("C. lupus familiaris", "Dog",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("C. familiaris", "Dog",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("C familiaris", "Dog",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("c. familiaris", "Dog",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("c familiaris", "Dog",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("S. mansoni", "Schistosoma mansoni",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("s. mansoni", "Schistosoma mansoni",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("s mansoni", "Schistosoma mansoni",tab$Organism.CommonName.)
tab$Organism.CommonName. <- sub("s. mansoni", "Schistosoma mansoni",tab$Organism.CommonName.)


#Define organisms as factors
tab$Organism.CommonName. <- as.factor(tab$Organism.CommonName.)

#HERE BEGINS ANALYSIS 
#-----------------------------------------------------------------------

#Platform Analysis
#-----------------------------------------------------------------------

#Create platform variable from levels for plot
platforms <- levels(tab$Platform)

#Total count of each platform ordered
platCounts = count(tab, 'Platform')
platCounts <- platCounts[order(-platCounts$freq),]

#No. rows from platCounts df, necessary for barplot
rowsX <- nrow(platCounts)

#Build dataframe for barplot
len = platCounts[2]
dose=platCounts[1]
df <- data.frame(dose=platCounts[1],
                 len=platCounts[2])
df$Platform <- droplevels(df$Platform)
df$Platform <- reorder(df$Platform, -df$freq)

#Change x axis labels (will be fixed further later)
x = 1
xLabs <- seq(x,rowsX,1)
xLabs <- toString(xLabs)
xLabs <- strsplit(xLabs,",")

#Create platforms barplot
p<-ggplot(data=df, aes(x=df$Platform, y=len)) +
  geom_bar(aes(fill=Platform),stat="identity")+ scale_y_log10() +
  scale_x_discrete(labels=xLabs)

#Add labels
p <- p + labs(x = "Platform")
p <- p + labs(y = "Count (log10)")
p <- p + labs(title = "Number of Datasets Submitted to SRA vs Platform Used")
p <- p + labs(colour = "Platforms") 
p

#Save as PDF
ggsave(p,file='PlatformPlot.pdf', width = 16, height = 9, dpi = 120)
dev.off()

#Organism counts
#------------------------------------------------------------------------------
#organism counts table
orgCounts <- count(tab, 'Organism.CommonName.')
orgCounts <- na.omit(orgCounts)

#Order orgCounts df
orgCounts <- orgCounts[order(-orgCounts$freq),]

#Truncate organism count table to 20 organisms
orgCounts <- orgCounts[1:20,]

#Return organism levels & drop those not needed
orgCounts$Organism.CommonName. <- droplevels(orgCounts$Organism.CommonName.)
orgLev <- levels(orgCounts$Organism.CommonName.)

#Count number of rows in df for organism plot
rowsY <- nrow(orgCounts)

#data frame plot setup
dose = orgCounts[1]
lenOrg = orgCounts[2]
dfOrg <- data.frame(dose=orgCounts[1],
                    lenOrg=orgCounts[2])

#Order levels for plot from greatest to least
orgCounts$Organism.CommonName. <- droplevels(orgCounts$Organism.CommonName.)
orgCounts$Organism.CommonName. <- reorder(orgCounts$Organism.CommonName., -orgCounts$freq)

#Creae 1-20 labels for plot
xOrg = 1
xLabsOrg <- seq(xOrg,rowsY,1)
xLabsOrg <- toString(xLabsOrg)
xLabsOrg <- strsplit(xLabsOrg,",")

#Create organism plot
pOrg<-ggplot(data=dfOrg, aes(x=orgCounts$Organism.CommonName., y=lenOrg)) +
  geom_bar(aes(fill=orgCounts$Organism.CommonName.),stat="identity") + scale_y_log10() +
  scale_x_discrete(labels=xLabsOrg)

#Add labels to plot
pOrg <- pOrg + labs(x = "Organism")
pOrg <- pOrg + labs(y = "Count")
pOrg <- pOrg + labs(title = "Number of Datasets Submitted to SRA vs Organism Used")
pOrg <- pOrg + guides(fill=guide_legend(title="Organisms"))
pOrg

#Save as PDF
ggsave(pOrg,file='BarPlot_Organisms.pdf', width = 16, height = 9, dpi = 120)
dev.off()

#Organism counts WITHOUT HUMAN OR HOUSE MOUSE
#------------------------------------------------------------------------------
#organism counts table
TempDf <- tab[ which(tab$Organism.CommonName. != "Homo sapiens" 
                          & tab$Organism.CommonName.!= "House Mouse"), ]

#organism counts table
orgCountsN <- count(TempDf, 'Organism.CommonName.')
orgCountsN <- na.omit(orgCountsN)

#Order orgCountsN df
orgCountsN <- orgCountsN[order(-orgCountsN$freq),]

#Truncate organism count table to 20 organisms
orgCountsN <- orgCountsN[1:20,]

#Return organism levels & drop those not needed
orgCountsN$Organism.CommonName. <- droplevels(orgCountsN$Organism.CommonName.)
orgLev <- levels(orgCountsN$Organism.CommonName.)

#Count number of rows in df for organism plot
rowsY <- nrow(orgCountsN)

#data frame plot setup
dose = orgCountsN[1]
lenOrg = orgCountsN[2]
dfOrg <- data.frame(dose=orgCountsN[1],
                    lenOrg=orgCountsN[2])

#Order levels for plot from greatest to least
orgCountsN$Organism.CommonName. <- droplevels(orgCountsN$Organism.CommonName.)
orgCountsN$Organism.CommonName. <- reorder(orgCountsN$Organism.CommonName., -orgCountsN$freq)

#Creae 1-20 labels for plot
xOrgN = 1
xLabsOrgN <- seq(xOrgN,rowsY,1)
xLabsOrgN <- toString(xLabsOrgN)
xLabsOrgN <- strsplit(xLabsOrgN,",")

#Create organism plot
pOrgN<-ggplot(data=dfOrg, aes(x=orgCountsN$Organism.CommonName., y=lenOrg)) +
  geom_bar(aes(fill=orgCountsN$Organism.CommonName.),stat="identity") +
  scale_x_discrete(labels=xLabsOrg)

#Add labels to plot
pOrgN <- pOrgN + labs(x = "Organism")
pOrgN <- pOrgN + labs(y = "Count")
pOrgN <- pOrgN + labs(title = "Number of Datasets Submitted to SRA vs Organism Used")
pOrgN <- pOrgN + guides(fill=guide_legend(title="Organisms"))
pOrgN

ggsave(pOrg,file='BarPlot_Organisms_Without.pdf', width = 16, height = 9, dpi = 120)
dev.off()
#Return bases sequenced each year for each platform
#------------------------------------------------------------------------------
#Subsetted df to be used
tabLine <- tab[c(-1,-2,-3,-4,-5,-7,-9,-11,-12)]

#Print total bases for each platform for each year & platform separately
#HiSeq
for (i in 2007:2017)
{
  TempDf <- tabLine[ which(tabLine$CreateDate== i 
                           & tabLine$Platform == "Illumina HiSeq"), ]
  print(sum(TempDf$Bases))
}

#MiSeq
for (i in 2007:2017)
{
  TempDf <- tabLine[ which(tabLine$CreateDate== i 
                           & tabLine$Platform == "Illumina MiSeq"), ]
  print(sum(TempDf$Bases))
}

#454
for (i in 2007:2017)
{
  TempDf <- tabLine[ which(tabLine$CreateDate== i 
                           & tabLine$Platform == "454 GS"), ]
  print(sum(TempDf$Bases))
}

#Illumina GA
for (i in 2007:2017)
{
  TempDf <- tabLine[ which(tabLine$CreateDate== i 
                           & tabLine$Platform == "Illumina GA"), ]
  print(sum(TempDf$Bases))
}

#Illumina NextSeq
for (i in 2007:2017)
{
  TempDf <- tabLine[ which(tabLine$CreateDate== i 
                           & tabLine$Platform == "Illumina NextSeq"), ]
  print(sum(TempDf$Bases))
}

#Ion Torrent
for (i in 2007:2017)
{
  TempDf <- tabLine[ which(tabLine$CreateDate== i 
                           & tabLine$Platform == "Ion Torrent"), ]
  print(sum(TempDf$Bases))
}


#PacBio
for (i in 2007:2017)
{
  TempDf <- tabLine[ which(tabLine$CreateDate== i 
                           & tabLine$Platform == "PacBio"), ]
  print(sum(TempDf$Bases))
}

#AB SOLiD
for (i in 2007:2017)
{
  TempDf <- tabLine[ which(tabLine$CreateDate== i 
                           & tabLine$Platform == "AB SOLiD"), ]
  print(sum(TempDf$Bases))
}

#AB GA
for (i in 2007:2017)
{
  TempDf <- tabLine[ which(tabLine$CreateDate== i 
                           & tabLine$Platform == "AB GA"), ]
  print(sum(TempDf$Bases))
}

#Helicos HeliScope
for (i in 2007:2017)
{
  TempDf <- tabLine[ which(tabLine$CreateDate== i 
                           & tabLine$Platform == "Helicos HeliScope"), ]
  print(sum(TempDf$Bases))
}

#Complete Genomics
for (i in 2007:2017)
{
  TempDf <- tabLine[ which(tabLine$CreateDate== i 
                           & tabLine$Platform == "Complete Genomics"), ]
  print(sum(TempDf$Bases))
}

#Oxford Nanopore
for (i in 2007:2017)
{
  TempDf <- tabLine[ which(tabLine$CreateDate== i 
                           & tabLine$Platform == "Complete Genomics"), ]
  print(sum(TempDf$Bases))
}

#Read in vectors for each platform (sum of bases for each year)
illHiVec <- c(0,435300142357,1.110118e+12,1.301944e+13,8.868507e+13,3.069139e+14,5.185492e+14,
              8.942418e+14,1.343956e+15,5.920494e+15,1.027195e+15)

illMiVec <- c(0,0,0,0,4579783062,360232849428,2.98063e+12,1.033371e+13,2.174921e+13,3.771316e+13,
              3.504216e+13)

fourFive4Vec <- c(20304190150,504330195504,412347894039,1.199467e+12,896339858980,1.178089e+12,
                  895087617393,1.095044e+12,921521568150,1.107635e+12,423538618649)

illGaVec <- c(0,1.883088e+12,8.285528e+12,5.255218e+13,7.710107e+13,1.024544e+14,4.0904e+13,
              3.820102e+13,1.158842e+14,4.472662e+13, 1.053717e+13)

illNextVec <- c(0,0,0,0,0,0,0,64567471447,1.14519e+13,6.20442e+13,4.416607e+13)

torrentVec <- c(0,0,0,0,159324572199,42899822011,249828497366,784729576136,2.651667e+12,5.932476e+12, 
                3.315702e+12)

pacBioVec <- c(0,0,0,0,139661196445,114948437915,364055943231,2.436197e+12,8.899411e+12,1.382035e+13,4.005021e+12)

abSolidVec <- c(0,650853156805,699427118088,8.634524e+12,2.806592e+13,9.092201e+12,6.672864e+12,7.530355e+12,
                5.338548e+12,2.431406e+12,560011174306)

abGaVec <- c(0,0,0,0,16452372720,614725689869,1.509095e+12,4.13447e+12,7.449208e+12,2.519085e+12,920478722053)

helScopeVec <- c(0,0,164027920249,26123605503,114533436072,156103313646,306670430378,1.366621e+12,1.194907e+12,40525032053,
                 28778958900)

comGenVec <- c(0,0,0,1.375607e+12,1.615044e+12,2.87257e+14,4.022169e+14,7.764679e+13,4.671611e+13,5.302391e+13,
               902680687724)

oxNanVec <- c(0,0,0,1.375607e+12,1.615044e+12,2.87257e+14,4.022169e+14,7.764679e+13,4.671611e+13,5.302391e+13,
              902680687724)


#Create list of bases vectors
lst <- list(illHiVec,illMiVec,fourFive4Vec,illGaVec, illNextVec,torrentVec,pacBioVec,abSolidVec,abGaVec,helScopeVec,comGenVec,oxNanVec)

#Define new df with dimensions
lineDF <- data.frame(matrix(nrow = 132, ncol = 3))

#Define column names of df
colnames(lineDF) <- c("Year", "Platform", "Bases")

#Paste bases list into bases column
lineDF$Bases = unlist(lst)

#Create vector of platform names
platVecStr <- c("Illumina HiSeq","Illumina MiSeq","454 GS","Illumina GA","Illumina NextSeq","Ion Torrent",
                "PacBio","AB SOLID","AB GA","Helicos HeliScope","Complete Genomics","Oxford Nanopore")

#Function to repeat platforms & unlist platform list into platforms column
platVecStr<-sapply(platVecStr, function (x) rep(x,11))
platVecStr <- as.vector(platVecStr)
listPlat <- list(platVecStr)

lineDF$Platform = unlist(listPlat)

#Create year vector
yR = 2007
yRS <- seq(yR,2017,1)
yRS <- toString(yRS)
yRS <- strsplit(yRS,",")

#Function to repeat years & unlist years list into years column
yRS<-sapply(yRS, function (x) rep(x,12))
yRS <- as.vector(yRS)
listYrs <- list(yRS)
lineDF$Year = unlist(listYrs)

#Reorder factors by year for line graph
lineDF$Year<- factor(lineDF$Year, levels=unique(as.character(lineDF$Year)) )

#Create Line Graph from df
platPlot <- ggplot(data=lineDF, aes(x=lineDF$Year, y=lineDF$Bases, group=lineDF$Platform)) +
  geom_line(aes(color=lineDF$Platform))+ scale_y_log10() +
  geom_point(aes(color=lineDF$Platform))

#Add labels to line graph
platPlot <- platPlot + labs(x = "Year")
platPlot <- platPlot + labs(y = "Bases (log10)")
platPlot <- platPlot + labs(title = "Number of Bases Sequenced by Each Platform per Year")
platPlot <- platPlot + labs(colour = "Platforms") 
platPlot

#Save plot
ggsave(platPlot,file='BasesPlot.pdf', width = 16, height = 9, dpi = 120)


