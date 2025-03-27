####### Health Regression
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

# Simple Linear Regression and ANOVA
## Weight as Dependent Variable
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	y = unlist(subset[,1])
	reg = lm(y ~ x)
	cat('The Regression for Weight v', colnames(subset[i]), ':')
	print(summary(reg))
	cat('The ANOVA for Weight v', colnames(subset[i]), ':')
	print(anova(reg))
}

## Waist as Dependent Variable
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	y = unlist(subset[,2])
	reg = lm(y ~ x)
	cat('The Regression for Waist v', colnames(subset[i]), ':')
	print(summary(reg))
	cat('The ANOVA for Waist v', colnames(subset[i]), ':')
	print(anova(reg))
}

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

## Determining Best Model
###Weight As Dependent Variable
R2 = NULL
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	y = unlist(subset[,1])
	reg = lm(y ~ x)
	R2[i] = summary(reg)$r.squared
}
print(R2)

###Waist As Dependent Variable
R2 = NULL
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	y = unlist(subset[,2])
	reg = lm(y ~ x)
	R2[i] = summary(reg)$r.squared
}
print(R2)

## Coefficient of Variability
### Weight as Dependent Variable
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	y = unlist(subset[,1])
	reg = lm(y ~ x)
	S2 = anova(reg)[2,2]/224
	S = sqrt(S2)
	CV = 100*(S/mean(unlist(subset['Weight'])))
	cat('The CV for Weight v', colnames(subset[i]), ':')
	print(CV)
}

### Waist as Dependent Variable
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	y = unlist(subset[,2])
	reg = lm(y ~ x)
	S2 = anova(reg)[2,2]/224
	S = sqrt(S2)
	CV = 100*(S/mean(unlist(subset['Waist'])))
	cat('The CV for Waist v', colnames(subset[i]), ':')
	print(CV)
}

## 95% Confidence Interval For Model Slope
### Weight as Dependent Variable
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	y = unlist(subset[,1])
	reg = lm(y ~ x)
	CI = confint(reg)
	lower = CI[2, 1]
	upper = CI[2, 2]
	cat('\nThe 95% Confidence Interval for Weight v', colnames(subset[i]), ':')
	cat('\n(', lower, ',', upper, ')')
}

### Waist as Dependent Variable
for (i in 1:length(subset)) {
	x = unlist(subset[,i])
	y = unlist(subset[,2])
	reg = lm(y ~ x)
	CI = confint(reg)
	lower = CI[2, 1]
	upper = CI[2, 2]
	cat('\nThe 95% Confidence Interval for Waist v', colnames(subset[i]), ':')
	cat('\n(', lower, ',', upper, ')')

}