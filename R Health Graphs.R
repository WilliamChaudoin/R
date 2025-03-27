####### Graphs For Biomedical Data Study
## Libraries and Directory
setwd("C:/Users/willc/OneDrive/Documents/Game Plan/Portfolio/Staging")

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

## Scatterplots With Regression Lines and R^2 For All Variables Against Weight
opt = par(mfrow = c(5,5))
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	y = unlist(subset[,1])
	reg = lm(y ~ x)
	plot(y ~ x, xlab = colnames(subset[,i]), ylab = 'Weight', main= paste('Scatterplot With Regression Line for Weight v', colnames(subset[,i])), pch = 17, col = 'darkorange')
	abline(lm(y ~ x, data = subset), lty = 1, lwd = 2, col = 'turquoise1')
	text(.5, .5, summary(reg)$r.squared)
}
par(opt)

## Scatterplots With Regression Lines and R^2 For All Variables Against Waist
opt = par(mfrow = c(5,5))
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	y = unlist(subset[,2])
	reg = lm(y ~ x)
	plot(y ~ x, xlab = colnames(subset[,i]), ylab = 'Waist', main= paste('Scatterplot With Regression Line for Waist v', colnames(subset[,i])), pch = 17, col = 'darkorange')
	abline(lm(y ~ x, data = subset), lty = 1, lwd = 2, col = 'turquoise1')
	text(.5, .5, summary(reg)$r.squared)
}
par(opt)

##Residual Plots for All Variables Against Weight
opt = par(mfrow = c(5,5))
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	y = unlist(subset[,1])
	reg = lm(y ~ x)
	res = resid(reg)
	plot(fitted(reg), res)
	abline(0,0)
}
par(opt)

##Residual Plots for All Variables Against Waist
opt = par(mfrow = c(5,5))
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	y = unlist(subset[,2])
	reg = lm(y ~ x)
	res = resid(reg)
	plot(fitted(reg), res)
	abline(0,0)
}
par(opt)
