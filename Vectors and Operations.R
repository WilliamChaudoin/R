##### Vectors and Operations

# Change Working Directory Location
setwd('/')
getwd()

# Using The Combine Command With Numerical and Character Data To Form Vectors
data1 = c(6, 7, 6, 4, 8, 3, 5, 7, 5, 3, 2, 6, 8, 5, 6, 9)
data1
day1 = c('Mon', 'Tue', 'Wed', 'Thu')
day1
mix = c(data1, day1)
mix

# Scan Function With Named Vectors
##Numerical
data2 = scan()
6 7 8 7 6 3 8 9 10 7 6 9
# Press Enter again
data2

##Character
day2 = scan(what = 'character')
Mon Tue Wed Thu
# Press Enter again
day2

##Seperator/Symbol
data3 = scan(sep = ',')
23,17,12.5,11,17,12,14.5,9,11,9,12.5,14.5,17,8,21
# Press Enter again
data3

##Combined Operators
months = scan(sep = ',', what = 'character')
Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec
# Press Enter again
months

# Scan With TXT File
datatest = scan(file = 'data test.txt')
datatest

# Scan With CSV File
data4 = scan(file = 'Data.csv', sep = ',', skip = 1)
data4

# Same Scan Processes With file.choose()
datafile = scan(file.choose())
datafile

datasep = scan(file.choose(), sep = ',')
datasep

# Using read.csv
data5 = read.csv(file = 'Data.csv', header = TRUE)
data5

# Using read.table
data6 = read.table(file = 'Data.csv', header = TRUE)
data6

# Searching For Available Vectors
ls()

# Search For A Specific Character Among Vectors
ls(pattern = 'b')

# Vectors Beginning With A Specific Character
ls(pattern = '^b')

# Vectors Beginning With Either Character
ls(pattern = '^[be]')

# Alternative Way To Search For Either Character Among Vectors
ls(pattern = '^b|^e')

# Vectors Ending With A Specific Character
ls(pattern = 'm$')

# Using A Period As A Wildcard Among Vectors
ls(pattern = 'a.e')

# Removing Vectors
rm(data6)

## Alternative Method
remove(data6)

# Removing Specific Vectors
rm(list = ls(pattern = 'b'))

# Creating New Vectors With Sub-Levels
grass = read.csv(file = 'Grass.csv', header = TRUE)
grass

# Separating Sub-Levels Into Individual Vectors
cut = as.factor(grass$cut)
species = grass$species
cut
species

# Checking Structure Of Vectors
str(grass)

## Checking Structure Of All Available Data Items
ls.str()

# Change Vector Type
as.factor(species)
as.character(species)
as.numeric(cut)
as.integer(cut)

# Attaching Vectors To Files
data7 = c(23.0, 17.0, 12.5, 11.0, 17.0, 12.0, 14.5, 9.0, 11.0, 9.0, 12.5, 14.5, 17.0, 8.0, 21.0)
data7
write(data7, file = 'writedata7.txt', sep = ',')
cat(data7, file = 'catdata7.txt')

# Using Logical Operators
data1 == 6
data2 >5
data2 <5
data2 >5 & data2 <8
months == 'Feb'| months == 'Apr'

# Which Command With Vectors
which(data1 == 6)

# Displaying Parts of A Vector
## Whole Vector
data1
## First Item In Vector
data1[1]
## First 10 Items In Vector
data1[1:10]
## Dropping First Item From Vector
data1[-1]
## Displaying Specific Items
data1[c(1,3,5,7,9)]
## Displaying Items Greater Than 5
data1[data1 > 5]
## Items Greater Than Or Less Than
data1[data1 < 4 | data1 > 6]

# Using The Length Command With Vectors
length(data1)

# Combining Previous Processes
data1[1:length(data1)]

# Example Using Length To Increase Size of Vector With Autopopulated Items
w = c(1,2,3,4,5)
u = c(5,4,3,2)
length(w)
length(u)
length(u) = length(w)
w;u

# Sequential Command With Vectors
data1[seq(1, length(data1), 2)]

# Using The Rep Command
repeating = c(rep('yes',4), rep('no',5))
repeating

# Sort Command For Numerical And Character Vectors
## Numerical
data8 = c(8, 9, 7, 9, NA)
sort(data8, na.last = NA)
sort(data8, na.last = TRUE)
sort(data8, na.last = FALSE)

## Character
colors = c('Red', 'Blue', 'Orange', 'Yellow', NA)
sort(colors, na.last = NA)
sort(colors, na.last = TRUE)
sort(colors, na.last = FALSE)

# Order Command For Numerical and Character Vectors
## Numerical
order(data8, na.last = NA)
order(data8, na.last = TRUE)
order(data8, na.last = FALSE)

## Character
order(colors, na.last = NA)
order(colors, na.last = TRUE)
order(colors, na.last = FALSE)

# Rank Function For Numerical and Character Vectors
## Numerical
rank(data8, na.last = NA)
rank(data8, na.last = TRUE)
rank(data8, na.last = FALSE)
rank(data8, ties.method = 'first', na.last = 'keep')
rank(data8, ties.method = 'average', na.last = 'keep')
rank(data8, ties.method = 'max', na.last = 'keep')
rank(data8, ties.method = 'min', na.last = 'keep')
rank(data8, ties.method = 'random', na.last = 'keep')

## Character
rank(colors, na.last = NA)
rank(colors, na.last = TRUE)
rank(colors, na.last = FALSE)

# Saving Created Vectors
save(list = ls(), file = 'VectorData.RData')

# Removing All Vectors
rm(list = ls())
ls()

# Loading Saved Vectors
load(file = 'VectorData.RData')
ls()