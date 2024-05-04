#### JFK Airport Weather Analysis

# Changing Directory Location And Loading Libraries
setwd('/')
getwd()
#install.packages('tidyverse')
#install.packages('rlang')
#install.packages('tidymodels')
library(rlang)
library(tidymodels)
library(tidyverse)

# Loading Data
url = "https://dax-cdn.cdn.appdomain.cloud/dax-noaa-weather-data-jfk-airport/1.1.4/noaa-weather-sample-data.tar.gz"
download.file(url, destfile = "noaa-weather-sample-data.tar.gz")
untar('noaa-weather-sample-data.tar.gz', tar = 'internal')

# Creating Data Frames And Subset
weather = read_csv('noaa-weather-sample-data/jfk_weather_sample.csv')
glimpse(weather)
head(weather)

subset = as.data.frame(weather %>% select(HOURLYRelativeHumidity, HOURLYDRYBULBTEMPF, HOURLYPrecip, HOURLYWindSpeed, HOURLYStationPressure))
head(subset)

# Cleaning Columns
unique(subset$HOURLYPrecip)
length(unique(subset$HOURLYPrecip))

subset = subset %>% mutate(HOURLYPrecip = 
	as.character(str_replace(str_remove_all(HOURLYPrecip, "s$"), "T", "0.0")))

unique(subset$HOURLYPrecip)
length(unique(subset$HOURLYPrecip))

glimpse(subset)
subset$HOURLYPrecip = as.numeric(subset$HOURLYPrecip)
glimpse(subset)

subset = subset %>% rename(relative_humidity = HOURLYRelativeHumidity,
                             dry_bulb_temp_f = HOURLYDRYBULBTEMPF,
                             precip = HOURLYPrecip,
                             wind_speed = HOURLYWindSpeed,
                             station_pressure = HOURLYStationPressure)

# Spliting Data Into Testing and Training Sets
set.seed(1234)
weather_split = initial_split(subset, prop = 0.8)
train_data = training(weather_split)
test_data = testing(weather_split)

# Analyzing Distributions In Training Data
ggplot(data = train_data, mapping = aes(x = relative_humidity)) +
  geom_histogram(color = "black", fill = "blue")

ggplot(data = train_data, mapping = aes(x = dry_bulb_temp_f)) +
  geom_histogram(color = "black", fill = "blue")

ggplot(data = train_data, mapping = aes(x = precip)) +
  geom_histogram(color = "black", fill = "blue")

ggplot(data = train_data, mapping = aes(x = wind_speed)) +
  geom_histogram(color = "black", fill = "blue")

ggplot(data = train_data, mapping = aes(x = station_pressure)) +
  geom_histogram(color = "black", fill = "blue")

# Regression Models
## Linear 1
Linear1 = lm(precip ~ relative_humidity, data = train_data)
ggplot(data = train_data, mapping = aes(x = relative_humidity, y = precip)) +
   geom_point()+ stat_smooth(method = "lm", col = "red") + geom_smooth(method = "lm", na.rm = TRUE) +
   ggtitle('Relative Humidity vs Precipitation')
Linear1.MSE = mean(Linear1$residuals^2)
Linear1.RMSE = sqrt(Linear1.MSE)
Linear1.R2 = summary(Linear1)$r.squared

## Linear 2
Linear2 = lm(precip ~ dry_bulb_temp_f, data = train_data)
ggplot(data = train_data, mapping = aes(x = dry_bulb_temp_f, y = precip)) +
   geom_point()+ stat_smooth(method = "lm", col = "red") + 
   geom_smooth(method = "lm", na.rm = TRUE)+
   ggtitle('Air Temperature vs Precipitation')

## Linear 3
Linear3 = lm(precip ~ wind_speed, data = train_data)
ggplot(data = train_data, mapping = aes(x = wind_speed, y = precip)) +
   geom_point()+ stat_smooth(method = "lm", col = "red") + 
   geom_smooth(method = "lm", na.rm = TRUE) +
   ggtitle('Wind Speed vs Precipitation')

## Linear4
Linear4 = lm(precip ~ station_pressure, data = train_data)
ggplot(train_data, aes(x = station_pressure, y = precip)) +
  geom_point() + stat_smooth(method = "lm", col = "red") +
  geom_smooth(method = "lm", na.rm = TRUE) +
  ggtitle('Station Pressure vs Precipitation')

## Multiple
MLR = lm(precip ~ station_pressure + relative_humidity + dry_bulb_temp_f, data = train_data)
summary(MLR)
(MLR.MSE = mean(MLR$residuals^2))
(MLR.RMSE = sqrt(MLR.MSE))
(MLR.R2 = summary(MLR)$r.squared)

## Poly
Poly = lm(precip ~ poly(relative_humidity, 3, raw = TRUE), data = train_data)
summary(Poly)
(Poly.MSE = mean(Poly$residuals^2))
(Poly.RMSE = sqrt(Poly.MSE))
(Poly.R2 = summary(Poly)$r.squared)

# Using Testing Data
## Linear
Linear = lm(precip ~ relative_humidity, data = test_data)
summary(Linear)
(Linear.MSE = mean(Linear$residuals^2))
(Linear.RMSE = sqrt(Linear.MSE))
(Linear.R2 = summary(Linear)$r.squared)

## Multiple
MLR2 = lm(precip ~ station_pressure + relative_humidity + dry_bulb_temp_f, data = test_data)
summary(MLR2)
(MLR2.MSE = mean(MLR2$residuals^2))
(MLR2.RMSE = sqrt(MLR2.MSE))
(MLR2.R2 = summary(MLR2)$r.squared)

## Poly
Poly2 = lm(precip ~ poly(relative_humidity, 3, raw = TRUE), data = test_data)
summary(Poly2)
(Poly2.MSE = mean(Poly2$residuals^2))
(Poly2.RMSE = sqrt(Poly2.MSE))
(Poly2.R2 = summary(Poly2)$r.squared)

# Comparing Models
## MSE
model_names = c('Linear', 'MLR', 'Poly')
train_error.mse = c(Linear1.MSE, MLR.MSE, Poly.MSE)
test_error.mse = c(Linear.MSE, MLR2.MSE, Poly2.MSE)
(mse_df = data.frame(model_names, train_error.mse, test_error.mse))

## RMSE
train_error.rmse = c(Linear1.RMSE, MLR.RMSE, Poly.RMSE)
test_error.rmse = c(Linear.RMSE, MLR2.RMSE, Poly2.RMSE)
(rmse_df = data.frame(model_names, train_error.rmse, test_error.rmse))

## R2
train_error.r2 = c(Linear1.R2, MLR.R2, Poly.R2)
test_error.r2 = c(Linear.R2, MLR2.R2, Poly2.R2)
(r2_df = data.frame(model_names, train_error.r2, test_error.r2))

# The Polynominal model has the lowest MSE and RMSE with the highest R^2 of
# all models in both the training and testing datasets. 

