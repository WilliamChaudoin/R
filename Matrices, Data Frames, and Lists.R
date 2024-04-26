##### Matrices, Data Frames, and Lists

# Change Working Directory Location
setwd('/')
getwd()

#Loading Data Vectors To Use
load(file = 'PortfolioData.RData')
ls()

# Creating Data Frames
sample1; sample2
df = data.frame(sample1, sample2)
df
## Checking Structure
str(df)
class(df)

# Creating A Matrix
## Column Matrix
cmatrix = cbind(sample1, sample2)
cmatrix
## Row Matrix
rmatrix = rbind(sample1, sample2)
rmatrix
## Checking Structure
str(cmatrix)
str(rmatrix)
class(cmatrix)
class(rmatrix)

# A Mixed Matrix
sample3
mixmat = cbind(sample1, sample2, sample3)
mixmat
## Checking Structure
str(mixmat)
class(mixmat)

# Alternative Matrix Creation Method
## Row Method
altmat = matrix(c(sample1, sample2), nrow = 2)
altmat
## Column Method
altmat2 = matrix(c(sample1, sample2), ncol = 2)
altmat2

# Issues With Numerical Columns Listed As Character
as.numeric(mixmat[,1])
mixmat[,1] = as.numeric(mixmat[,1])
mixmat
str(mixmat) # Remains Character Type Despite Brunt Force Attempt

# Creating An Array
films = c('Akira', 'Toy Story', 'Room', 'The Wave', 'Whiplash', 'Star Wars', 'The Ring', 'The Artist', 'Jumanji')
film.array <- array(films, dim = c(4,3))
film.array

# Creating Lists
## Numerical
numlist =  list(sample1, sample2)
numlist

## Character
charlist = list(day1, months)
charlist

## Checking Structure
str(numlist)
class(numlist)
str(charlist)
class(charlist)

# Using The Names Command
names(df)
names(cmatrix)
names(numlist)

# Using rownames And colnames
rownames(df)
rownames(rmatrix)
rownames(numlist)

colnames(df)
colnames(cmatrix)
colnames(numlist)

# Using dimnames
dimnames(df)
dimnames(rmatrix)
dimnames(numlist)

# Naming Columns And Rows In A Matrix
cname = c('Sample1', 'Sample2')
rname = c('Site1', 'Site2', 'Site3', 'Site4', 'Site5')
nmatrix = matrix(c(sample1, sample2), ncol = 2, dimnames = list(rname, cname))
nmatrix
rownames(nmatrix)
colnames(nmatrix)
dimnames(nmatrix)

# Naming List Items
names(numlist) = c('sample1', 'sample2')
numlist

# Displaying Parts Of A Data Frame
df
df[2,2]
df[3,1:2]
df[,1]
df[1,]
df[1, -1]
df[1, 'sample2']
df[1]

# Displaying Parts Of A Matrix
cmatrix
cmatrix[2,2]
cmatrix[3,1:2]
cmatrix[,1]
cmatrix[1,]
cmatrix[1, -1]
cmatrix[1, 'sample2']
cmatrix[1]

# Displaying Parts Of A List
numlist$sample1

# Removing A Column
df
(df2 = data.frame(df, colors))
df2$colors = NULL
df2

# Using Sort, Order, And Rank On A Data Frame
sort(df$sample1)
order(df$sample1)
rank(df$sample1)

# Using Sort, Order, And Rank On A Matrix
sort(cmatrix)
order(cmatrix)
rank(cmatrix)

# Using Sort, Order, And Rank On A List
sort(numlist$sample1)
order(numlist$sample1)
rank(numlist$sample1)

# Using Attach Command
attach(df)
attach(numlist)
attach(cmatrix) # Error will occur since Attach doesn't work for Matrices

# Detaching Objects
detach(df)
detach(numlist)

# Using Transpose
##On A Data Frame
df.t = t(df)
df.t
## On A Matrix
cmatrix.t = t(cmatrix)
cmatrix.t

# Using With Command Instead
## With A Data Frame
with(df, sample1)
with(df, sum(sample1))
## With A List
with(numlist, sample1)
with(numlist, sum(sample1))

# Using Head And Tail Commands
head(df)
tail(df)
head(df, n = 3)
tail(df, n = 3)

head(cmatrix)
tail(cmatrix)
head(cmatrix, n = 3)
tail(cmatrix, n = 3)

head(numlist)
tail(numlist)

# Summary Command
summary(df)
summary(cmatrix)
summary(numlist)

# Converting A Data Frame Into A Matrix
df.mat = as.matrix(df)
df.mat
class(df)
class(df.mat)

# Converting A Data Frame Into A List
df.list = as.list(df)
df.list
class(df)
class(df.list)

# Converting A Matrix Into A Data Frame
cmatrix.df = as.data.frame(cmatrix)
cmatrix.df
class(cmatrix)
class(cmatrix.df)

# Converting A Matrix Into A List
cmatrix.list = as.list(as.data.frame(cmatrix))
cmatrix.list
class(cmatrix)
class(cmatrix.list)

# Converting A List Into A Data Frame
numlist.df = as.data.frame(numlist)
numlist.df
class(numlist)
class(numlist.df)

# Converting A List Into A Matrix
numlist.mat = as.matrix(as.data.frame(numlist))
numlist.mat
class(numlist)
class(numlist.mat)

# Stack and Unstack Commands
## Example 1
grass
(grass.unstack = unstack(grass))
(grass.stack = stack(grass.unstack))

## Example 2
unstack(nature, form = height ~ plant)
(nature2 = unstack(nature, form = height ~ water))
stack(nature2, select = c(hi, lo))

# Example Using Multiple Methods
grass
ii = with(grass, order(species, cut))
(grasssort = grass[ii,])
(grasssort = grass[ii, c(2,1)])