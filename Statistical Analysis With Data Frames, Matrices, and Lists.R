##### Statistical Analysis With Data Frames, Matrices, and Lists

# Change Working Directory Location And Loading Data
setwd('/')
getwd()

load(file = 'PortfolioData.RData')
ls()

# Statistical Commands With Vectors
max(data1)
min(data1)
length(data1)
sum(data1)
mean(data1)
median(data1)
sd(data1)
var(data1)
mad(data1)

# Using The Log Command
log(data2)

# Summary, Quantile, And Fivenum Comparison
summary(data2)
quantile(data2)
fivenum(data2)

# Further Use Of The Quantile Command
quantile(data2, .2)
quantile(data2, c(0.2, .5, .8))
quantile(data2, c(0.5, .75, .25))
quantile(data2, c(0.2, .5, .8), names = F)
quantile(data8, na.rm = T)

# Cumulative Statitical Commands
cumsum(data2)
cummax(data2)
cummin(data2)
cumprod(data2)

# Sequence Command In Action
seq(data2)
cumsum(data2)/seq(data2)

# Example 1 Using Multiple Commands
##Find The Running Median
ex = seq(data2)
for(i in 1:length(ex)) ex[i] = median(data2[1:i])
ex

##Find The Running Standard Deviation
ex = seq(data2)
for(i in 1:length(ex)) ex[i] = sd(data2[1:i])
ex

# Statistical Commands With Data Frames
max(df)
min(df)
sum(df)
length(df)
summary(df)

# Statistical Commands With Matrices
max(cmatrix)
min(cmatrix)
sum(cmatrix)
fivenum(cmatrix)
length(cmatrix)
summary(cmatrix)
quantile(cmatrix)

# Using Row and Column Based Statistical Commands on Data Frames
rowMeans(df)
rowSums(df)
colMeans(df)
colSums(df)

# Using Row and Column Based Statistical Commands on Matrices
rowMeans(cmatrix)
rowSums(cmatrix)
colMeans(cmatrix)
colSums(cmatrix)

# Using The apply() Command
apply(af, 1, mean, na.rm = TRUE)
apply(bird, 1, median, na.rm = TRUE)
apply(bird, 1, median, na.rm = TRUE)[c(1,2,5)]

# Using The lapply Command
lapply(grasslist, mean, na.rm = TRUE)

# Using The sapply Command
sapply(grasslist, mean, na.rm = TRUE)

# Contingency Tables
table(data2)
table(grass$cut)
table(grass)
table(numlist)

# Custom Contingency Tables
table(nature$height, nature$water)
table(nature$height, nature$water, dnn = c('HT', 'H2O'))
with(nature, table(height, water))
table(bird)
table(bird[,1], bird[,2], dnn = c('Gdn', 'Hedge'))
table(bird[3,], bird[1,], dnn = c('Gt. Tit', 'BlackBrd'))

# Testing Tables
df.tab = table(df)
cm.tab = table(cmatrix)
nl.tab = table(numlist)
is.table(df)
is.table(df.tab)
is.table(cmatrix)
is.table(cm.tab)
is.table(numlist)
is.table(nl.tab)

## Using Class on Tables
class(df.tab)
class(cm.tab)
class(nl.tab)

## Parts Of A Table Object
nature.tab = with(nature, table(height, water))
nature.tab
str(nature.tab)
nature.tab[1:3,]
nature.tab[1:3,1]
nature.tab[1:3,1:2]
nature.tab[,'hi']
nature.tab[1:3, c('hi', 'mid')]
nature.tab[1:3, c('mid', 'hi')]

## Using The If Command
if(class(df.tab) =='table') TRUE else FALSE
if(class(df) =='table') TRUE else FALSE

# Using ftable
df.ft = ftable(df)
df.ft
nature.ft = ftable(nature)
nature.ft
with(nature, ftable(height, plant, water))

## Using Class on ftables
class(df.ft)

## Using The If Command
if(class(df.ft) =='ftable') TRUE else FALSE

# Statistical Commands For Tables
rowSums(df.tab)
colSums(df.tab)
rowMeans(df.tab)
colMeans(df.tab)

# Cross Tabluations
birds
with(birds, table(Species, Habitat))
with(birds, table(Species, Habitat, Qty))
with(birds, ftable(Species, Habitat, Qty))
birds.x = xtabs(Qty ~ Species + Habitat, data = birds)
birds.x

## Using Class on Cross Tabulations
class(birds.x)

## Using The If Command
if(any(class(birds.x) =='xtabs')) TRUE else FALSE

# Reverting Cross Tabulations
as.data.frame(birds.x)