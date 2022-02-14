install.packages("ggplot2")
install.packages("dplyr")
library(ggplot2)
library(dplyr)
library(readr)
fooddata <- read_csv("Data/dietary-compositions-by-commodity-group.csv")
ObesityData <- read_csv("C:/Users/ayode/Music/HonoursProject/Data/share-of-adults-who-are-overweight.csv")
ObesityData <- ObesityData %>% mutate(Entity = factor(Entity))
View(ObesityData)
View(fooddata)
attach(ObesityData)
ObesityData%>%
  select(Entity,Overweight,Code)%>%
  filter(Code !="NA") %>%
  group_by(Entity) %>%
  summarise(Total = sum(Overweight))

properdata<-ObesityData%>%
  select(Entity,Overweight,Code,Year)%>%
  filter(Code !="NA") %>%
  group_by(Year) %>%
  summarise(sum(Overweight/42))


ObesityData %>% 
  filter(Entity =='Afghanistan')  %>% 
  ggplot(aes(x=(Year), y=Overweight))+
  geom_point(alpha = 0.9)+
  geom_smooth(method=lm)

summary(lm(Overweight ~ year))
