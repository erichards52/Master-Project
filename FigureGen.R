#Set up workspace/load all necessary variables
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

#RUN THE NEXT TWO BATCHES OF CODE ONLY ONCE

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

#Slam must be installed forcefully first or tm package wont work
#DO NOT RUN THIS IF YOU HAVE ALREADY INSTALLED, THIS IS JUST A NOTE
install.packages('devtools')
slam_url <- "https://cran.r-project.org/src/contrib/Archive/slam/slam_0.1-37.tar.gz"
install_url(slam_url)


#HERE BEGINS ANALYSIS 
#------------------------------------------------------------------------------------------------------

#Read in the file
tab<-read.csv("SRAOutput.txt",header=TRUE, sep=",")

#Create Date Variables & format for year
myCreateDates <- as.Date(tab$CreateDate)
myUpdateDates <- as.Date(tab$UpdateDate)
myCreateDates <- as.numeric(format(myCreateDates, "%Y")) 

#Botched code, may return
#datePlat = data.frame(time = factor(platforms), levels=(myCreatDates))

#Create platform variables required
platforms <- levels(tab$Platform)

#Total number of each platform
platCounts = count(tab, 'Platform')
rowsX <- nrow(platCounts)


#Build dataframe for boxplot
len = platCounts[2]
df <- data.frame(dose=platforms,
                 len=platCounts[2])

#Change x axis labels (will be fixed further later)
x = 1
xLabs <- seq(x,rowsX,1)
xLabs <- toString(xLabs)
xLabs <- strsplit(xLabs,",")

#Platform counts barplot
p<-ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity") +
  scale_x_discrete(labels=xLabs)
p

#Word Frequency test 2
#Create shorter variable name
orgNames <- tab$Organism.CommonName.
orgNames<- as.character(orgNames) # to make sure it is text

#Get text ready for analysis, no special characters and such
orgNames <- tolower(orgNames)
orgNames <- tm::removeNumbers(orgNames)
orgNames <- str_replace_all(orgNames, "  ", "") 
orgNames <- str_replace_all(orgNames, pattern = "[[:punct:]]", " ")
orgNames <- tm::removeWords(x = orgNames, stopwords(kind = "SMART"))

#Create corpus & create tdm from corpus using tm package
corpus <- Corpus(VectorSource(orgNames)) 
tdm <- TermDocumentMatrix(corpus) 

#Top 25 organisms
orgFreqs <- freq_terms(text.var = orgNames, top = 25) 

#Prepare vector for for loop
yrs <- c("2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017")

#return pdesired histograms for each year
for (i in yrs)
{
  newtab <- subset(tab, as.numeric(format(as.Date(tab$CreateDate), "%Y")) == i)
  platforms <- levels(newtab$Platform)
  
  #Total number of each platform
  platCounts = count(newtab, 'Platform')
  rowsX <- nrow(platCounts)
  
  #Build dataframe for boxplot
  if (rowsX != 0)
  {
    len = platCounts[2]
    df <- data.frame(dose=platforms,
                     len=platCounts[2])
    
    
    #Change x axis labels (will be fixed further later)
    x = 1
    xLabs <- seq(x,rowsX,1)
    xLabs <- toString(xLabs)
    xLabs <- strsplit(xLabs,",")
    
    #Platform counts barplot
    p<-ggplot(data=df, aes(x=dose, y=len)) +
      geom_bar(stat="identity") +
      scale_x_discrete(labels=xLabs)
    p
    
    #Word Frequency test 2
    #Create shorter variable name
    orgNames <- newtab$Organism.CommonName.
    orgNames<- as.character(orgNames) # to make sure it is text
    
    #Get text ready for analysis, no special characters and such
    orgNames <- tolower(orgNames)
    orgNames <- tm::removeNumbers(orgNames)
    orgNames <- str_replace_all(orgNames, "  ", "") 
    orgNames <- str_replace_all(orgNames, pattern = "[[:punct:]]", " ")
    orgNames <- tm::removeWords(x = orgNames, stopwords(kind = "SMART"))
    
    #Create corpus & create tdm from corpus using tm package
    corpus <- Corpus(VectorSource(orgNames)) 
    tdm <- TermDocumentMatrix(corpus) 
    
    #Top 25 organisms
    orgFreqs <- freq_terms(text.var = orgNames, top = 25)
  } else {
    print("No Relevant Data")
  }
}

#Not yet working, will return
#Platforms vs date
#ggplot(data=datePlat, aes(x=platforms, y=time)) +
# geom_bar(stat="identity")