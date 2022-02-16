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
Obesity <- read_csv("C:/Users/ayode/Music/HonoursProject/Data/share-of-adults-who-are-overweight.csv")
worldPop <- read_csv("Data/historic-and-un-pop-projections-by-age.csv")
Obesity <- Obesity %>% mutate(Entity = factor(Entity))
View(Obesity)
#This is the dataframe of the countries with their percentage of the population that is obese. 
attach(Obesity)
ObesityData<-Obesity%>%
  select(Entity,Overweight,Code,Year)%>%
  group_by(Entity,Year) %>%
  summarise(Total = sum(Overweight))
attach(worldPop)
#This is the dataframe of the countries with their year and adult population
#TPop <-worldPop%>%
 # select(Entity,Code,Year,Total,`under age 15`)%>%
  #filter(Code !="NA") %>%
  #filter(Year>1974 & Year<2017) %>%
  #group_by(Year,Entity) %>%
  #summarise(Totalpop = Total-`under age 15`)
# This is the dataframe of the countries with their total weight
properdata<-ObesityData%>%
  select(Entity,Overweight,Year)%>%
  group_by(Year,Entity)

#WPop <-worldPop%>%
 # select(Entity,Code,Year,Total,`under age 15`)%>%
  #filter(Code !="NA") %>%
  #filter(Year>1974 & Year<2017) %>%
  #group_by(Year) %>%
  #summarise(tpop =sum(Totalpop = Total-`under age 15`))

sorted<-merge(properdata,TPop)

#finalvalue= sorted %>%
  #select(Year,Entity,Overweight,Totalpop)%>%
  #group_by(Year,Entity,Totalpop)%>%
  #summarise(obesepop = (Overweight/182)*Totalpop)

#finalvalue= finalvalue %>%
  #select(Year,Entity,Totalpop,obesepop)%>%
  #group_by(Year)%>%
  #summarise(worldobese = sum(worldobese = (obesepop/WPop$tpop)*100))
#rm(Temppop)









