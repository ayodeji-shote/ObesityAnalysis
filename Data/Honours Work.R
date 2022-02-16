install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")
install.packages("daff")
install.packages("sqldf")
library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(daff)
library(sqldf)
fooddata <- read_csv("Data/dietary-compositions-by-commodity-group.csv")
ObesityData <- read_csv("C:/Users/ayode/Music/HonoursProject/Data/share-of-adults-who-are-overweight.csv")
worldPop <- read_csv("Data/historic-and-un-pop-projections-by-age.csv")
ObesityData <- ObesityData %>% mutate(Entity = factor(Entity))
#This is the dataframe of the countries with their percentage of the population that is obese. 
attach(ObesityData)
ObesityData%>%
  select(Entity,Overweight,Code)%>%
  filter(Code !="NA") %>%
  group_by(Entity) %>%
  summarise(Total = sum(Overweight))
attach(worldPop)
#This is the dataframe of the countries with their year and adult population
TPop <-worldPop%>%
  select(Entity,Code,Year,Total,`under age 15`)%>%
  filter(Code !="NA") %>%
  filter(Year>1974 & Year<2016) %>%
  group_by(Year,Entity) %>%
  summarise(Totalpop = Total-`under age 15`)
# This is the dataframe of the countries with their total weight
properdata<-ObesityData%>%
  filter(Code !="NA") %>%
  select(Entity,Overweight,Year)%>%
  group_by(Year,Entity)

ObesityData %>% 
  filter(Entity =='Afghanistan')  %>% 
  ggplot(aes(x=(Year), y=Overweight))+
  geom_point(alpha = 0.9)+
  geom_smooth(method=lm)

summary(lm(Overweight ~ year))

sorted<-merge(properdata,Temppop)
rm(Temppop)









