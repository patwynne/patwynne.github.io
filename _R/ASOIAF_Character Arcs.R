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

which(GOT=="Bran")

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

ggplot(ASOIAF,aes(x=Book, y=Percent, color=sentiment, group = sentiment)) + 
        geom_line() + geom_point() + ggtitle("Sentiments in A Song of Ice and Fire Through Book Five")




str(ASOIAF)



CharacterSentiment <- function(novel, title, povcharacter){
        novel <- novel[novel$V1 != "",] #remove empty rows
        arg2 <- novel[-(1:ifelse(is.na(which(novel=="Prologue")[2]),
                                 which(novel=="Prologue"),which(novel=="Prologue")[2]))] #start file at prologue
        arg2 <- arg2[1:ifelse((which(arg2=="Appendix")<1000),length(arg2),
                              which(arg2=="Appendix"))] #end file at Appendix
        characterindex <- which(arg2==povcharacter) # creates an index of where a particular characterschapters start
        chaptertitles <- novel[(1:ifelse(is.na(which(novel=="Prologue")[2]),
                                        which(novel=="Prologue"),which(novel=="Prologue")[2]))]
        chapterlocations <- arg2[which(arg2 %in% chaptertitles)]
        
        
        
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


GOT2 <- GOT[GOT$V1 != "",] #remove empty rows
GOT3 <- GOT2[-(1:ifelse(is.na(which(GOT2=="Prologue")[2]),(which(GOT2=="Prologue")-1),(which(GOT2=="Prologue")[2])-1))] #start file at prologue
Novel <- GOT3[1:ifelse((which(GOT3=="Appendix")<1000),length(GOT3),which(GOT3=="Appendix"))] #end file at Appendix

chapterindex <- GOT2[(1:ifelse(is.na(which(GOT2=="Prologue")[2]),which(GOT2=="Prologue"),which(GOT2=="Prologue")[2]))]
characterindex <- which(Novel=="Bran")

ChapterTitles <- names(table(Novel[which(Novel %in% chapterindex)]))
ChapterRows <- which(Novel %in% ChapterTitles)

df <- data.frame(Date=as.Date(character()),
                 File=character(), 
                 User=character(), 
                 stringsAsFactors=FALSE) 

str(df)

NovelbyChapter <-  list()
NBC <- data.frame(NULL)

for (i in 1:(length(ChapterRows)-1)){
        NovelbyChapter[[i]] <- Novel[ChapterRows[i]:ChapterRows[i+1]]
        NBC[,i] <- Novel[ChapterRows[i]:ChapterRows[i+1]]
}

NovelbyChapterDF <- as.data.frame(t(do.call(rbind.data.frame, NovelbyChapter)))

row.names(NovelbyChapterDF) <- NULL

str(NovelbyChapter)

NovelbyChapterDF <- data.frame(matrix(unlist(NovelbyChapter)))
x=matrix(data=NA, nrow=n, ncol=k)


Bran <- data.frame(Novel[characterindex[i]:!is.na()]
data.frame(NovelbyChapter)

cbind(NovelbyChapter, Novel[ChapterRows[i]:ChapterRows[i+1]])

