# Start

# title: "Examining the Human Development Index and Non-religious Groups"
# author: "by Raquel Baeta"
# date: "2021-11-10"

# load packages
library(tidyverse) 
library(readr)
library(ggplot2)
library(car) 

# import data and assign a new data frame
xn <- read_csv("~/Desktop/xn.csv", 
               col_names = TRUE, 
               na = "NA") 

# data insepction 
view(xn) # view the data frame
problems(xn) # check failures 
str(xn) # check structure

# data selection
my_data <- select(xn, country, pop, hdi, nonrelig) # selecting variables
view(my_data) # check new data set

# data transformation
xn$pop <- log(xn$pop) # log population 
summary(xn$pop) # check 

# missing data 
colSums(is.na(my_data)) # checking missing values 
missingdata <- my_data[!complete.cases(my_data), ]
missingdata # check

# remove missing data
my_data <- na.omit(my_data)
sum(is.na(my_data)) # check again for missing data

# plot overview
plot(my_data, col = "blue")  

# hdi and non-religious
ggplot(data = xn) + 
  geom_point(mapping = aes(x = hdi, y = nonrelig)) 

# population and non-religious
ggplot(data = xn) + 
  geom_point(mapping = aes(x = pop, y = nonrelig)) 

# hdi and population 
ggplot(data = xn) + 
  geom_point(mapping = aes(x = hdi, y = pop)) 

# hdi and violent_decol
ggplot(data = xn, mapping = aes(hdi, violent_decol)) +
  geom_point() +
  geom_smooth(method = "lm", col = "black") +
  facet_wrap(vars(continent)) +
  xlab("Human Development Index") +
  ylab("Violent Conflict with  Western Colonial Power") +
  scale_x_log10(labels=scales::comma) +
  theme_bw()

# population and christianity 
ggplot(data = xn, mapping = aes(pop, christian)) +
  geom_point() +
  geom_smooth(method = "lm", col = "black") +
  facet_wrap(vars(continent)) +
  xlab("Population") +
  ylab("Christianity") +
  scale_x_log10(labels = scales::comma) +
  theme_bw()

# population and non-religious
ggplot(data = xn, mapping = aes(pop, nonrelig)) +
  geom_point() +
  geom_smooth(method = "lm", col = "black") +
  facet_wrap(vars(continent)) +
  xlab("Population") +
  ylab("Non-religious") +
  scale_x_log10(labels = scales::comma) +
  theme_bw()

# linear regression of hdi and non-religion
my_reg <- lm(hdi ~ pop + nonrelig, data = my_data) 
summary(my_reg) 

# plot
plot(hdi ~ pop + nonrelig, data = my_data)
abline(my_reg)

# regression plotted in ggplot2
ggplot(my_data, aes(x = hdi, y = nonrelig)) + 
  geom_point() +
  stat_smooth(method = "lm", col = "red")

# regression plotted in ggplot2
ggplotRegression <- function (my_data) 
  
{  
  require(ggplot2)
  
  ggplot(my_data$model, aes_string(x = names(my_data$model)[2], y = names(my_data$model)[1])) + 
    geom_point() +
    stat_smooth(method = "lm", col = "red") +
    labs(title = paste("Adj R2 = ",signif(summary(my_data)$adj.r.squared, 5),
                       "Intercept =",signif(my_data$coef[[1]],5 ),
                       " Slope =",signif(my_data$coef[[2]], 5),
                       " P =",signif(summary(my_data)$coef[2,4], 5)))
}

# final regression plot
my_regression <- lm(nonrelig ~ hdi, data = my_data)
ggplotRegression(my_regression)

# end