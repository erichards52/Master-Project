#Set up workspace/load all necessary libraries
#This needs to be run every time the script is opened

#If you wish to generate the markdown document, simply run all code
#in this script EXCEPT for the last batch (last batch installs necessary libraries)
setwd("/Users/2274776r/Documents/MastersDegree/Thesis/R/")
library(ggplot2)
library(plyr)
library(stringi)
library(tm)
library(Rgraphviz) 
library(gtools) 
library(XML)
library(qdap) 
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
library("wordcloud")
library("RColorBrewer")
library(rmarkdown)
library(knitr)
library(markdown)

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
#Read in taxonomy txt produced via eutils (NCBI TAXONOMY)
taxMerg<-read.csv("taxTest.txt",header=TRUE, sep=",", 
                  quote = "", na.strings = c("", "NA", "n/a"))
tab <- merge(tab, taxMerg, by.x = "Organism.TaxID.", by.y = "ID")
tab <- merge(tab, taxMerg)

#Define organisms as factors
tab$Scientific.Name <- as.factor(tab$Scientific.Name)

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
rownames(df) <- NULL


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
orgCounts <- count(tab, 'Scientific.Name')
orgCounts <- na.omit(orgCounts)

#Order orgCounts df
orgCounts <- orgCounts[order(-orgCounts$freq),]

#Truncate organism count table to 20 organisms
orgCounts <- orgCounts[1:20,]

#Return organism levels & drop those not needed
orgCounts$Scientific.Name <- droplevels(orgCounts$Scientific.Name)
orgLev <- levels(orgCounts$Scientific.Name)

#Count number of rows in df for organism plot
rowsY <- nrow(orgCounts)

#data frame plot setup
dose = orgCounts[1]
lenOrg = orgCounts[2]
dfOrg <- data.frame(dose=orgCounts[1],
                    lenOrg=orgCounts[2])

#Order levels for plot from greatest to least
dfOrg$Scientific.Name <- droplevels(dfOrg$Scientific.Name)
dfOrg$Scientific.Name <- reorder(dfOrg$Scientific.Name, -dfOrg$freq)


orgCounts$Scientific.Name <- droplevels(orgCounts$Scientific.Name)
orgCounts$Scientific.Name <- reorder(orgCounts$Scientific.Name, -orgCounts$freq)
rownames(orgCounts) <- NULL

#Creae 1-20 labels for plot
xOrg = 1
xLabsOrg <- seq(xOrg,rowsY,1)
xLabsOrg <- toString(xLabsOrg)
xLabsOrg <- strsplit(xLabsOrg,",")

#Create organism plot
pOrg<-ggplot(data=dfOrg, aes(x=dfOrg$Scientific.Name, y=lenOrg)) +
  geom_bar(aes(fill=dfOrg$Scientific.Name),stat="identity") + scale_y_log10() +
  scale_x_discrete(labels=xLabsOrg)

#Add labels to plot
pOrg <- pOrg + labs(x = "Organism")
pOrg <- pOrg + labs(y = "Count (log10)")
pOrg <- pOrg + labs(title = "Number of Datasets Submitted to SRA vs Organism Used")
pOrg <- pOrg + guides(fill=guide_legend(title="Organisms"))
pOrg

#Save as PDF
ggsave(pOrg,file='BarPlot_Organisms.pdf', width = 16, height = 9, dpi = 120)
dev.off()

#Organism counts WITHOUT HUMAN OR HOUSE MOUSE
#------------------------------------------------------------------------------
#organism counts table
TempDf <- tab[ which(tab$Scientific.Name != "Homo sapiens" 
                     & tab$Scientific.Name!= "Mus musculus"), ]

#organism counts table
orgCountsN <- count(TempDf, 'Scientific.Name')
orgCountsN <- na.omit(orgCountsN)

#Order orgCountsN df
orgCountsN <- orgCountsN[order(-orgCountsN$freq),]

#Truncate organism count table to 20 organisms
orgCountsN <- orgCountsN[1:20,]

#Return organism levels & drop those not needed
orgCountsN$Scientific.Name <- droplevels(orgCountsN$Scientific.Name)
orgLev <- levels(orgCountsN$Scientific.Name)

#Count number of rows in df for organism plot
rowsY <- nrow(orgCountsN)

#data frame plot setup
dose = orgCountsN[1]
lenOrg = orgCountsN[2]
dfOrg <- data.frame(dose=orgCountsN[1],
                    lenOrg=orgCountsN[2])

#Order levels for plot from greatest to least
orgCountsN$Scientific.Name <- droplevels(orgCountsN$Scientific.Name)
orgCountsN$Scientific.Name <- reorder(orgCountsN$Scientific.Name, -orgCountsN$freq)

#Creae 1-20 labels for plot
xOrgN = 1
xLabsOrgN <- seq(xOrgN,rowsY,1)
xLabsOrgN <- toString(xLabsOrgN)
xLabsOrgN <- strsplit(xLabsOrgN,",")

#Create organism plot
pOrgN<-ggplot(data=dfOrg, aes(x=orgCountsN$Scientific.Name, y=lenOrg)) +
  geom_bar(aes(fill=orgCountsN$Scientific.Name),stat="identity") +
  scale_x_discrete(labels=xLabsOrg)

#Add labels to plot
pOrgN <- pOrgN + labs(x = "Organism")
pOrgN <- pOrgN + labs(y = "Count")
pOrgN <- pOrgN + labs(title = "Number of Datasets Submitted to SRA vs Organism Used")
pOrgN <- pOrgN + guides(fill=guide_legend(title="Organisms"))
pOrgN

ggsave(pOrgN,file='BarPlot_Organisms_Without.pdf', width = 16, height = 9, dpi = 120)
dev.off()
#Return bases sequenced each year for each platform
#------------------------------------------------------------------------------
#Subsetted df to be used
tabLine <- tab[c(-1,-2,-3,-4,-5,-6,-8,-10,-12,-13,-14)]

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

#Model organism metadata - Rat species plot
#--------------------------------------------------------------
#Return all rows which use "Rattus" taxID
ratDat <- c(which(grepl("^Rattus*", tab$Scientific.Name)))

#Create dataframe
ratDat <- as.data.frame(tab[c(ratDat),])
ratDat <- as.data.frame(ratDat, row.names = NULL)

#Return organism levels & drop those not needed
ratDat$Scientific.Name <- droplevels(ratDat$Scientific.Name)
ratLev <- levels(ratDat$Organism.CommonName.)

#organism counts table
ratDescCount <- count(ratDat, 'Scientific.Name')
ratDescCount <- na.omit(ratDescCount)

#Order ratDescCount df
ratDescCount <- ratDescCount[order(-ratDescCount$freq),]
rownames(ratDescCount) <- NULL

#Subset Counts df to only include norvegicus and BLANK
# ratDescCount <- ratDescCount[ which(ratDescCount$Scientific.Name != "Rattus leucopus"),]
# ratDescCount <- ratDescCount[ which(ratDescCount$Scientific.Name != "Rattus fuscipes"),]
# ratDescCount <- ratDescCount[ which(ratDescCount$Scientific.Name != "Rattus rattus"),]
# ratDescCount <- ratDescCount[ which(ratDescCount$Scientific.Name != "Rattus sordidus"),]
# ratDescCount <- ratDescCount[ which(ratDescCount$Scientific.Name != "Rattus tunneyi"),]
# ratDescCount <- ratDescCount[ which(ratDescCount$Scientific.Name != "Rattus villosissimus"),]

#Truncate organism count table to 9 rat species (only those that exist)
# ratDescCount <- ratDescCount[1:2,]
# 
# #Count number of rows in df for organism plot
# rowsY <- nrow(ratDescCount)
# 
# #data frame plot setup
# dose = ratDescCount[1]
# lenOrg = ratDescCount[2]
# ratDF <- data.frame(dose=ratDescCount[1],
#                     lenOrg=ratDescCount[2])
# 
# 
# #Creae 1-20 labels for plot
# ratN = 1
# ratRowN <- seq(ratN,rowsY,1)
# ratRowN <- toString(ratRowN)
# ratRowN <- strsplit(ratRowN,",")
# 
# #Create rat barplot
# ratPlot<-ggplot(data=ratDF, aes(x=ratDescCount$Scientific.Name, y=lenOrg)) +
#   geom_bar(aes(fill=ratDescCount$Scientific.Name),stat="identity") + scale_y_log10() +
#   scale_x_discrete(labels=ratRowN)
# 
# #Add labels to plot
# ratPlot <- ratPlot + labs(x = "Rat Species")
# ratPlot <- ratPlot + labs(y = "Count")
# ratPlot <- ratPlot + labs(title = "Rat Species vs Dataset Count")
# ratPlot <- ratPlot + guides(fill=guide_legend(title="Rat Species"))
# ratPlot
# 
# ggsave(ratPlot,file='BarPlot_RatDesc.pdf', width = 16, height = 9, dpi = 120)
# dev.off()

#Model organism metadata (rat WordCloud)
#---------------------------------------------------
#Return all datasets which use "rat" as an organism
ratDat <- c(which(grepl("^Rattus*", tab$Scientific.Name)))
ratDat <- as.data.frame(tab[c(ratDat),])
ratDat <- as.data.frame(ratDat)

#Return rats which aren't firebrat
ratLev <- levels(ratDat$Scientific.Name)

#Turn into df
ratDat <- as.data.frame(ratDat) 

#Turn design column into corpus
docs <- Corpus(VectorSource(ratDat$Design))

#Create function to get rid of unnessecary chars
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, ",")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

#Return top 20
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 20)

#WordCloud creation for rat design
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

#Create taxonomic ID frequency plot
#--------------------------------------
#organism counts table
# taxCounts <- count(tab, 'Organism.TaxID.')
# taxCounts <- na.omit(taxCounts)
# 
# #Order taxCounts df
# taxCounts <- taxCounts[order(-taxCounts$freq),]
# 
# #Truncate organism count table to 20 organisms
# taxCounts <- taxCounts[1:20,]
# 
# #Return organism levels & drop those not needed
# taxLev <- levels(taxCounts$Organism.TaxID.)
# 
# #Count number of rows in df for organism plot
# rowsY <- nrow(taxCounts)
# 
# #data frame plot setup
# dose = taxCounts[1]
# lenOrg = taxCounts[2]
# dfOrg <- data.frame(dose=taxCounts[1],
#                     lenOrg=taxCounts[2])
# 
# dfOrgTax <- merge(dfOrg, taxMerg, by.x = "Organism.TaxID.", by.y = "ID")
# dfOrgTax <- dfOrgTax[c(-1)]
# 
# #Order levels for plot from greatest to least
# dfOrgTax <- dfOrgTax[with(dfOrgTax, order(-dfOrgTax$freq, dfOrgTax$Scientific.Name)),]
# 
# #Creae 1-20 labels for plot
# xTax = 1
# xTaxN <- seq(xTax,rowsY,1)
# xTaxN <- toString(xTaxN)
# xTaxN <- strsplit(xTaxN,",")
# 
# #Create organism plot
# taxPlot<-ggplot(data=dfOrgTax, aes(x=dfOrgTax$Scientific.Name, y=lenOrg)) +
#   geom_bar(aes(fill=dfOrgTax$Scientific.Name),stat="identity") +
#   scale_x_discrete(labels=xTaxN)
# 
# #Add labels to plot
# taxPlot <- taxPlot + labs(x = "Organisms")
# taxPlot <- taxPlot + labs(y = "Count")
# taxPlot <- taxPlot + labs(title = "Number of Datasets Submitted to SRA vs TaxID")
# taxPlot <- taxPlot + guides(fill=guide_legend(title="Organisms"))
# taxPlot
# 
# ggsave(taxPlot,file='Tax_BarPlot.pdf', width = 16, height = 9, dpi = 120)
# dev.off()

#RMarkdown
#------------------------------------------------------------------------------------
render("SRACharMarkdown_16_June_2017.Rmd", "all")

#RUN THE NEXT BATCH OF CODE BETWEEN THESE LINES ONLY ONCE IF YOU HAVE NEVER RUN IT BEFORE
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
install.packages("wordcloud")
install.packages("SnowballC")
install.packages("RColorBrewer")
install.packages("reutils")

#Slam must be installed forcefully first or tm package wont work
install.packages('devtools')
slam_url <- "https://cran.r-project.org/src/contrib/Archive/slam/slam_0.1-37.tar.gz"
install_url(slam_url)

#Use eutils for returning scientific name
#Vector unique taxIDs
dfUniTax <- c(unique(tab$Organism.TaxID.))
dfUniTax <- na.omit(dfUniTax)
write(dfUniTax, file="TaxID.txt", sep = "\n")
#------------------------------------------------------------------------------