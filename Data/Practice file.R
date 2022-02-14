install.packages("ggplot2")
#Load in the gapminder library we install it by doing install.packages("gapminder")
# To use this dataset we use the command library gap minder
library(gapminder)
library(ggplot2)
# This line of code makes it visible as an object called gap minder 
data("gapminder")
# Summarizes the line of code as a viable data frame  
summary(gapminder)
View(gapminder)
# We can call a specific function using the columns of the data frame.
mean(gapminder$gdpPercap)
#we can now attach this function to an object in this case x 
x= mean(gapminder$gdpPercap)
x
# If we don't wawnt to keep calling this data frame what we can do is that we can use the attach function so we can just use the variables of the data frame instead.
attach(gapminder)
median(pop)
hist(lifeExp)
hist(log(pop))
#we use the plot function to show the relationship between the two neumerical values, life expectancy being the y and gdp percapita being the x
plot(lifeExp ~ log(gdpPercap))
# the package dplyr helps us use more advanced graph functions
install.packages("dplyr")
library(dplyr)
#The pipe operator helps us to select a specific variable in our dataset. 
gapminder %>% 
  #select helps to narrow down the colums that we are working with.
  select(country,lifeExp) %>%
  #Pick specific values in the selected column in this case the countries South Africa and Ireland filter the rows
  filter(country =="South Africa" | 
            country == "Ireland")%>%
  #Aggregate the data by the two countries(so get a summary of the calculation)
  group_by(country)%>%
  summarise(Average_life = mean(lifeExp))
#This line of code is to find the t value or statistical difference between the life expectancy of the two countries.
df1=gapminder %>% 
  #select helps to narrow down the colums that we are working with.
  select(country,lifeExp) %>%
  #Pick specific values in the selected column in this case the countries South Africa and Ireland filter the rows
  filter(country =="South Africa" | 
           country == "Ireland")
t.test(data = df1, lifeExp ~ country)
install.packages("ggplot2")
library(ggplot2)
#this line of code filters specific data to ggplot
#aes= the asethetic(how we want the variables to be mapped on our canvas)
gapminder %>% 
  filter(gdpPercap<50000)  %>% 
  ggplot(aes(x=log(gdpPercap), y=lifeExp, col=continent, size = pop))+
  geom_point(alpha = 0.3)+
  geom_smooth(method=lm)+
  facet_wrap(~continent)
#lm stands for linear model
summary(lm(lifeExp ~ gdpPercap+pop))
# The ggplot attachment that allows us to plot the graaph will not be used for now but will be used later.
#scatter.smooth(lifeExp ~ country)
#data <- data.frame(country,lifeExp)
#ggplot(data, aes(country, lifeExp)) +geom_line()
