#### Using GGPlot To Make Charts In R

# Changing Directory Location And Loading Libraries
setwd('/')
getwd()
#install.packages('ggplot2')
#install.packages('leaflet')
#install.packages('tidyverse')
#install.packages('plotly')
library(ggplot2)
library(leaflet)
library(tidyverse)
library(broom)
library(plotly)

# Data
## Using mtcars and EuStockMarkets datasets, which are base R 
## datasets from Motor Trend magazine and the European Stock Market
mtcars
summary(mtcars)
str(mtcars)

head(EuStockMarkets, 10)
EuStock = as.data.frame(EuStockMarkets)
EuStock$Date = as.numeric(time(EuStockMarkets))
head(EuStock)
summary(EuStock)
str(EuStock)

# Bar Charts
## EX1
var1 = table(mtcars$cyl)
barplot(var1)

## EX2
qplot(data = mtcars, x = cyl, geom = 'bar')

## EX3
qplot(mtcars$cyl, geom = "bar", fill = I('red'), xlab = 'Cylinders', ylab = 'Number of Vehicles', main = 'Cylinders In Dataset')

# Histograms
## EX1
qplot(mtcars$hp, geom = 'histogram')

## EX2
qplot(mtcars$hp, geom= 'histogram', binwidth = 25, fill = I('red'), colour = I('green'), xlab = 'Horsepower', ylab= 'Number of Cars',
     main = 'Total Horsepower')

# Grouped Bar Chart
mtcars$cyl = as.factor(mtcars$cyl)
class(mtcars$cyl)

ggplot(data = mtcars, aes(x = cyl, fill = cyl)) + geom_bar(position = 'dodge')

# Stacked Bar Chart
ggplot(data = mtcars, aes(x = '', fill = cyl)) + geom_bar(position = 'stack')

# Pie Charts
## EX1
ggplot(data = mtcars, aes(x = '', fill = cyl)) + geom_bar(position = 'stack') + 
	coord_polar(theta = 'y')

## EX2
ggplot(data = mtcars, aes(x = '', fill = cyl)) + geom_bar(position = 'stack') + 
	coord_polar(theta = 'y') + scale_fill_brewer(palette  = 'Paired')

## EX3
mtcars$carb = as.factor(mtcars$carb)
class(mtcars$carb)
ggplot(data = mtcars, aes(x = '', fill = carb)) + geom_bar(position = 'stack') + 
	coord_polar(theta = 'y') + scale_fill_brewer(palette  = 'Accent')

# Scatterplot
## EX1
qplot(mpg, wt, data = mtcars)

## EX2
ggplot(mtcars, aes(x = mpg, y = wt, shape = cyl)) + geom_point()

## EX3
ggplot(mtcars, aes(x = hp, y = mpg, color = factor(cyl), shape = factor(cyl))) + 
     geom_point(size=2) + labs(x = 'Gross Horsepower', y = 'Miles Per Gallon', 
	color = 'Cylinders', shape = 'Cylinders', title = 'Mileage By Horsepower and Number of Cylinders', 
	subtitle = 'Data source: 1974 Motor Trend US Magazine') + theme_dark() +
	 scale_color_brewer(palette = 'Accent')

# Line Charts
## EX1
ggplot(EuStock, aes(x = Date, y = DAX)) + geom_line()

## EX2
ggplot(EuStock, aes(x = Date, y = DAX)) + geom_line(size = 1.5, color = 'green')

## EX3
ggplot(EuStock, aes(x = Date)) + geom_line(aes(y = DAX), color = 'yellow') + 
 geom_line(aes(y = SMI), color = 'green') + geom_line(aes(y = CAC), color = 'blue') + 
 geom_line(aes(y = FTSE), color = 'pink')

## EX4
stocks = tidy(EuStockMarkets) %>% rename(Date = index, Stock_Index = series, Price = value) 
head(stocks)
ggplot(stocks, aes(x = Date, y = Price, color = Stock_Index)) +
  geom_line()

# Box Plots
## EX1
ggplot(mtcars, aes(x = gear, y = hp)) + geom_boxplot()

## EX2
ggplot(mtcars, aes(x = cyl, y = mpg)) + geom_boxplot()

## EX3
plot = ggplot(mtcars, aes(y = mpg)) + geom_boxplot()
ggplotly(plot)

