setwd("C:/Users/q8247/OneDrive/Attachment/Work Space/Data Wrangling/Final")
library(dplyr)
library(magrittr)
library(RODBC)
myconn <- odbcConnect('dartmouth','wwu','wwu@qbs181')
A <- sqlQuery(myconn,"select * from Demographics")
B <- sqlQuery(myconn,"select * from ChronicConditions")
C <- sqlQuery(myconn,"select * from Text")
names(A)[1] <- "id"
names(B)[1] <- "id"
names(C)[1] <- "id"

AB <- merge(A,B,by='id')
ABC <- merge(AB,C,by='id')
ABC %<>% group_by(id) %>% slice(which.max(TextSentDate))
