##### Basic R Commands

# Find Working Directory Location
getwd()

# Change Working Directory Location
setwd('/')
getwd()

# Look At Directory
dir()
list.files()
dir(all.files = TRUE)

# Ask For Help
help(readxl)
help(coin)
help(gdata)

# Install Package
install.packages('readxl')
install.packages('coin')
install.packages('gdata')

# Load New Package
library('readxl')
library('coin')
library('gdata')

# Load Previously Installed Package
library(MASS)

# Ask For Help About Item From Package
help(bcv)

# See What Packages Or Attached Objects Are Available
search()

# Detach Package
detach('package:coin')

# Print Command
print("Hello World!")

# Math Operations
3 + 9 + 12 - 7
12 + 17/2 - 3/4 * 2.5
(12 + 17/2 - 3/4) * 2.5
pi * 2^3 - sqrt(4)
abs(12 - 7 * 2/3 - 9)
factorial(4)
log(2, 10)
log(2, base = 10)
log10(2)
log(2)
exp(.6931472)
10^.30103
sin(45 * pi / 180)
asin(.7071068) * 180 / pi

# Creating Named Vectors
exp1 = 23 + 14/2 - 18 + (7 * pi/2)
exp1

exp2 = 13 + 11 + (17 - 4/7)
exp2

exp3 = exp2 + 9 - 2 + pi
exp3

## Alternative Naming Methods
exp4 <- 3 + 5
exp4

exp5 <- exp1 * exp2
exp5

# Forcing R To Display Result Without Typing Name
(exp3 + pi / exp4 -> exp6)

# Displaying Available R Datasets
data()

# Displaying Available Colors
colors()

# Displaying Plot Palette
palette()

#History Command
history()
history(max.show = 5)

# Saving And Loading History
savehistory(file = 'example.Rhistory')
loadhistory(file = 'example.Rhistory')

# Loading and Displaying Data
load(file = 'PortfolioData.RData')
ls()
