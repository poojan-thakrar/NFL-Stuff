library(readxl)
library(dplyr)
library(XML)
library(xml2)
library(rvest)
library(magrittr)
library(ggplot2)


#Gather Data
FantasyData2017 <- read_excel("Fantasy Football/Raw Fantasy Data 10 years.xlsx", sheet = 2)%>%select(Name, Team, Position, `Fantasy Points`, `Fantasy PosRank`)
FantasyData2016 <- read_excel("Fantasy Football/Raw Fantasy Data 10 years.xlsx", sheet = 3)%>%select(Name, Team, Position, `Fantasy Points`, `Fantasy PosRank`)
FantasyData2015 <- read_excel("Fantasy Football/Raw Fantasy Data 10 years.xlsx", sheet = 4)%>%select(Name, Team, Position, `Fantasy Points`, `Fantasy PosRank`)
FantasyData2014 <- read_excel("Fantasy Football/Raw Fantasy Data 10 years.xlsx", sheet = 5)%>%select(Name, Team, Position, `Fantasy Points`, `Fantasy PosRank`)
FantasyData2013 <- read_excel("Fantasy Football/Raw Fantasy Data 10 years.xlsx", sheet = 6)%>%select(Name, Team, Position, `Fantasy Points`, `Fantasy PosRank`)
FantasyData2012 <- read_excel("Fantasy Football/Raw Fantasy Data 10 years.xlsx", sheet = 7)%>%select(Name, Team, Position, `Fantasy Points`, `Fantasy PosRank`)

############

#Method
#See the Pos Ranks of QBs after 10, WRs after 25, RBs after 25
#Pick all QBs, RBs, WRs with ADP 100-168. Select the top three PosRanks, average them, see what's best.


################# 2017 ################# 

####### Web Scraping ####### 
url2017 <- 'https://fantasyfootballcalculator.com/adp/standard/12-team/all/2017'
download.file(url2017, 'data2017.html')
DraftData2017 <- readHTMLTable('data2017.html')$`NULL`%>%select(`#`, Name, Pos)

#QB
QBBData2017 <- DraftData2017%>%filter(Pos == "QB")
QBBData2017 <- cbind(QBBData2017,c(1:nrow(QBBData2017)))
colnames(QBBData2017)[4] <- "Pos ADP Rank"


#RB
RBData2017 <- DraftData2017%>%filter(Pos == "RB")
RBData2017 <- cbind(RBData2017,c(1:nrow(RBData2017)))
colnames(RBData2017)[4] <- "Pos ADP Rank"

#WR
WRData2017 <- DraftData2017%>%filter(Pos == "WR")
WRData2017 <- cbind(WRData2017,c(1:nrow(WRData2017)))
colnames(WRData2017)[4] <- "Pos ADP Rank"

ADP2017 <- rbind(QBBData2017, RBData2017, WRData2017)

###### Combine Tables ###### 
FantasyData2017$PositionADP <- rep(0)
for(i in 1:nrow(FantasyData2017)){
  for(j in 1:nrow(ADP2017)){
    if(FantasyData2017$Name[i] == ADP2017$Name[j])
      FantasyData2017$PositionADP[i] <- ADP2017$`Pos ADP Rank`[j]
  }
}
FantasyData2017 <- FantasyData2017%>%filter(PositionADP >0 & `Fantasy PosRank`<100)
QBFantasyData2017 <- FantasyData2017%>%filter(Position == "QB")
RBFantasyData2017 <- FantasyData2017%>%filter(Position == "RB")
WRFantasyData2017 <- FantasyData2017%>%filter(Position == "WR")

########## Graphs ##########
ggplot(data = FantasyData2017, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_point(aes(color = Position)) + geom_text(label = FantasyData2017$Name)

ggplot(data = QBFantasyData2017, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = QBFantasyData2017$Name)

ggplot(data = RBFantasyData2017, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = RBFantasyData2017$Name)

ggplot(data = WRFantasyData2017, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = WRFantasyData2017$Name)

################# 2016 ################# 

####### Web Scraping ####### 
url2016 <- 'https://fantasyfootballcalculator.com/adp/standard/12-team/all/2016'
download.file(url2016, 'data2016.html')
DraftData2016 <- readHTMLTable('data2016.html')$`NULL`%>%select(`#`, Name, Pos)

#QB
QBBData2016 <- DraftData2016%>%filter(Pos == "QB")
QBBData2016 <- cbind(QBBData2016,c(1:nrow(QBBData2016)))
colnames(QBBData2016)[4] <- "Pos ADP Rank"


#RB
RBData2016 <- DraftData2016%>%filter(Pos == "RB")
RBData2016 <- cbind(RBData2016,c(1:nrow(RBData2016)))
colnames(RBData2016)[4] <- "Pos ADP Rank"

#WR
WRData2016 <- DraftData2016%>%filter(Pos == "WR")
WRData2016 <- cbind(WRData2016,c(1:nrow(WRData2016)))
colnames(WRData2016)[4] <- "Pos ADP Rank"

ADP2016 <- rbind(QBBData2016, RBData2016, WRData2016)

###### Combine Tables ###### 
FantasyData2016$PositionADP <- rep(0)
for(i in 1:nrow(FantasyData2016)){
  for(j in 1:nrow(ADP2016)){
    if(FantasyData2016$Name[i] == ADP2016$Name[j])
      FantasyData2016$PositionADP[i] <- ADP2016$`Pos ADP Rank`[j]
  }
}
FantasyData2016 <- FantasyData2016%>%filter(PositionADP >0 & `Fantasy PosRank`<100)
QBFantasyData2016 <- FantasyData2016%>%filter(Position == "QB")
RBFantasyData2016 <- FantasyData2016%>%filter(Position == "RB")
WRFantasyData2016 <- FantasyData2016%>%filter(Position == "WR")

########## Graphs ##########
ggplot(data = FantasyData2016, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_point(aes(color = Position)) + geom_text(label = FantasyData2016$Name)

ggplot(data = QBFantasyData2016, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = QBFantasyData2016$Name)

ggplot(data = RBFantasyData2016, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = RBFantasyData2016$Name)

ggplot(data = WRFantasyData2016, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = WRFantasyData2016$Name)


################# 2015 ################# 

####### Web Scraping ####### 
url2015 <- 'https://fantasyfootballcalculator.com/adp/standard/12-team/all/2015'
download.file(url2015, 'data2015.html')
DraftData2015 <- readHTMLTable('data2015.html')$`NULL`%>%select(`#`, Name, Pos)

#QB
QBBData2015 <- DraftData2015%>%filter(Pos == "QB")
QBBData2015 <- cbind(QBBData2015,c(1:nrow(QBBData2015)))
colnames(QBBData2015)[4] <- "Pos ADP Rank"


#RB
RBData2015 <- DraftData2015%>%filter(Pos == "RB")
RBData2015 <- cbind(RBData2015,c(1:nrow(RBData2015)))
colnames(RBData2015)[4] <- "Pos ADP Rank"

#WR
WRData2015 <- DraftData2015%>%filter(Pos == "WR")
WRData2015 <- cbind(WRData2015,c(1:nrow(WRData2015)))
colnames(WRData2015)[4] <- "Pos ADP Rank"

ADP2015 <- rbind(QBBData2015, RBData2015, WRData2015)

###### Combine Tables ###### 
FantasyData2015$PositionADP <- rep(0)
for(i in 1:nrow(FantasyData2015)){
  for(j in 1:nrow(ADP2015)){
    if(FantasyData2015$Name[i] == ADP2015$Name[j])
      FantasyData2015$PositionADP[i] <- ADP2015$`Pos ADP Rank`[j]
  }
}
FantasyData2015 <- FantasyData2015%>%filter(PositionADP >0 & `Fantasy PosRank`<100)
QBFantasyData2015 <- FantasyData2015%>%filter(Position == "QB")
RBFantasyData2015 <- FantasyData2015%>%filter(Position == "RB")
WRFantasyData2015 <- FantasyData2015%>%filter(Position == "WR")

########## Graphs ##########
ggplot(data = FantasyData2015, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_point(aes(color = Position)) + geom_text(label = FantasyData2015$Name)

ggplot(data = QBFantasyData2015, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = QBFantasyData2015$Name)

ggplot(data = RBFantasyData2015, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = RBFantasyData2015$Name)

ggplot(data = WRFantasyData2015, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = WRFantasyData2015$Name)


################# 2014 ################# 

####### Web Scraping ####### 
url2014 <- 'https://fantasyfootballcalculator.com/adp/standard/12-team/all/2014'
download.file(url2014, 'data2014.html')
DraftData2014 <- readHTMLTable('data2014.html')$`NULL`%>%select(`#`, Name, Pos)

#QB
QBBData2014 <- DraftData2014%>%filter(Pos == "QB")
QBBData2014 <- cbind(QBBData2014,c(1:nrow(QBBData2014)))
colnames(QBBData2014)[4] <- "Pos ADP Rank"


#RB
RBData2014 <- DraftData2014%>%filter(Pos == "RB")
RBData2014 <- cbind(RBData2014,c(1:nrow(RBData2014)))
colnames(RBData2014)[4] <- "Pos ADP Rank"

#WR
WRData2014 <- DraftData2014%>%filter(Pos == "WR")
WRData2014 <- cbind(WRData2014,c(1:nrow(WRData2014)))
colnames(WRData2014)[4] <- "Pos ADP Rank"

ADP2014 <- rbind(QBBData2014, RBData2014, WRData2014)

###### Combine Tables ###### 
FantasyData2014$PositionADP <- rep(0)
for(i in 1:nrow(FantasyData2014)){
  for(j in 1:nrow(ADP2014)){
    if(FantasyData2014$Name[i] == ADP2014$Name[j])
      FantasyData2014$PositionADP[i] <- ADP2014$`Pos ADP Rank`[j]
  }
}
FantasyData2014 <- FantasyData2014%>%filter(PositionADP >0 & `Fantasy PosRank`<100)
QBFantasyData2014 <- FantasyData2014%>%filter(Position == "QB")
RBFantasyData2014 <- FantasyData2014%>%filter(Position == "RB")
WRFantasyData2014 <- FantasyData2014%>%filter(Position == "WR")

########## Graphs ##########
ggplot(data = FantasyData2014, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_point(aes(color = Position)) + geom_text(label = FantasyData2014$Name)

ggplot(data = QBFantasyData2014, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = QBFantasyData2014$Name)

ggplot(data = RBFantasyData2014, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = RBFantasyData2014$Name)

ggplot(data = WRFantasyData2014, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = WRFantasyData2014$Name)


################# 2013 ################# 

####### Web Scraping ####### 
url2013 <- 'https://fantasyfootballcalculator.com/adp/standard/12-team/all/2013'
download.file(url2013, 'data2013.html')
DraftData2013 <- readHTMLTable('data2013.html')$`NULL`%>%select(`#`, Name, Pos)

#QB
QBBData2013 <- DraftData2013%>%filter(Pos == "QB")
QBBData2013 <- cbind(QBBData2013,c(1:nrow(QBBData2013)))
colnames(QBBData2013)[4] <- "Pos ADP Rank"


#RB
RBData2013 <- DraftData2013%>%filter(Pos == "RB")
RBData2013 <- cbind(RBData2013,c(1:nrow(RBData2013)))
colnames(RBData2013)[4] <- "Pos ADP Rank"

#WR
WRData2013 <- DraftData2013%>%filter(Pos == "WR")
WRData2013 <- cbind(WRData2013,c(1:nrow(WRData2013)))
colnames(WRData2013)[4] <- "Pos ADP Rank"

ADP2013 <- rbind(QBBData2013, RBData2013, WRData2013)

###### Combine Tables ###### 
FantasyData2013$PositionADP <- rep(0)
for(i in 1:nrow(FantasyData2013)){
  for(j in 1:nrow(ADP2013)){
    if(FantasyData2013$Name[i] == ADP2013$Name[j])
      FantasyData2013$PositionADP[i] <- ADP2013$`Pos ADP Rank`[j]
  }
}
FantasyData2013 <- FantasyData2013%>%filter(PositionADP >0 & `Fantasy PosRank`<100)
QBFantasyData2013 <- FantasyData2013%>%filter(Position == "QB")
RBFantasyData2013 <- FantasyData2013%>%filter(Position == "RB")
WRFantasyData2013 <- FantasyData2013%>%filter(Position == "WR")

########## Graphs ##########
ggplot(data = FantasyData2013, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_point(aes(color = Position)) + geom_text(label = FantasyData2013$Name)

ggplot(data = QBFantasyData2013, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = QBFantasyData2013$Name)

ggplot(data = RBFantasyData2013, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = RBFantasyData2013$Name)

ggplot(data = WRFantasyData2013, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = WRFantasyData2013$Name)

################# 2012 ################# 

####### Web Scraping ####### 
url2012 <- 'https://fantasyfootballcalculator.com/adp/standard/12-team/all/2012'
download.file(url2012, 'data2012.html')
DraftData2012 <- readHTMLTable('data2012.html')$`NULL`%>%select(`#`, Name, Pos)

#QB
QBBData2012 <- DraftData2012%>%filter(Pos == "QB")
QBBData2012 <- cbind(QBBData2012,c(1:nrow(QBBData2012)))
colnames(QBBData2012)[4] <- "Pos ADP Rank"


#RB
RBData2012 <- DraftData2012%>%filter(Pos == "RB")
RBData2012 <- cbind(RBData2012,c(1:nrow(RBData2012)))
colnames(RBData2012)[4] <- "Pos ADP Rank"

#WR
WRData2012 <- DraftData2012%>%filter(Pos == "WR")
WRData2012 <- cbind(WRData2012,c(1:nrow(WRData2012)))
colnames(WRData2012)[4] <- "Pos ADP Rank"

ADP2012 <- rbind(QBBData2012, RBData2012, WRData2012)

###### Combine Tables ###### 
FantasyData2012$PositionADP <- rep(0)
for(i in 1:nrow(FantasyData2012)){
  for(j in 1:nrow(ADP2012)){
    if(FantasyData2012$Name[i] == ADP2012$Name[j])
      FantasyData2012$PositionADP[i] <- ADP2012$`Pos ADP Rank`[j]
  }
}
FantasyData2012 <- FantasyData2012%>%filter(PositionADP >0 & `Fantasy PosRank`<100)
QBFantasyData2012 <- FantasyData2012%>%filter(Position == "QB")
RBFantasyData2012 <- FantasyData2012%>%filter(Position == "RB")
WRFantasyData2012 <- FantasyData2012%>%filter(Position == "WR")

########## Graphs ##########
ggplot(data = FantasyData2012, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_point(aes(color = Position)) + geom_text(label = FantasyData2012$Name)

ggplot(data = QBFantasyData2012, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = QBFantasyData2012$Name)

ggplot(data = RBFantasyData2012, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = RBFantasyData2012$Name)

ggplot(data = WRFantasyData2012, aes(x = `Fantasy PosRank`, y = PositionADP)) +
  geom_text(label = WRFantasyData2012$Name)


