####### Logarithmic and Cubic Regression Models
## Libraries and Directory
setwd("C:/Users/willc/OneDrive/Documents/Game Plan/Portfolio/Staging")
if(!require(car)) { install.packages("car"); library(car) }
if(!require(corrplot)) { install.packages("corrplot"); library(corrplot) }

## Loading Collected Biomedical Data
load(file = "Cleaned_Health.RData")
ls()

## Displaying Data
head(health, 10)
str(health)

## Creating a Subset to Test
subset = health[c(2,3,4,19,21,23)]
print(subset)
str(subset)

#Model 1
x1 = unlist(subset['Waist'])
x2 = unlist(subset['Neck'])
x12 = unlist(subset['Waist'])^2
x22 = unlist(subset['Neck'])^2
y = unlist(subset['Weight'])
reg1 = lm(y ~ x1 + x2 + x1*x2 + x12 + x22)
print('Model 1')
print(summary(reg1))
print(anova(reg1))

#Model 2
x1 = unlist(subset['Waist'])
x2 = unlist(subset['Waist'])^2
x3 = unlist(subset['Waist'])^3
y = unlist(subset['Weight'])
reg2 = lm(y ~ x1 + x2 + x3)
print('Model 2')
print(summary(reg2))
print(anova(reg2))

#Model 3
x1 = unlist(subset['Waist'])
x2 = unlist(subset['Neck'])
x3 = unlist(subset['Carbs'])
x4 = unlist(subset['Sugar'])
x5 = unlist(subset['Protein'])
y = unlist(subset['Weight'])
reg3 = lm(y ~ x1 + x2 + x3 + x4 + x5)
print('Model 3')
print(summary(reg3))
print(anova(reg3))

#Model 4
x1 = unlist(subset['Waist'])
y = log(unlist(subset['Weight']))
reg4 = lm(y ~ x1)
print('Model 4')
print(summary(reg4))
print(anova(reg4))

#Model 5
x2 = unlist(subset['Neck'])
y = log(unlist(subset['Weight']))
reg5 = lm(y ~ x2)
print('Model 5')
print(summary(reg5))
print(anova(reg5))

#Model 6
x3 = unlist(subset['Carbs'])
y = log(unlist(subset['Weight']))
reg6 = lm(y ~ x3)
print('Model 6')
print(summary(reg6))
print(anova(reg6))

#Model 7
x4 = unlist(subset['Sugar'])
y = log(unlist(subset['Weight']))
reg7 = lm(y ~ x4)
print('Model 7')
print(summary(reg7))
print(anova(reg7))

## Storing R^2 Values and Determining Best Model
rsquared = c(summary(reg1)$r.squared, summary(reg2)$r.squared, summary(reg3)$r.squared, summary(reg4)$r.squared, summary(reg5)$r.squared, summary(reg6)$r.squared, summary(reg7)$r.squared)

print(rsquared)
cat('\nBest Model is:')
which(rsquared == max(rsquared))

## Storing Adjusted R^2 Values and Determining Best Model
rsquaredadj = c(summary(reg1)$adj.r.squared, summary(reg2)$adj.r.squared, summary(reg3)$adj.r.squared, summary(reg4)$adj.r.squared, summary(reg5)$adj.r.squared, summary(reg6)$adj.r.squared, summary(reg7)$adj.r.squared)

print(rsquaredadj)
cat('\nBest Model is:')
which(rsquaredadj == max(rsquaredadj))

## Comparing Log And Linear R^2


## Storing F Statistic Values and Associated P-Values
fstat = c(summary(reg1)$fstatistic[1], summary(reg2)$fstatistic[1], summary(reg3)$fstatistic[1], summary(reg4)$fstatistic[1], summary(reg5)$fstatistic[1], summary(reg6)$fstatistic[1], summary(reg7)$fstatistic[1])
print(fstat)

fpvalue = c(anova(reg1)$'Pr(>F)'[1], anova(reg2)$'Pr(>F)'[1], anova(reg3)$'Pr(>F)'[1], anova(reg4)$'Pr(>F)'[1], anova(reg5)$'Pr(>F)'[1], anova(reg6)$'Pr(>F)'[1], anova(reg7)$'Pr(>F)'[1])
print(fpvalue)

## Storing Model MSE Values
MSE = c(anova(reg1)[6, 3], anova(reg2)[4, 3], anova(reg3)[6, 3], anova(reg4)[2, 3], anova(reg5)[2, 3], anova(reg6)[2, 3], anova(reg7)[2, 3])
print(MSE)

## Storing Model T Values
T = c(summary(reg1)$coefficients[,3], summary(reg2)$coefficients[,3], summary(reg3)$coefficients[,3], summary(reg4)$coefficients[,3], summary(reg5)$coefficients[,3], summary(reg6)$coefficients[,3], 
	summary(reg7)$coefficients[,3])

for (i in 1:length(T)) {
	print(T[i])
}

## Determining The Coefficient Of Variation For Each Model
for (i in 1:length(MSE)) {
	S2 = MSE[i]
	S = sqrt(S2)
	CV = 100*(S/mean(unlist(subset['Weight'])))
	print(CV)
}

## Corrected CV For Log Models
for (i in 4:length(MSE)) {
	S2 = MSE[i]
	S = sqrt(S2)
	CV = 100*(S/mean(unlist(log(subset['Weight']))))
	print(CV)
}

## Nested Model Check
x1 = unlist(subset['Waist'])
x2 = unlist(subset['Neck'])
y = unlist(subset['Weight'])
reduced1 = lm(y ~ x1 + x2 + x1*x2)
Ranova1 = anova(reduced1)

SSEC1 = anova(reg1)[6, 2]
SSER1 = Ranova1[4, 2]
F1 = ((SSER1 - SSEC1)/2)/(SSEC1/220)
print('The F Statistic For Nested Model 1 is:')
F1

## Creating a Correlation Martrix and Heatmap to Check for Multicollinearity
cor(subset)
corrplot(cor(subset))
palette = colorRampPalette(c("blue", "white", "red")) (20)
heatmap(x = cor(subset), col = palette, symm = TRUE, main = 'Correlation Matrix Heatmap')

## Variance Inflation Factor
VIF = c(vif(reg1), vif(reg2), vif(reg3))
print(VIF)

## Durbin-Watson Statistics
DW = c(durbinWatsonTest(reg1), durbinWatsonTest(reg2), durbinWatsonTest(reg3), durbinWatsonTest(reg4), durbinWatsonTest(reg5), durbinWatsonTest(reg6), durbinWatsonTest(reg7))
print(DW)

##Residual Plots for All Variables Against Weight
###Model 1
	res = resid(reg1)
	plot(fitted(reg1), res, main = 'Model 1 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals", pch = 17, col = 'darkorange')
	abline(0,0, lty = 1, lwd = 2, col = 'turquoise1')

###Model 2
	res = resid(reg2)
	plot(fitted(reg2), res, main = 'Model 2 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals", pch = 17, col = 'darkorange')
	abline(0,0, lty = 1, lwd = 2, col = 'turquoise1')

###Model 3
	res = resid(reg3)
	plot(fitted(reg3), res, main = 'Model 3 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals", pch = 17, col = 'darkorange')
	abline(0,0, lty = 1, lwd = 2, col = 'turquoise1')

###Model 4
	res = resid(reg4)
	plot(fitted(reg4), res, main = 'Model 4 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals", pch = 17, col = 'darkorange')
	abline(0,0, lty = 1, lwd = 2, col = 'turquoise1')

###Model 5
	res = resid(reg5)
	plot(fitted(reg5), res, main = 'Model 5 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals", pch = 17, col = 'darkorange')
	abline(0,0, lty = 1, lwd = 2, col = 'turquoise1')

###Model 6
	res = resid(reg6)
	plot(fitted(reg6), res, main = 'Model 6 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals", pch = 17, col = 'darkorange')
	abline(0,0, lty = 1, lwd = 2, col = 'turquoise1')

###Model 7
	res = resid(reg7)
	plot(fitted(reg7), res, main = 'Model 7 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals", pch = 17, col = 'darkorange')
	abline(0,0, lty = 1, lwd = 2, col = 'turquoise1')