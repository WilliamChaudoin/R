#### Regression Models With R

# Changing Directory Location And Loading Libraries
setwd('/')
getwd()
#install.packages('tidyverse')
library(tidyverse)

# Loading Data For Modeling
url = "https://dax-cdn.cdn.appdomain.cloud/dax-airline/1.0.1/lax_to_jfk.tar.gz"
download.file(url, destfile = "lax_to_jfk.tar.gz")
untar('lax_to_jfk.tar.gz', tar = 'internal')

airline = read_csv('lax_to_jfk/lax_to_jfk.csv', col_types = 
	cols('DivDistance' = col_number(), 'DivArrDelay' = col_number()))

# Creating A Subset
subset = airline %>% filter(CarrierDelay != "NA", Reporting_Airline == "AA")
head(subset)

# Linear Regression Model
Linear = lm(ArrDelayMinutes ~ DepDelayMinutes, data = subset)
summary(Linear)

## Using The Model To Predict
PredictFrame = data.frame(DepDelayMinutes = c(12, 19, 24))

Prediction1 = predict(Linear, newdata = PredictFrame, interval = "confidence")
Prediction1
## Predicts that based on flights delayed 12, 19, and 24 minutes, they will 
## arrive 26.38, 31.64, and 35.40 minutes late.

# Second Linear Model
Linear2 = lm(ArrDelayMinutes ~ CarrierDelay, data = subset)
summary(Linear2)

## Resulting Equation
# ArrDelayMinutes = 35.11 + 0.70*(CarrierDelay)

# Multiple Linear Regression
MLR = lm(ArrDelayMinutes ~ DepDelayMinutes + LateAircraftDelay, data = subset)
summary(MLR)

## Resulting Equation
# ArrDelayMinutes = 17.32 + 0.7556*DepDelayMinutes - 0.0103*LateAircraftDelay

## Using The Model To Predict
PredictFrame2 = data.frame((DepDelayMinutes = c(10, 20, 30)), (LateAircraftDelay <- c(20, 60, 30)))

Prediction2 = predict(MLR, newdata = PredictFrame, interval = "confidence")
Prediction2

# Multiple Linear Regression 2
MLR2 = lm(ArrDelayMinutes ~ DepDelayMinutes + LateAircraftDelay + CarrierDelay, 
	data = subset)
summary(MLR2)

# Regression Plots
ggplot(subset, aes(x = DepDelayMinutes, y = ArrDelayMinutes)) +
  geom_point() + stat_smooth(method = "lm", col = "red")

ggplot(subset, aes(x = CarrierDelay, y = ArrDelayMinutes)) +
  geom_point() + stat_smooth(method = "lm", col = "red")

## Correlations
cor(subset$DepDelayMinutes, subset$ArrDelayMinutes)
cor(subset$CarrierDelay, subset$ArrDelayMinutes)

# Residual Plots
ggplot(lm(ArrDelayMinutes ~ DepDelayMinutes, data = subset)) +
  geom_point(aes(x=DepDelayMinutes, y=.resid))
plot(Linear)

# Polynominal Models
## Model 1
time = 6:19
temp = c(4,6,7,9,10,11,11.5,12,12,11.5,11,10,9,8)
ggplot(data = NULL, aes(time, temp)) + geom_point() 

Poly1 <- lm(temp ~ poly(time, 2, raw = TRUE))
summary(Poly1)

ggplot(data = NULL, aes(time, temp)) + 
    geom_point() + geom_smooth(method = "lm", formula = y ~ poly(x, 2)) 

## Model 2
Poly2 = lm(temp ~ poly(time, 4, raw = TRUE))
summary(Poly2)

ggplot(data = NULL, aes(time, temp)) + 
    geom_point() + geom_smooth(method = "lm", formula = y ~ poly(x, 4)) 

# Comparing Models
## Linear
summary(Linear)
(Linear.MSE = mean(Linear$residuals^2))
(Linear.RMSE = sqrt(Linear.MSE))
(Linear.R2 = summary(Linear)$r.squared)

## Multiple
summary(MLR)
(MLR.MSE = mean(MLR$residuals^2))
(MLR.RMSE = sqrt(MLR.MSE))
(MLR.R2 = summary(MLR)$r.squared)

## Polynominal
Poly = lm(ArrDelayMinutes ~ poly(DepDelayMinutes, 3), data = subset)

summary(Poly)
(Poly.MSE = mean(Poly$residuals^2))
(Poly.RMSE = sqrt(Poly.MSE))
(Poly.R2 = summary(Poly)$r.squared)

# Comparing Models
model_names = c('Linear', 'MLR', 'Poly')
MSE = c(Linear.MSE, MLR.MSE, Poly.MSE)
RMSE = c(Linear.RMSE, MLR.RMSE, Poly.RMSE)
R2 = c(Linear.R2, MLR.R2, Poly.R2)
(comparison = data.frame(model_names, MSE, RMSE, R2))

### Polynominal model performs the best with the lowest MSE and 
### RMSE along with the highest R2 of any model.
