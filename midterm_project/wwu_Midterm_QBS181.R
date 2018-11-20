setwd("D:/Program Files (x86)/QBS Hw/Data Wrangling/Midterm")
library(dplyr)
library(magrittr)
library(foreign)
library(Hmisc)
data <- sasxport.get("DIQ_I.xpt")
str(data)
#write.csv(data,file = "data.csv")

#diq010_1 <- data %>% filter(diq010==1) %>%
#  select(-starts_with("diq175")) %>% select(-7:-4)

#I estimate the "don't know" data by mean, and view "refused" as NA.
attach(data)
data$did040[data$did040==666] <- 1
data$did040[data$did040==999] <- data %>%
  filter(diq040!=999) %>% .$diq040 %>% mean()
summary(data$did040)

data$diq050[data$diq050==7] <- NA
data$diq050[diq050==9] <- NA
#data$diq050 %<>% as.factor()
#summary(data$diq050)



data$did060[data$did060==666] <- 0.5
data$diq060u[data$diq060u==2] <- 12
data[which(did060!=999),] %<>% mutate(did060=did060*diq060u)
data$did060[did060==999] <- data %>%
  filter(did060!=999) %>% .$did060 %>% mean()
summary(data$did060)



data$diq230[data$diq230==5] <- 0
data$diq230[data$diq230==9] <- NA
#data$diq230 %<>% as.factor()
#summary(data$diq230)

#diq240 %<>% as.factor()
#summary(diq240)

did250[did250==9999] <- 4.508
summary(did250)

data$diq260u[is.na(diq260u)] <- 0
data$diq260u[diq260u==2] <- 7
data$diq260u[diq260u==3] <- 30
data$diq260u[diq260u==4] <- 365
data[which(did260!=999),] %<>% mutate(did260=did260*diq260u)
data$did260[did260==999] <- data %>%
  filter(did260!=999) %>% .$did260 %>% mean()
summary(data$did260)

data$diq275[data$diq275==9] <- NA
#data$diq275 %<>% as.factor()
#data$diq275 %>% summary()

data$diq280[diq280==777] <- NA
data$diq280[diq280==999] <- data %>%
  filter(diq280!=999) %>% .$diq280 %>% mean()
summary(data$diq280)


#data$diq291 %<>% as.factor() 
#data$diq291 %>% summary()

data$diq300s[diq300s==7777] <- NA
data$diq300s[diq300s==9999] <- data %>%
  filter(diq300s!=9999) %>% .$diq300s %>% mean()
summary(data$diq300s)

data$diq300d[diq300d==7777] <- NA
data$diq300d[diq300d==9999] <- data %>%
  filter(diq300d!=9999) %>% .$diq300d %>% mean()
summary(data$diq300d)

data$did310s[did310s==7777] <- NA
data$did310s[did310s==6666] <- NA
data$did310s[did310s==9999] <- data %>%
  filter(did310s!=9999) %>% .$did310s %>% mean()
summary(data$did310s)

data$did310d[did310d==7777] <- NA
data$did310d[did310d==6666] <- NA
data$did310d[did310d==9999] <- data %>%
  filter(did310d!=9999) %>% .$did310d %>% mean()
summary(data$did310d)

data$did320[did320==7777] <- NA
data$did320[did320==6666] <- NA
data$did320[did320==5555] <- NA
data$did320[did320==9999] <- data %>%
  filter(did320!=9999) %>% .$did320 %>% mean()
summary(data$did320)

data$did330[did330==7777] <- NA
data$did330[did330==9999] <- data %>%
  filter(did330!=9999) %>% .$did330 %>% mean()
summary(data$did330)

data$did341[did341==7777] <- NA
data$did341[did341==6666] <- NA
data$did341[did341==9999] <- data %>%
  filter(did341!=9999) %>% .$did341 %>% mean()
summary(data$did341)

data$diq350u[is.na(diq350u)] <- 0
data$diq350u[diq350u==2] <- 7
data$diq350u[diq350u==3] <- 30
data$diq350u[diq350u==4] <- 365
data[which(did350!=9999),] %<>% mutate(did350=did350*diq350u)
data$did350[did350==9999] <- data %>%
  filter(did350!=9999) %>% .$did350 %>% mean()
summary(data$did350)

data$diq360 %<>% as.character()
table(data$diq360)

data$diq080 %<>% as.character()
table(data$diq080)
data[diq010==1,][c(1:3,5:6)]



#-500 means the subjects didn't be asked this question.

#check item 1
data[which(did040<12|diq010==1),][4:31] <- -500
data[which(did040>=12 & diq010==3),][4] <- -500
#check item 2
data[which(diq010!=3&diq010!=1&diq160!=1),][35:54] <- -500
#check item 3
data[which(diq010==3|diq160==1),][36:54] <- -500
#check item 4
data[which(did040<12),][44:54] <- -500
