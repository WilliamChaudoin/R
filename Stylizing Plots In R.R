#### Stylizing Plots In R

# Changing Directory Location And Loading Libraries
setwd('/')
getwd()
#install.packages('ggplot2')
#install.packages('leaflet')
#install.packages('rlang')
#install.packages('fastmap')
#install.packages('htmltools')
#install.packages('htmlwidgets')
#install.packages('ggthemes')
library(ggplot2)
library(leaflet)
library(rlang)
library(htmlwidgets)
library(fastmap)
library(htmltools)
library(ggthemes)

# Data
## Using the mtcars dataset, which is a base R dataset from Motor Trend magazine
mtcars
summary(mtcars)
str(mtcars)

# Customizing Plots
## Labels
### EX1
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point(aes(color = factor(cyl))) +
  labs(x = 'Weight (1000 lbs)', y = 'Miles/(US) gallon', color = 'Cylinders',
  title = 'Mileage By Weight And Cylinders', subtitle = 'Source: 1974 Motor Trend US magazine')

### EX2
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point(aes(color = factor(cyl))) +
  geom_text(aes(label = rownames(mtcars)), check_overlap = TRUE, hjust = "inward")  

## Annotations
### EX1
median(mtcars$mpg)
ggplot(mtcars, aes(x = mpg)) + geom_histogram(bins = 10) + 
  labs(x = 'Miles/(US) gallon', y = 'Count', 
  title = 'Distribution of Miles/Gallon') + geom_vline(aes(xintercept = 19.2), 
  color = 'purple') + annotate(geom = 'text', label = 'Median = 19.2', x = 21,
  y = 7, hjust = 0, color = 'blue')

### EX2
i_max = which.max(mtcars$qsec)
ggplot(mtcars, aes(x = hp, y = qsec)) + geom_point() + 
  labs(x = 'Gross Horsepower', y = '1/4 Mile Time') + geom_vline(aes(xintercept = 200), 
  color = 'purple') + annotate(geom = 'text', 
  label = 'slowest', x = mtcars$hp[i_max] + 5, y = mtcars$qsec[i_max], hjust = 0,            
  color = 'blue')    

## Faceting
### EX1
ggplot(mtcars, aes(x = mpg)) + geom_histogram() + facet_wrap(.~cyl)

### EX2
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar() + 
  facet_wrap(.~am) + labs(x = 'Number Of Cylinders', 
  title = 'Cylinders By Tansmission Type (0 Is Automatic, 1 Is Manual)')

## Themes
### EX1
ggplot(mtcars, aes(cyl)) + geom_bar() + theme_dark()

### EX2
mtcars$cyl_factor = factor(mtcars$cyl)
ggplot(mtcars, aes(x = cyl_factor, fill = cyl_factor)) + 
  geom_bar() + scale_fill_brewer(palette = 'Accent')

### EX3
mtcars$gear_factor = factor(mtcars$gear)
ggplot(mtcars, aes(x = gear_factor, fill = gear_factor)) + 
  geom_bar() +  theme_minimal() + scale_fill_brewer(palette = 'Spectral')

## Customized
### EX1
ggplot(mtcars, aes(cyl)) + geom_bar() + ggtitle('Number Of Cylinders') +
  theme(plot.background = element_rect(color = 'blue', fill = 'green'),
    plot.title = element_text(face = 'bold', color = 'purple'),
    axis.line = element_line(color = 'yellow'), axis.ticks = element_blank())

### EX2
ggplot(mtcars, aes(y = mpg)) + geom_boxplot() +
 labs(y = 'Miles Per Gallon', title = 'Boxplot') + 
 theme(plot.background = element_rect(fill = 'skyblue'), 
 axis.text.x = element_blank()) 

### EX3
p = ggplot(mtcars, aes(x = wt, y = mpg)) + 
  geom_point(aes(color = factor(cyl))) +
  labs(x = 'Weight (1000 lbs)', y = 'Miles/(US) Gallon', color = 'Cylinders')
p

p + theme_economist() + scale_color_economist()

p + theme_clean() + scale_color_colorblind()

p + theme_gdocs() + scale_color_gdocs()
    
p + theme_igray() + scale_color_canva()

## Maps
### EX1
leaflet() %>% addTiles()

### EX With Markers
leaflet() %>% addTiles() %>% addMarkers(lng = -73.9851, lat = 40.7589)

### EX With Captions
leaflet() %>% addTiles() %>% 
 addMarkers(lng = -73.9851, lat = 40.7589, popup = 'Times Square')

### EX Using A Data Frame
leaflet(quakes) %>% addTiles() %>% 
  addCircleMarkers(lng = quakes$long, lat = quakes$lat)

### EX With Clustering Markers
leaflet(quakes) %>% addTiles() %>% 
  addCircleMarkers(clusterOptions = markerClusterOptions())
 
### EX With Different Shapes
leaflet(quakes) %>% addTiles() %>% 
  addCircles(lng = quakes$long, lat = quakes$lat)

leaflet(quakes) %>% addTiles() %>% 
  addMarkers(lng = 86.92, lat = 27.99, popup = 'Mount Everest') %>%
   addRectangles(86.9, 27.95, 87, 28.05)
