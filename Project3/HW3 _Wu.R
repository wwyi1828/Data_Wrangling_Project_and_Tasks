library(dplyr)
library(tidyr)
library(magrittr)
library(ggplot2)
library(stringr)
table2 <- table2
table4a <- table4a
table4b <- table4b
table2 %>% filter(type == "cases") %>% select(country, year, count)
table2 %>% filter(type == "population") %>% select(country, year, count)

table2_storage <- table2 %>% spread(type, count) %>%
    mutate(prevalence=cases/population*10000)

#2. The correct code is as follows:
table4a %>% gather("year", "cases",2:3) 
#The reason why the original code is wrong is that its argument about position is wrong.

#3.
#a
library(nycflights13)
flights <- flights
flights %>% select(year,month,day,flight)
sum <- c()
date_fy <- flights %>% mutate(date = paste(year,"/",month,"/",day))
date_fy$date %<>% as.Date(format = "%Y / %m / %d")
date_fy %>% group_by(date) %>% 
  summarise(SUM = sum(air_time,na.rm=T),MEAN=mean(air_time,na.rm=T)) %>%
  ggplot(aes(x = date, y = MEAN)) +
  geom_line()

#The total times is stable before octorber, and increase after octorber.

#b 
date_fy[which(nchar(date_fy$dep_time)==3),] <- date_fy %>% 
  filter(nchar(date_fy$dep_time)==3) %>% 
  mutate(dep_time=paste("0",dep_time,sep=""))
date_fy[which(nchar(date_fy$dep_time)==2),] <- date_fy %>% 
  filter(nchar(date_fy$dep_time)==2) %>% 
  mutate(dep_time=paste("00",dep_time,sep=""))
date_fy[which(nchar(date_fy$sched_dep_time)==3),] <- date_fy %>% 
  filter(nchar(date_fy$sched_dep_time)==3) %>% 
  mutate(sched_dep_time=paste("0",sched_dep_time,sep=""))

date_fy$dep_min <- as.numeric(substr(date_fy$dep_time,1,2))*60 + as.numeric(substr(date_fy$dep_time,3,4))
date_fy$sched_dep_min <- as.numeric(substr(date_fy$sched_dep_time,1,2))*60 + as.numeric(substr(date_fy$sched_dep_time,3,4))
date_fy %<>% mutate(dif=dep_min-sched_dep_min-dep_delay)
date_fy$dif %>% as.factor() %>% summary()
problems <- date_fy %>% filter(dif!=0) %>% select(dep_time,sched_dep_time,dep_min,sched_dep_min,dep_delay,dif)
#From what we discussed above, we can find that depature time euquals scheduled depature time plus depature deplay in most cases.
#However, for some cases, the difference value between them is -1440 minutes(-24 hours), which means the depature time which shows in the table
#is in the next day(+24h). Therefore, they are consistent.
#c
attach(date_fy)
date_fy$group <- ifelse((minute>20&minute<30)|(minute>50&minute<60),1,0)
date_fy$delay_sts <- ifelse(dep_delay>0,1,0)
date_fy %>% group_by(group) %>% 
  summarise(delay=sum(delay_sts,na.rm=T),
            total=n())

#4.
library(rvest)
scraping_qbs <-  read_html("https://geiselmed.dartmouth.edu/qbs/")
head(scraping_qbs)
h1_text <- scraping_qbs %>% html_nodes("h1") %>%html_text()
h2_text <- scraping_qbs %>% html_nodes("h2") %>%html_text()
h3_text <- scraping_qbs %>% html_nodes("h3") %>%html_text()
h4_text <- scraping_qbs %>% html_nodes("h4") %>%html_text()
p_nodes <- scraping_qbs %>%html_nodes("p")
p_nodes[1:6]

p_text <- scraping_qbs %>% html_nodes("p") %>%html_text()
length(p_text)

ul_text <- scraping_qbs %>% html_nodes("ul") %>%html_text()
length(ul_text)

ul_text[1]
substr(ul_text[2],start=5,stop=14)
li_text <- scraping_qbs %>% html_nodes("li") %>%html_text()
length(li_text)
li_text[1:8]
lii_text <- scraping_qbs %>% html_nodes("lii") %>%html_text()
table_text<-scraping_qbs %>% html_nodes("table") %>%html_text()
# all text irrespecive of headings, paragrpahs, lists, ordered list etc..
all_text <- scraping_qbs %>%
  html_nodes("div") %>% 
  html_text()
p_text