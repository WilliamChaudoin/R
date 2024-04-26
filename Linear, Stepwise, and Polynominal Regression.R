##### Linear, Stepwise, and Polynominal Regression

# Change Working Directory Location And Loading Data
setwd('/')
getwd()

load(file = 'PortfolioData.RData')
ls()

# Simple Linear Regression
(reg = lm(abund ~ flow, data = af))
names(reg)

# Coefficient Command
reg$coefficients
coef(reg)

# Confidence Interval
confint(reg)

# Fitted Command
reg$fitted.values
fitted(reg)

# Residuals Command
reg$residuals
residuals(reg)

# Formula Command
formula(reg)
reg$call

# Best-Fit Line
plot(abund ~ flow, data = af)
abline(reg)

plot(reg)

# Using ANOVA On A Regression
anova(reg)

# Stepwise Regression
## Forward
cor(M)
(m.reg = lm(Length ~ 1, data = M))
add1(m.reg, scope = M)
(m.reg2 = lm(Length ~ BOD, data = M))
add1(m.reg2, scope = M)
(m.reg3 = lm(Length ~ BOD + Speed, data = M))
add1(m.reg3, scope = M, test = 'F')

## Backward
(m.lm = lm(Length ~., data = M))
drop1(m.lm, test = 'F')
(m.lm2 = lm(Length ~ Speed + NO3 + BOD, data = M))
drop1(m.lm2, test = 'F')

## Comparing Models
anova(m.reg3, m.lm2)

# Logarithmic Regression
growth = c(2, 9, 11, 12, 13, 14, 17, 19, 17, 18, 20)
nutrient = c(2, 4, 6, 8, 10, 16, 22, 28, 30, 36, 48)
pg = data.frame(growth, nutrient)
plot(growth ~ nutrient, data = pg)
pg.lm = lm(growth ~ log(nutrient), data = pg)
summary(pg.lm)

# Polynomial Regression
(dl.lm = lm(dark ~ light + I(light^2), data = dl))
summary(dl.lm)

# Plotting Linear and Curvilinear Models
plot(growth ~ nutrient, data = pg)
lines(pg$nutrient, fitted(pg.lm))

plot(dark ~ light, data = dl)
lines(dl$light, fitted(dl.lm))

## Alternative With Spline
plot(dark ~ light, data = dl)
lines(spline(dl$light, fitted(dl.lm)), lwd = 2)

# Adding Confidence Interval to a Regression Plot
prd = predict(m.reg3, interval = 'confidence')
prd = as.data.frame(prd)
prd$Length = M$Length
prd = prd[order(prd$Length),]
plot(Length ~ fit, prd, xlab = 'Fitted Values')
abline(lm(Length ~ fit, prd))
