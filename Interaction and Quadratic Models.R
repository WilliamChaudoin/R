####### Interaction and Quadratic Regression Models For Health Data Study
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
subset = health[c(2,3,4,18,19,20,21,22,23)]
print(subset)
str(subset)

#Model 1
x1 = unlist(subset['Waist'])
x2 = unlist(subset['Neck'])
y = unlist(subset['Weight'])
reg1 = lm(y ~ x1 + x2 + x1*x2)
print('Model 1')
print(summary(reg1))
print(anova(reg1))

#Model 2
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Sugar'])
reg2 = lm(y ~ x1 + x2 + x1*x2)
print('Model 2')
print(summary(reg2))
print(anova(reg2))

#Model 3
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Protein'])
reg3 = lm(y ~ x1 + x2 + x1*x2)
print('Model 3')
print(summary(reg3))
print(anova(reg3))

#Model 4
x1 = unlist(subset['Protein'])
x2 = unlist(subset['Sugar'])
reg4 = lm(y ~ x1 + x2 + x1*x2)
print('Model 4')
print(summary(reg4))
print(anova(reg4))

#Model 5
x1 = unlist(subset['Waist'])
xsquared = (x1)^2
reg5 = lm(y ~ x1 + xsquared)
print('Model 5')
print(summary(reg5))
print(anova(reg5))
plot(x1, y, data = subset, main = 'Model 5: Scatterplot With Quadratic Regression Line',  
	xlab = "Waist", ylab = "Weight")
lines(x1, fitted(reg5), col = "red") 

#Model 6
x1 = unlist(subset['Neck'])
xsquared = (x1)^2
reg6 = lm(y ~ x1 + xsquared)
print('Model 6')
print(summary(reg6))
print(anova(reg6))
plot(x1, y, data = subset, main = 'Model 6: Scatterplot With Quadratic Regression Line',  
	xlab = "Neck", ylab = "Weight")
lines(x1, fitted(reg6), col = "red") 

#Model 7
x1 = unlist(subset['Carbs'])
xsquared = (x1)^2
reg7 = lm(y ~ x1 + xsquared)
print('Model 7')
print(summary(reg7))
print(anova(reg7))
plot(x1, y, data = subset, main = 'Model 7: Scatterplot With Quadratic Regression Line',  
	xlab = "Carbs", ylab = "Weight")
lines(x1, fitted(reg7), col = "red") 

#Model 8
x1 = unlist(subset['Sugar'])
xsquared = (x1)^2
reg8 = lm(y ~ x1 + xsquared)
print('Model 8')
print(summary(reg8))
print(anova(reg8))
plot(x1, y, data = subset, main = 'Model 8: Scatterplot With Quadratic Regression Line',  
	xlab = "Sugar", ylab = "Weight")
lines(x1, fitted(reg8), col = "red")

#Model 9
x1 = unlist(subset['Protein'])
xsquared = (x1)^2
reg9 = lm(y ~ x1 + xsquared)
print('Model 9')
print(summary(reg9))
print(anova(reg9))
plot(x1, y, data = subset, main = 'Model 9: Scatterplot With Quadratic Regression Line',  
	xlab = "Protein", ylab = "Weight")
lines(x1, fitted(reg9), col = "red")

## Storing Adjusted R^2 Values and Determining Best Model
rsquaredadj = c(summary(reg1)$adj.r.squared, summary(reg2)$adj.r.squared, summary(reg3)$adj.r.squared, summary(reg4)$adj.r.squared, summary(reg5)$adj.r.squared, summary(reg6)$adj.r.squared, summary(reg7)$adj.r.squared, summary(reg8)$adj.r.squared, 
	summary(reg9)$adj.r.squared)

print(rsquaredadj)
cat('\nBest Model is:')
which(rsquaredadj == max(rsquaredadj))

## Storing F Statistic Values and Associated P-Values
fstat = c(summary(reg1)$fstatistic[1], summary(reg2)$fstatistic[1], summary(reg3)$fstatistic[1], summary(reg4)$fstatistic[1], summary(reg5)$fstatistic[1], summary(reg6)$fstatistic[1], summary(reg7)$fstatistic[1], summary(reg8)$fstatistic[1], 
	summary(reg9)$fstatistic[1])
print(fstat)

fpvalue = c(anova(reg1)$'Pr(>F)'[1], anova(reg2)$'Pr(>F)'[1], anova(reg3)$'Pr(>F)'[1], anova(reg4)$'Pr(>F)'[1], anova(reg5)$'Pr(>F)'[1], anova(reg6)$'Pr(>F)'[1], anova(reg7)$'Pr(>F)'[1], anova(reg8)$'Pr(>F)'[1], 
	anova(reg9)$'Pr(>F)'[1])
print(fpvalue)

## Storing Model MSE Values
MSE = c(anova(reg1)[4, 3], anova(reg2)[4, 3], anova(reg3)[4, 3], anova(reg4)[4, 3], anova(reg5)[3, 3], anova(reg6)[3, 3], anova(reg7)[3, 3], anova(reg8)[3, 3], 
	anova(reg9)[3, 3])
print(MSE)

## Storing Model T Values
T = c(summary(reg1)$coefficients[,3], summary(reg2)$coefficients[,3], summary(reg3)$coefficients[,3], summary(reg4)$coefficients[,3], summary(reg5)$coefficients[,3], summary(reg6)$coefficients[,3], 
	summary(reg7)$coefficients[,3], summary(reg8)$coefficients[,3], summary(reg9)$coefficients[,3])

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

## Creating a Correlation Martrix and Heatmap to Check for Multicollinearity
cor(subset)
corrplot(cor(subset))
palette = colorRampPalette(c("blue", "white", "red")) (20)
heatmap(x = cor(subset), col = palette, symm = TRUE, main = 'Correlation Matrix Heatmap')

## Variance Inflation Factor
VIF = c(vif(reg1), vif(reg2), vif(reg3), vif(reg4), vif(reg5), vif(reg6), vif(reg7), vif(reg8), 
	vif(reg9))
print(VIF)

## Durbin-Watson Statistics
DW = c(durbinWatsonTest(reg1), durbinWatsonTest(reg2), durbinWatsonTest(reg3), durbinWatsonTest(reg4), durbinWatsonTest(reg5), durbinWatsonTest(reg6), durbinWatsonTest(reg7), durbinWatsonTest(reg8), 
	durbinWatsonTest(reg9))
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

###Model 8
	res = resid(reg8)
	plot(fitted(reg8), res, main = 'Model 8 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals", pch = 17, col = 'darkorange')
	abline(0,0, lty = 1, lwd = 2, col = 'turquoise1')

###Model 9
	res = resid(reg9)
	plot(fitted(reg9), res, main = 'Model 9 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals", pch = 17, col = 'darkorange')
	abline(0,0, lty = 1, lwd = 2, col = 'turquoise1')