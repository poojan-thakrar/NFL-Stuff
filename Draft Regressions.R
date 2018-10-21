library(readxl)
library(dplyr)
library(XML)
library(xml2)
library(rvest)
library(magrittr)
library(ggplot2)
############################################





############################################
AuctionData2018 <- read_excel("Fantasy Football/2018 Auction Values.xlsx")
RBData <- AuctionData2018%>%filter(Position == "RB")
WRData <- AuctionData2018%>%filter(Position == "WR")
TEData <- AuctionData2018%>%filter(Position == "TE")
TEDataAugmented <- TEData%>%slice(c(-2, -3))

ggplot(data = RBData, aes(x = `Auction Value`, y = Points)) +
  geom_text(label = RBData$`Player Name`) +
  geom_smooth(method='lm', level = 0)

ggplot(data = WRData, aes(x = `Auction Value`, y = Points)) +
  geom_text(label = WRData$`Player Name`) +
  geom_smooth(method='lm', level = 0)

ggplot(data = TEData, aes(x = `Auction Value`, y = Points)) +
  geom_text(label = TEData$`Player Name`) +
  geom_smooth(method='lm', level = 0)

ggplot(data = TEDataAugmented, aes(x = `Auction Value`, y = Points)) +
  geom_text(label = TEDataAugmented$`Player Name`) +
  geom_smooth(method='lm', level = 0)

lm(Points ~ `Auction Value`, data = RBData)
lm(Points ~ `Auction Value`, data = WRData)
lm(Points ~ `Auction Value`, data = TEDataAugmented)
