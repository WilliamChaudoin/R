##### Data Distributions, Tests, And Plots

# Change Working Directory Location And Loading Data
setwd('/')
getwd()
#install.packages('gdata')
library('gdata')

load(file = 'PortfolioData.RData')
ls()

# Stem and Leaf Plot
stem(data1)
stem(data1, scale = 2)
stem(data3)
stem(grass$species)

# Histograms
hist(data1)
hist(data1, breaks = 'Sturges')
hist(data1, breaks = 'Scott')
hist(data1, breaks = 'FD')
hist(data1, col='darkorange', main='Histogram for Data1', xlab = 'Size class for data1', ylim=c(0, .3), freq = FALSE)

# Displaying Available Colors
colors()

##Alternative
colours()

# Density And Its Properties
(dens = density(data1))
names(dens)
str(dens)
class(dens)

# Using Density To Make A Plot
plot(dens)

# Adding Density Lines To A Histogram
hist(data1, freq = F, col = 'darkorange')
lines(dens, lty = 2) # Ity can be 0:6 for different types of lines
lines(density(data1, k = 'rectangular'))

# Information On Data Distributions
help(Distributions)

# Data Distributions
## Normal
### Generate Random Numbers For A Normal Distribution
rnorm(20, mean = 5, sd = 1)
### Probability Under A Normal Distribution For A Given Quantile
pnorm(5, mean = 5, sd = 1)
### Quantile For A Given Probability Under A Normal Distribution
qnorm(.5, mean = 5, sd = 1)
qnorm(c(.05, .95), mean = 5, sd = 1)
### Generates Density Function For Values Under A Normal Distribution
dnorm(5, mean = 5, sd = 1)
dnorm(c(4, 5, 6), mean = 5, sd = 1)

## Poisson
### Generates Random Numbers For A Poisson Distribution
rpois(20, lambda = 5)

## Binomial
### Cumulative Probability Under A Binomial Distribution
pbinom(5, size = 20, prob =.5)

## Uniform
### Generating Random Numbers
runif(10)
runif(10, min = 0, max = 10)
## Cumulative Probability
punif(10, min = 0, max = 10)

# T-Test
## Criticial Values For Different Degrees Of Freedom
qt(.975, df = c(5, 10, 100, Inf))
## P-Values For Corresponding Values
(1-pt(c(1.6, 1.9, 2.2), df = Inf))*2

# F Test
pf(seq(3, 5, .05), df1 = 2, df2 = 12, lower.tail = F)

# Producing Fixed Random Numbers
##Setting Restriction
set.seed(5)
runif(5)
##Without Restriction
runif(5)
##Returning Restriction
set.seed(5)
runif(5)

# Comparing A Generated Normal Distribution Against A Vector
data2.norm = rnorm(1000, mean(data2), sd(data2))
hist(data2, freq = F, col = 'darkorange')
lines(density(data2.norm), Ity = 1)

# Pulling A Sample From A Normal Distribution
sample(data2.norm, size = 100)

## Including Restrictions
sample(data2.norm[data2.norm > 3], size = 100)

# Issues With sample And Using resample
sample(data2[data2 > 9])# Since There Is Only 1 Number Above 9 It Malfunctions
## Avoiding Malfunction
resample(data2[data2 > 9])
class(resample)

# Shapiro-Wilk Test
## Vector
data1
shapiro.test(data1)
## Comparison
shapiro.test(rpois(100, lambda = 5))
## Using A Data Frame
tapply(grass$species, grass$cut, shapiro.test)

# Kolmogorov-Smirnov Test
ks.test(data1, 'pnorm', mean = 5, sd = 2)

# QQ Plots
qqnorm(data2)
qqnorm(data3)
qqline(data3, lwd = 2, Ity = 2)

# Plotting Vectors Against Each Other
(comp = qqplot(sample1, sample2))
abline(lm(comp$y ~ comp$x))
