# r-hdi-religion-script
Examining the Human Development Index and Non-religious Groups

---
title: "Examining the Human Development Index and Non-religious Groups"
author: "by Raquel Baeta"
output: html_document
    
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r, packages for Q2, include=FALSE}

# load packages "tidyverse" using

library(tidyverse) 
library(readr)
library(ggplot2)
library(car) 
```

```{r, importing data, include=FALSE}

# import data and assign a new data frame
xn <- read_csv("~/Desktop/xn.csv", 
               col_names=TRUE, 
               na="NA") 
```


```{r, view data, include=FALSE}

# data insepction 

view(xn) # view the data frame
problems(xn) # check failures 
str(xn) # check structure
```

```{r, variable selection, include=FALSE}

# data selection

my_data <- select(xn, country, pop, hdi, nonrelig) # selecting variables
view(my_data) # check new data set

xn$pop <- log(xn$pop) # log population 
summary(xn$pop) # check 
```

```{r, missing values, include=FALSE}

# missing data 

colSums(is.na(my_data)) # checking missing values 
missingdata <- my_data[!complete.cases(my_data), ]
missingdata # check

my_data <- na.omit(my_data) # remove missing data >> complete case 
sum(is.na(my_data)) # check again for missing data
```

```{r, data overview, include=TRUE, fig.width=7, fig.height=5}

# plot overview

plot(my_data, col = "blue")  
```

```{r, plot of hdi and nonrelig, warning=FALSE, include=TRUE, fig.width=7, fig.height=5}

# hdi and non-religious

ggplot(data = xn) + 
  geom_point(mapping = aes(x = hdi, y = nonrelig)) 
```

```{r, Q4 visualisation 1, warning=FALSE, include=TRUE, fig.width=7, fig.height=5}

# population and non-religious

ggplot(data = xn) + 
  geom_point(mapping = aes(x = pop, y = nonrelig)) 
```

```{r, Q4 visualisation 2, warning=FALSE, include=TRUE, fig.width=7, fig.height=5}

# hdi and population 

ggplot(data = xn) + 
  geom_point(mapping = aes(x = hdi, y = pop)) 
```

```{r, Q4 visualisation 3, warning=FALSE, include=TRUE, fig.width=7, fig.height=5}

# hdi and violent_decol

ggplot(data=xn, mapping=aes(hdi, violent_decol)) +
  geom_point() +
  geom_smooth(method="lm", col="black") +
  facet_wrap(vars(continent)) +
  xlab("Human Development Index") +
  ylab("Violent Conflict with  Western Colonial Power") +
  scale_x_log10(labels=scales::comma) +
  theme_bw()
```

```{r, Q4 visualisation 4, warning=FALSE, include=TRUE, fig.width=7, fig.height=5}

# population and christianity 

ggplot(data=xn, mapping=aes(pop, christian)) +
  geom_point() +
  geom_smooth(method="lm", col="black") +
  facet_wrap(vars(continent)) +
  xlab("Population") +
  ylab("Christianity") +
  scale_x_log10(labels=scales::comma) +
  theme_bw()
```

```{r, Q4 visualisation 5, warning=FALSE, include=TRUE}

# population and non-religious

ggplot(data=xn, mapping=aes(pop, nonrelig)) +
  geom_point() +
  geom_smooth(method="lm", col="black") +
  facet_wrap(vars(continent)) +
  xlab("Population") +
  ylab("Non-religious") +
  scale_x_log10(labels=scales::comma) +
  theme_bw()
```

```{r, regression model, include=FALSE}

# linear regression of hdi and non-religion

my_reg <- lm(hdi ~ pop + nonrelig, data = my_data) 
summary(my_reg) 
 
plot(hdi ~ pop + nonrelig, data = my_data)
abline(my_reg)
```

```{r, regression model ggplot2, include=FALSE}

# regression plotted in ggplot2

ggplot(my_data, aes(x = hdi, y = nonrelig)) + 
  geom_point() +
  stat_smooth(method = "lm", col = "red")

```

```{r, regression model with line, include=FALSE}

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
```

```{r, my_regression, include=TRUE}

# final regression plot

my_regression <- lm(nonrelig ~ hdi, data = my_data)
ggplotRegression(my_regression)
```
