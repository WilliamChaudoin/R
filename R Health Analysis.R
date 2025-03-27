####### Introductory Analysis For Biomedical Data Study
## Libraries and Directory
setwd("C:/Users/willc/OneDrive/Documents/Game Plan/Portfolio/Staging")
if(!require(DescTools)) { install.packages("DescTools"); library(DescTools) }

## Loading Collected Biomedical Data
load(file = "Cleaned_Health.RData")
ls()

## Displaying Data
head(health, 10)
str(health)

## Creating a Subset to Test
subset = health[,2:26]
subset$Gym = as.numeric(health$Gym)
subset$Cardio = as.numeric(health$Cardio)
print(subset)
str(subset)

## Main Descriptive Statistics For All Variables
summary(subset)

## Plain Histograms For All Variables
opt = par(mfrow = c(5,5))
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	hist(x, xlab = colnames(subset[,i]), main= paste('Histogram for', colnames(subset[,i])))
}
par(opt)

## Frequency Distributions For All Variables
opt = par(mfrow = c(5,5))
for (i in 1:length(subset)){
	x = unlist(subset[,i])
	hist(x, freq = FALSE, breaks = 15, xlab='Range', ylab='Frequency', main = paste("Frequency Distribbution for" , i))
	dens = density(x)
	lines(dens)
}
par(opt)

## Printing Z Scores With P-Values For All Variables
for (i in 1:length(subset)) {
	mean = sapply(subset[,i], mean)
	mode = sapply(subset[,i], Mode)
	std = sapply(subset[,i], sd)
	sqrt = sqrt(nrow(subset[,i]))
	z = (mean - mode)/(std/sqrt)
	p = sprintf(2*pnorm(q=z, lower.tail=FALSE), fmt = '%#.4f')
	cat('\n', 'The Z-Score', z, 'and P-Value', p, 'for', colnames(subset[,i]))
}

## Producing 95% Confidence Intervals For All Variables
for (i in 1:length(subset)) {
	mean = sapply(subset[,i], mean)
	std = sapply(subset[,i], sd)
	sqrt = sqrt(nrow(subset[,i]))
	Upper = mean + (1.96*(std/sqrt))
	Lower = mean - (1.96*(std/sqrt))
	cat('\n', colnames(subset[,i]), 'CI: is', Lower, '-', Upper)
}

## Producing Correlation Coefficients For All Relationships Between Weight and the Remaining Variables
for (i in 1:length(subset)) {
	corr = cor(subset[,i], subset[,1])
	cat('\n', 'Correlation for Weight and', colnames(subset[,i]), ':', corr)

}

## Producing Correlation Coefficients For All Relationships Between Waist and the Remaining Variables
for (i in 1:length(subset)) {
	corr = cor(subset[,i], subset[,2])
	cat('\n', 'Correlation for Waist and', colnames(subset[,i]), ':', corr)

}