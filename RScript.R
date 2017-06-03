setwd("Important Files/Master's Degree (UoG)/Classes/Thesis")
library(ggplot2)
library(plyr)
library(stringi)

#Read in the file
tab<-read.csv("test.txt",header=TRUE, sep=",")

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

#Build dataframe for boxplot
len = platCounts[2]
df <- data.frame(dose=platforms,
                 len=platCounts[2])

#Change x axis labels (will be fixed further later)
x = 1
xLabs <- seq(x,43,1)
xLabs <- toString(xLabs)
xLabs <- strsplit(xLabs,",")

#Platform counts barplot
p<-ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity") +
  scale_x_discrete(labels=xLabs)
p

#Platforms vs date
ggplot(data=datePlat, aes(x=platforms, y=time)) +
  geom_bar(stat="identity")

