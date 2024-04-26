##### Portfolio Data Creation

# Change Working Directory Location And Load Libraries
setwd('/')
getwd()
#install.packages('readxl')
library(readxl)

# Vectors
##Numerical
(data1 = c(6, 7, 6, 4, 8, 3, 5, 7, 5, 3, 2, 6, 8, 5, 6, 9))
(data2 = c(6, 7, 8, 7, 6, 3, 8, 9, 10, 7, 6, 9))
(data3 = c(23,17,12.5,11,17,12,14.5,9,11,9,12.5,14.5,17,8,21))
(data7 = c(23.0, 17.0, 12.5, 11.0, 17.0, 12.0, 14.5, 9.0, 11.0, 9.0, 12.5, 14.5, 17.0, 8.0, 21.0))
(data8 = c(8, 9, 7, 9, NA))
(sample1 = c(5,6,11,12,8))
(sample2 = c(7,9,13,10,5))
(rain = c(3, 5, 7, 5, 3, 2, 6, 8, 5, 6, 9, 8))

## Character
(day1 = c('Mon', 'Tue', 'Wed', 'Thu'))
(months = c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
(colors = c('Red', 'Blue', 'Orange', 'Yellow', NA))
(sample3 = c('a','b','c','d','e'))

# Data Frames
## Grass
(species = c(12, 15, 17, 11, 15, 8, 9, 7, 9))
(cut = as.factor(c(rep('mow', 5), rep('unmow', 4))))
(grass = data.frame(species, cut))
levels(cut)

## DF
(df = data.frame(sample1, sample2))

## Measurements
Measurements = read_excel('Measurements.xlsx')
(M = as.data.frame(Measurements))

## Nature
height = c(9, 11, 6, 14, 17, 19, 28, 31, 32, 7, 6, 5, 14, 17, 15, 44, 38, 37)
plant = c(rep('vulgaris', 9), rep('sativa', 9))
water = c(rep('lo', 3), rep('mid', 3), rep('hi', 3), rep('lo', 3), rep('mid', 3), rep('hi', 3))
(nature = data.frame(height, plant, water))

## Orchid
open = c(3, 5, 6, 7, 6, 8, 8, 4, 7, 6)
closed = c(7, 8, 6, 9, 10, 11, 7, 8, 10, 9)
(orchid = data.frame(closed, open))

## AF
abund = c(9, 25, 15, 2, 14, 25, 24, 47)
flow = c(2, 3, 5, 9, 14, 24, 29, 34)
af = data.frame(abund, flow)
rownames(af) = c('Taw', 'Torridge', 'Ouse', 'Exe', 'Lyn', 'Brock', 'Ditch', 'Fal')

## LHA
Lawn = c(3, 4, 3, 5, 6, 12, 21, 4, 5, 4, 7, 8)
Heath = c(6, 7, 8, 8, 9, 11, 12, 11, NA, NA, NA, NA)
Arable = c(19, 3, 8, 8, 9, 11, 12, 11, 9, NA, NA, NA)
LHA = data.frame(Lawn, Heath, Arable)
LHA.Stacked = na.omit(stack(LHA))
names(LHA.Stacked) = c('count', 'site')

# DL
dark = c(2, 3, 8, 13, 16, 23, 26, 25, 20, 17, 6)
light = c(2, 4, 6, 8, 10, 16, 22, 28, 30, 36, 48)
dl = data.frame(dark, light)

# FWI
speed = c(9, 6, 7, 5, 4, 3, 4, 7)
sfly = c(2, 3, 4, 6, 23, 26, 33, 20)
mfly = c(22, 15, 10, 9, 5, 4, 12, 8)
fwi = data.frame(speed, sfly, mfly)

# Matrix
## Column Matrix
cname = c('Sample1', 'Sample2')
rname = c('Site1', 'Site2', 'Site3', 'Site4', 'Site5')
(cmatrix = cbind(sample1, sample2))
rownames(cmatrix) = rname
colnames(cmatrix) = cname

## Bird(s)
Blackbird = c(47, 10, 40, 2, 2)
Chaffinch = c(19, 3, 5, 0, 2)
Great Tit = c(50, 0, 10, 7, 0)
House Sparrow = c(46, 16, 8, 4, 0)
Robin = c(9, 3, 0, 0, 2)
Song Thrush = c(4, 0, 6, 0, 0)

Garden = c(47, 19, 50, 46, 9, 4)
Hedgerow = c(10, 3, 0, 16, 3, 0)
Parkland = c(40, 5, 10, 8, 0, 6)
Pasture = c(2, 0, 7, 4, 0, 0)
Woodland = c(2, 2, 0, 0, 2, 0)
RNames = c('Blackbird', 'Chaffinch', 'Great Tit', 'House Sparrow', 'Robin', 'Song Thrush')
CNames = c('Garden', 'Hedgerow', 'Parkland', 'Pasture', 'Woodland')
bird = matrix(c(Garden, Hedgerow, Parkland, Pasture, Woodland), ncol = 5, dimnames = list(RNames, CNames))

Species = c('Blackbird', 'Chaffinch', 'Great Tit', 'House Sparrow', 'Robin', 'Song Thrush', 'Blackbird', 'Chiffinch', 'Great Tit', 'House Sparrow', 'Song Thrush',
 'Blackbird', 'Chaffinch', 'House Sparrow', 'Robin', 'Blackbird', 'Chaffinch', 'Robin', 'Blackbird', 'Great Tit', 'House Sparrow')
Habitat = c(rep('Garden', 6), rep('Parkland', 5), rep('Hedgerow', 4), rep('Woodland', 3), rep('Pasture', 3))
Qty = c(47, 19, 50, 46, 9, 4, 40, 5, 10, 8, 6, 10, 3, 16, 3, 2, 2, 2, 2, 7, 4)
birds = data.frame(Species, Habitat, Qty)

# Lists
## Numerical
(numlist =  list(sample1, sample2))

## Grasslist
(grasslist = unstack(grass))

# Saving Created Vectors
save(list = ls(), file = 'PortfolioData.RData')