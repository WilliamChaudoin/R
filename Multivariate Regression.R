####### Multivariate Health Regression
## Libraries and Directory
setwd("C:/Users/willc/OneDrive/Documents/Game Plan/Portfolio/Staging")
if(!require(scatterplot3d)) { install.packages("scatterplot3d"); library(scatterplot3d) }
if(!require(car)) { install.packages("car"); library(car) }
if(!require(corrplot)) { install.packages("corrplot"); library(corrplot) }

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

# Multivariate Regression and ANOVA
## Two Variables
### Best Variables From Linear Checks
#Model 1
x1 = unlist(subset['Waist'])
x2 = unlist(subset['Neck'])
y = unlist(subset['Weight'])
reg1 = lm(y ~ x1 + x2)
print('Model 1')
print(summary(reg1))
print(anova(reg1))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 1 3D Scatterplot',  
	xlab = "Waist", ylab = "Neck",
              zlab = "Weight")

### Testing For The Best Diet Variable Combination
# Model 2
x1 = unlist(subset['Calories'])
x2 = unlist(subset['Carbs'])
reg2 = lm(y ~ x1 + x2)
print('Model 2')
print(summary(reg2))
print(anova(reg2))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 2 3D Scatterplot',  
	xlab = "Calories", ylab = "Carbs",
              zlab = "Weight")

# Model 3
x1 = unlist(subset['Calories'])
x2 = unlist(subset['Protein'])
reg3 = lm(y ~ x1 + x2)
print('Model 3')
print(summary(reg3))
print(anova(reg3))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 3 3D Scatterplot',  
	xlab = "Calories", ylab = "Protein",
              zlab = "Weight")

# Model 4
x1 = unlist(subset['Calories'])
x2 = unlist(subset['Sugar'])
reg4 = lm(y ~ x1 + x2)
print('Model 4')
print(summary(reg4))
print(anova(reg4))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 4 3D Scatterplot',  
	xlab = "Calories", ylab = "Sugar",
              zlab = "Weight")

# Model 5
x1 = unlist(subset['Calories'])
x2 = unlist(subset['Fiber'])
reg5 = lm(y ~ x1 + x2)
print('Model 5')
print(summary(reg5))
print(anova(reg5))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 5 3D Scatterplot',  
	xlab = "Calories", ylab = "Fiber",
              zlab = "Weight")

# Model 6
x1 = unlist(subset['Calories'])
x2 = unlist(subset['Fat'])
reg6 = lm(y ~ x1 + x2)
print('Model 6')
print(summary(reg6))
print(anova(reg6))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 6 3D Scatterplot',  
	xlab = "Calories", ylab = "Fat",
              zlab = "Weight")

# Model 7
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Fat'])
reg7 = lm(y ~ x1 + x2)
print('Model 7')
print(summary(reg7))
print(anova(reg7))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 7 3D Scatterplot',  
	xlab = "Carbs", ylab = "Fat",
              zlab = "Weight")

# Model 8
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Sugar'])
reg8 = lm(y ~ x1 + x2)
print('Model 8')
print(summary(reg8))
print(anova(reg8))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 8 3D Scatterplot',  
	xlab = "Carbs", ylab = "Sugar",
              zlab = "Weight")

# Model 9
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Protein'])
reg9 = lm(y ~ x1 + x2)
print('Model 9')
print(summary(reg9))
print(anova(reg9))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 9 3D Scatterplot',  
	xlab = "Carbs", ylab = "Protein",
              zlab = "Weight")

# Model 10
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Fiber'])
reg10 = lm(y ~ x1 + x2)
print('Model 10')
print(summary(reg10))
print(anova(reg10))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 10 3D Scatterplot',  
	xlab = "Carbs", ylab = "Fiber",
              zlab = "Weight")

# Model 11
x1 = unlist(subset['Protein'])
x2 = unlist(subset['Sugar'])
reg11 = lm(y ~ x1 + x2)
print('Model 11')
print(summary(reg11))
print(anova(reg11))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 11 3D Scatterplot',  
	xlab = "Protein", ylab = "Sugar",
              zlab = "Weight")

# Model 12
x1 = unlist(subset['Protein'])
x2 = unlist(subset['Fiber'])
reg12 = lm(y ~ x1 + x2)
print('Model 12')
print(summary(reg12))
print(anova(reg12))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 12 3D Scatterplot',  
	xlab = "Protein", ylab = "Fiber",
              zlab = "Weight")

# Model 13
x1 = unlist(subset['Protein'])
x2 = unlist(subset['Fat'])
reg13 = lm(y ~ x1 + x2)
print('Model 13')
print(summary(reg13))
print(anova(reg13))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 13 3D Scatterplot',  
	xlab = "Protein", ylab = "Fat",
              zlab = "Weight")

# Model 14
x1 = unlist(subset['Fiber'])
x2 = unlist(subset['Fat'])
reg14 = lm(y ~ x1 + x2)
print('Model 14')
print(summary(reg14))
print(anova(reg14))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 14 3D Scatterplot',  
	xlab = "Fiber", ylab = "Fat",
              zlab = "Weight")

# Model 15
x1 = unlist(subset['Fiber'])
x2 = unlist(subset['Sugar'])
reg15 = lm(y ~ x1 + x2)
print('Model 15')
print(summary(reg15))
print(anova(reg15))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 15 3D Scatterplot',  
	xlab = "Fiber", ylab = "Sugar",
              zlab = "Weight")

# Model 16
x1 = unlist(subset['Sugar'])
x2 = unlist(subset['Fat'])
reg16 = lm(y ~ x1 + x2)
print('Model 16')
print(summary(reg16))
print(anova(reg16))
scatterplot3d(x1, x2, y, color='purple', main = 'Model 16 3D Scatterplot',  
	xlab = "Sugar", ylab = "Fat",
              zlab = "Weight")

## Three Variables
# Model 17
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Sugar'])
x3 = unlist(subset['Calories'])
reg17 = lm(y ~ x1 + x2 + x3)
print('Model 17')
print(summary(reg17))
print(anova(reg17))

# Model 18
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Sugar'])
x3 = unlist(subset['Fat'])
reg18 = lm(y ~ x1 + x2 + x3)
print('Model 18')
print(summary(reg18))
print(anova(reg18))

# Model 19
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Sugar'])
x3 = unlist(subset['Fiber'])
reg19 = lm(y ~ x1 + x2 + x3)
print('Model 19')
print(summary(reg19))
print(anova(reg19))

# Model 20
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Sugar'])
x3 = unlist(subset['Protein'])
reg20 = lm(y ~ x1 + x2 + x3)
print('Model 20')
print(summary(reg20))
print(anova(reg20))

## Four Variables
# Model 21
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Sugar'])
x3 = unlist(subset['Protein'])
x4 = unlist(subset['Calories'])
reg21 = lm(y ~ x1 + x2 + x3 + x4)
print('Model 21')
print(summary(reg21))
print(anova(reg21))

# Model 22
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Sugar'])
x3 = unlist(subset['Protein'])
x4 = unlist(subset['Fat'])
reg22 = lm(y ~ x1 + x2 + x3 + x4)
print('Model 22')
print(summary(reg22))
print(anova(reg22))

# Model 23
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Sugar'])
x3 = unlist(subset['Protein'])
x4 = unlist(subset['Fiber'])
reg23 = lm(y ~ x1 + x2 + x3 + x4)
print('Model 23')
print(summary(reg23))
print(anova(reg23))

## Five Variables
# Model 24
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Sugar'])
x3 = unlist(subset['Protein'])
x4 = unlist(subset['Fat'])
x5 = unlist(subset['Calories'])
reg24 = lm(y ~ x1 + x2 + x3 + x4 + x5)
print('Model 24')
print(summary(reg24))
print(anova(reg24))

# Model 25
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Sugar'])
x3 = unlist(subset['Protein'])
x4 = unlist(subset['Fat'])
x5 = unlist(subset['Fiber'])
reg25 = lm(y ~ x1 + x2 + x3 + x4 + x5)
print('Model 25')
print(summary(reg25))
print(anova(reg25))

# Model 26
x1 = unlist(subset['Carbs'])
x2 = unlist(subset['Sugar'])
x3 = unlist(subset['Protein'])
x4 = unlist(subset['Fat'])
x5 = unlist(subset['Calories'])
x6 = unlist(subset['Fiber'])
reg26 = lm(y ~ x1 + x2 + x3 + x4 + x5 + x6)
print('Model 26')
print(summary(reg26))
print(anova(reg26))

## Storing R^2 Values and Determining Best Model
rsquared = c(summary(reg1)$r.squared, summary(reg2)$r.squared, summary(reg3)$r.squared, summary(reg4)$r.squared, summary(reg5)$r.squared, summary(reg6)$r.squared, summary(reg7)$r.squared, summary(reg8)$r.squared, 
	summary(reg9)$r.squared, summary(reg10)$r.squared, summary(reg11)$r.squared, summary(reg12)$r.squared, summary(reg13)$r.squared, summary(reg14)$r.squared, summary(reg15)$r.squared, summary(reg16)$r.squared, 
	summary(reg17)$r.squared, summary(reg18)$r.squared, summary(reg19)$r.squared, summary(reg20)$r.squared, summary(reg21)$r.squared, summary(reg22)$r.squared, summary(reg23)$r.squared, summary(reg24)$r.squared, 
	summary(reg25)$r.squared, summary(reg26)$r.squared)

print(rsquared)
cat('\nBest Model is:')
which(rsquared == max(rsquared))

## Storing Adjusted R^2 Values and Determining Best Model
rsquaredadj = c(summary(reg1)$adj.r.squared, summary(reg2)$adj.r.squared, summary(reg3)$adj.r.squared, summary(reg4)$adj.r.squared, summary(reg5)$adj.r.squared, summary(reg6)$adj.r.squared, summary(reg7)$adj.r.squared, summary(reg8)$adj.r.squared, 
	summary(reg9)$adj.r.squared, summary(reg10)$adj.r.squared, summary(reg11)$adj.r.squared, summary(reg12)$adj.r.squared, summary(reg13)$adj.r.squared, summary(reg14)$adj.r.squared, summary(reg15)$adj.r.squared, summary(reg16)$adj.r.squared, 
	summary(reg17)$adj.r.squared, summary(reg18)$adj.r.squared, summary(reg19)$adj.r.squared, summary(reg20)$adj.r.squared, summary(reg21)$adj.r.squared, summary(reg22)$adj.r.squared, summary(reg23)$adj.r.squared, summary(reg24)$adj.r.squared, 
	summary(reg25)$adj.r.squared, summary(reg26)$adj.r.squared)

print(rsquaredadj)
cat('\nBest Model is:')
which(rsquaredadj == max(rsquaredadj))

## Storing F Statistic Values and Associated P-Values
fstat = c(summary(reg1)$fstatistic[1], summary(reg2)$fstatistic[1], summary(reg3)$fstatistic[1], summary(reg4)$fstatistic[1], summary(reg5)$fstatistic[1], summary(reg6)$fstatistic[1], summary(reg7)$fstatistic[1], summary(reg8)$fstatistic[1], 
	summary(reg9)$fstatistic[1], summary(reg10)$fstatistic[1], summary(reg11)$fstatistic[1], summary(reg12)$fstatistic[1], summary(reg13)$fstatistic[1], summary(reg14)$fstatistic[1], summary(reg15)$fstatistic[1], summary(reg16)$fstatistic[1], 
	summary(reg17)$fstatistic[1], summary(reg18)$fstatistic[1], summary(reg19)$fstatistic[1], summary(reg20)$fstatistic[1], summary(reg21)$fstatistic[1], summary(reg22)$fstatistic[1], summary(reg23)$fstatistic[1], summary(reg24)$fstatistic[1], 
	summary(reg25)$fstatistic[1], summary(reg26)$fstatistic[1])
print(fstat)


fpvalue = c(anova(reg1)$'Pr(>F)'[1], anova(reg2)$'Pr(>F)'[1], anova(reg3)$'Pr(>F)'[1], anova(reg4)$'Pr(>F)'[1], anova(reg5)$'Pr(>F)'[1], anova(reg6)$'Pr(>F)'[1], anova(reg7)$'Pr(>F)'[1], anova(reg8)$'Pr(>F)'[1], 
	anova(reg9)$'Pr(>F)'[1], anova(reg10)$'Pr(>F)'[1], anova(reg11)$'Pr(>F)'[1], anova(reg12)$'Pr(>F)'[1], anova(reg13)$'Pr(>F)'[1], anova(reg14)$'Pr(>F)'[1], anova(reg15)$'Pr(>F)'[1], anova(reg16)$'Pr(>F)'[1], 
	anova(reg17)$'Pr(>F)'[1], anova(reg18)$'Pr(>F)'[1], anova(reg19)$'Pr(>F)'[1], anova(reg20)$'Pr(>F)'[1], anova(reg21)$'Pr(>F)'[1], anova(reg22)$'Pr(>F)'[1], anova(reg23)$'Pr(>F)'[1], anova(reg24)$'Pr(>F)'[1], 
	anova(reg25)$'Pr(>F)'[1], anova(reg26)$'Pr(>F)'[1])
print(fpvalue)

## Storing Model MSE Values
MSE = c(anova(reg1)[3, 3], anova(reg2)[3, 3], anova(reg3)[3, 3], anova(reg4)[3, 3], anova(reg5)[3, 3], anova(reg6)[3, 3], anova(reg7)[3, 3], anova(reg8)[3, 3], 
	anova(reg9)[3, 3], anova(reg10)[3, 3], anova(reg11)[3, 3], anova(reg12)[3, 3], anova(reg13)[3, 3], anova(reg14)[3, 3], anova(reg15)[3, 3], anova(reg16)[3, 3], 
	anova(reg17)[4, 3], anova(reg18)[4, 3], anova(reg19)[4, 3], anova(reg20)[4, 3], anova(reg21)[5, 3], anova(reg22)[5, 3], anova(reg23)[5, 3], anova(reg24)[6, 3], 
	anova(reg25)[6, 3], anova(reg26)[7, 3])
print(MSE)

## Storing Model T Values
T = c(summary(reg1)$coefficients[,3], summary(reg2)$coefficients[,3], summary(reg3)$coefficients[,3], summary(reg4)$coefficients[,3], summary(reg5)$coefficients[,3], summary(reg6)$coefficients[,3], 
	summary(reg7)$coefficients[,3], summary(reg8)$coefficients[,3], summary(reg9)$coefficients[,3], summary(reg10)$coefficients[,3], summary(reg11)$coefficients[,3], summary(reg12)$coefficients[,3], 
	summary(reg13)$coefficients[,3], summary(reg14)$coefficients[,3], summary(reg15)$coefficients[,3], summary(reg16)$coefficients[,3], summary(reg17)$coefficients[,3], summary(reg18)$coefficients[,3],
	summary(reg19)$coefficients[,3], summary(reg20)$coefficients[,3], summary(reg21)$coefficients[,3], summary(reg22)$coefficients[,3], summary(reg23)$coefficients[,3], summary(reg24)$coefficients[,3], 
	summary(reg25)$coefficients[,3], summary(reg26)$coefficients[,3])

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

## Creating a Correlation Martrix to Check for Multicollinearity
cor(subset)
corrplot(cor(subset))
palette = colorRampPalette(c("blue", "white", "red")) (20)
heatmap(x = cor(subset), col = palette, symm = TRUE, main = 'Correlation Matrix Heatmap')

## Variance Inflation Factor
VIF = c(vif(reg1), vif(reg2), vif(reg3), vif(reg4), vif(reg5), vif(reg6), vif(reg7), vif(reg8), 
	vif(reg9), vif(reg10), vif(reg11), vif(reg12), vif(reg13), vif(reg14), vif(reg15), vif(reg16), 
	vif(reg17), vif(reg18), vif(reg19), vif(reg20), vif(reg21), vif(reg22), vif(reg23), vif(reg24), 
	vif(reg25), vif(reg26))
print(VIF)

## Durbin-Watson Statistics
DW = c(durbinWatsonTest(reg1), durbinWatsonTest(reg2), durbinWatsonTest(reg3), durbinWatsonTest(reg4), durbinWatsonTest(reg5), durbinWatsonTest(reg6), durbinWatsonTest(reg7), durbinWatsonTest(reg8), 
	durbinWatsonTest(reg9), durbinWatsonTest(reg10), durbinWatsonTest(reg11), durbinWatsonTest(reg12), durbinWatsonTest(reg13), durbinWatsonTest(reg14), durbinWatsonTest(reg15), durbinWatsonTest(reg16), 
	durbinWatsonTest(reg17), durbinWatsonTest(reg18), durbinWatsonTest(reg19), durbinWatsonTest(reg20), durbinWatsonTest(reg21), durbinWatsonTest(reg22), durbinWatsonTest(reg23), durbinWatsonTest(reg24), 
	durbinWatsonTest(reg25), durbinWatsonTest(reg26))
print(DW)

##Residual Plots for All Variables Against Weight
###Model 1
	res = resid(reg1)
	plot(fitted(reg1), res, main = 'Model 1 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 2
	res = resid(reg2)
	plot(fitted(reg2), res, main = 'Model 2 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 3
	res = resid(reg3)
	plot(fitted(reg3), res, main = 'Model 3 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 4
	res = resid(reg4)
	plot(fitted(reg4), res, main = 'Model 4 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 5
	res = resid(reg5)
	plot(fitted(reg5), res, main = 'Model 5 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 6
	res = resid(reg6)
	plot(fitted(reg6), res, main = 'Model 6 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 7
	res = resid(reg7)
	plot(fitted(reg7), res, main = 'Model 7 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 8
	res = resid(reg8)
	plot(fitted(reg8), res, main = 'Model 8 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 9
	res = resid(reg9)
	plot(fitted(reg9), res, main = 'Model 9 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 10
	res = resid(reg10)
	plot(fitted(reg10), res, main = 'Model 10 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 11
	res = resid(reg11)
	plot(fitted(reg11), res, main = 'Model 11 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 12
	res = resid(reg12)
	plot(fitted(reg12), res, main = 'Model 12 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 13
	res = resid(reg13)
	plot(fitted(reg13), res, main = 'Model 13 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 14
	res = resid(reg14)
	plot(fitted(reg14), res, main = 'Model 14 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 15
	res = resid(reg15)
	plot(fitted(reg15), res, main = 'Model 15 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 16
	res = resid(reg16)
	plot(fitted(reg16), res, main = 'Model 16 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 17
	res = resid(reg17)
	plot(fitted(reg17), res, main = 'Model 17 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 18
	res = resid(reg18)
	plot(fitted(reg18), res, main = 'Model 18 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 19
	res = resid(reg19)
	plot(fitted(reg19), res, main = 'Model 19 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 20
	res = resid(reg20)
	plot(fitted(reg20), res, main = 'Model 20 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 21
	res = resid(reg21)
	plot(fitted(reg21), res, main = 'Model 21 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 22
	res = resid(reg22)
	plot(fitted(reg22), res, main = 'Model 22 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 23
	res = resid(reg23)
	plot(fitted(reg23), res, main = 'Model 23 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 24
	res = resid(reg24)
	plot(fitted(reg24), res, main = 'Model 24 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 25
	res = resid(reg25)
	plot(fitted(reg25), res, main = 'Model 25 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)

###Model 26
	res = resid(reg26)
	plot(fitted(reg26), res, main = 'Model 26 Residual Plot',  
	xlab = "Fitted Values", ylab = "Residuals")
	abline(0,0)