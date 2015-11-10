---
title: "Sentiments in ASOIAF"
author: "Patrick Wynne"
date: "November 10, 2015"
published: true
status: publish
draft: false
output: html_document
tags: Text Mining
---
 
 
 

{% highlight r %}
library(dplyr)
library(tidyr)
library(repmis)
library(stargazer)
library(knitr)
library(ggplot2)
library(syuzhet)
 
GOT <- source_DropboxData(file = "A-Game-Of-Thrones-George-R.-R.-Martin.csv", 
                              key = "kogv0pl0oz2f5bq", header = F)
 
COK <- source_DropboxData(file = "A-Clash-of-Kings-George-R.-R.-Martin_1.csv", 
                          key = "grodz0gwxtb30k2", header = F)
 
SOS <- source_DropboxData(file = "A-Storm-of-Swords-George-R.-R.-Martin_1.csv", 
                                    key = "qw0pezfm8n6v1ub", header = F)
 
FFC <- source_DropboxData(file = "A-Feast-for-Crows-George-R.-R.-Martin_1.csv", 
                                    key = "k5l1226drbldu1l", header = F)
 
DWD <- source_DropboxData(file = "A-Dance-With-Dragons-George-RR-Martin_1.csv", 
                                    key = "789sbl95faxcvnj", header = F)
 
 
CleanAndSentiment <- function(arg1, x){
        arg2 <- arg1[arg1$V1 != "",] #remove empty rows
        arg2 <- arg2[-(1:ifelse(is.na(which(arg2=="Prologue")[2]),which(arg2=="Prologue"),which(arg2=="Prologue")[2]))] #start file at prologue
        arg2 <- arg2[1:ifelse((which(arg2=="Appendix")<1000),length(arg2),which(arg2=="Appendix"))] #end file at Appendix
        arg3 <- arg2%>%
                get_nrc_sentiment(.)%>%
                t(.)%>%
                data.frame(.)%>%
                rowSums(.)%>%
                data.frame(.)
        names(arg3)[1] <- "count"
        arg3 <- cbind("sentiment" = rownames(arg3), arg3)
        rownames(arg3) <- NULL
        arg3 <- arg3[1:8,]
        arg4 <- arg3%>%
                mutate(Percent = (count/sum(count))*100,
                       Book = x)
        return(arg4)
}
 
GOTSentiment <- CleanAndSentiment(GOT, "Game of Thrones")
 
COKSentiment <- CleanAndSentiment(COK, "Clash of Kings")
 
SOSSentiment <- CleanAndSentiment(SOS, "Storm of Swords")
 
FFCSentiment <- CleanAndSentiment(FFC, "Feast for Crows")
 
DWDSentiment <- CleanAndSentiment(DWD, "Dance with Dragons")
 
ASOIAF <- bind_rows(GOTSentiment,COKSentiment,SOSSentiment,FFCSentiment,DWDSentiment)
 
ASOIAF$Book <- as.factor(ASOIAF$Book)
 
levels(ASOIAF$Book) <- c("Game of Thrones", "Clash of Kings", "Storm of Swords", 
                         "Feast for Crows", "Dance with Dragons")
 
 
 
ASOIAF$sentiment <- factor(ASOIAF$sentiment,levels = c("trust", "fear", "anticipation", "sadness", "disgust", 
                                                                       "joy", "anger", "surprise", "negative", "positive"))
 
 
 
ggplot(ASOIAF,aes(x=Book, y=Percent, color=sentiment, group = sentiment)) + 
        geom_line(aes(group = sentiment),size = 1) + geom_point() + ggtitle("Sentiments in ASOIAF") + 
        theme(text = element_text(size=14), legend.text = element_text(size = 14),
              axis.text.y=element_text(colour="black"), 
              axis.text.x = element_text(colour = 'black', angle = 90, size = 13, hjust = 0.5, vjust = 0.5)) +
        scale_colour_brewer(palette="Set1")
{% endhighlight %}

![plot of chunk unnamed-chunk-1](/figures/unnamed-chunk-1-1.png) 
 
