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
Food <- read_csv("Data/dietary-compositions-by-commodity-group.csv")
Obesity <- read_csv("C:/Users/ayode/Music/HonoursProject/Data/share-of-adults-who-are-overweight.csv")
worldPop <- read_csv("Data/historic-and-un-pop-projections-by-age.csv")
Obesity <- Obesity %>% mutate(Entity = factor(Entity))
View(Food)
#This is the dataframe of the countries with their percentage of the population that is obese. 
attach(Obesity)
ObesityData<-Obesity%>%
  select(Entity,Overweight,Year)%>%
  filter(Year<2014) %>%
  filter(Entity=="World") %>%
  group_by(Year)
#This is to get the food 
attach(Food)
FoodData<-Food%>%
  select(Entity,Code,Year,Sugar)%>%
  filter(Year>1974 & Year<2014) %>%
  group_by(Entity,Sugar)

properdata<-Obesity%>%
  select(Entity,Overweight,Year)%>%
  filter(Year>1974 & Year<2014) %>%
  group_by(Entity)

properfooddata<-FoodData%>%
  select(Entity,Sugar,Year)%>%
  #filter(Year==2013)%>%
  group_by(Entity)

sorted<-merge(properfooddata,properdata)

Finalfood<-sorted%>%
  select(Entity,Sugar,Year)%>%
  group_by(Year)%>%
  summarise(totalSugar = sum(Sugar/138))

keydataset<-merge(ObesityData,Finalfood)

keydatasettrain<-keydataset%>%
  filter(Year<2000)
keydatasettest<-keydataset%>%
  filter(Year>2000)

rm(Food,Obesity,ObesityData,properdata,properdata1)


