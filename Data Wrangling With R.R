#### Data Wrangling With R

# Changing Directory Location And Loading Libraries
setwd('/')
getwd()
#install.packages('tidyverse')
library(tidyverse)

# Loading Data
url = 'https://dax-cdn.cdn.appdomain.cloud/dax-airline/1.0.1/lax_to_jfk.tar.gz'
download.file(url, destfile = 'lax_to_jfk.tar.gz')
untar('lax_to_jfk.tar.gz', tar = 'internal')

airline = read_csv('lax_to_jfk/lax_to_jfk.csv', col_types = 
	cols('DivDistance' = col_number(), 'DivArrDelay' = col_number()))

# Displaying Data
head(airline)
dim(airline)

# Columns And Data Types
colnames(airline)
sapply(airline, typeof)

# Using The Pipe Operator To Summarize Data
## Using Mean
airline %>% 
  filter(Month == 1) %>%
  group_by(Reporting_Airline) %>%
  summarize(avg_carrier_delay = mean(CarrierDelay, na.rm = TRUE))

airline %>%
  group_by(Reporting_Airline) %>%
  summarize(avg_carrier_delay = mean(CarrierDelay, na.rm = TRUE))

airline %>%
  group_by(Reporting_Airline) %>%
  summarize(airline_Delay = mean(ArrDelay, na.rm = TRUE))

## Using Standard Deviation
airline %>% 
  filter(Month == 1) %>%
  group_by(Reporting_Airline) %>%
  summarize(sd_carrier_delay = sd(CarrierDelay, na.rm = TRUE))

airline %>%
  group_by(Reporting_Airline) %>%
  summarize(sd_carrier_delay = sd(CarrierDelay, na.rm = TRUE))

airline %>%
  group_by(Reporting_Airline) %>%
  summarize(airline_Delay = sd(ArrDelay, na.rm = TRUE))

# Summarizing Using Glimpse
glimpse(airline)

# Checking For Missing Values
airline %>% summarize(count = sum(is.na(CarrierDelay)))

## All Columns
map(airline, ~sum(is.na(.)))

# Creating New Data Frame With Dropped Columns
airline2 <- airline %>% select(-DivDistance, -DivArrDelay)
dim(airline)
dim(airline2)

# Replacing Missing Values With Their Mean
airline3 = airline2 %>% replace_na(list(CarrierDelay = mean(airline$CarrierDelay, na.rm = TRUE),
                            WeatherDelay = mean(airline$WeatherDelay, na.rm = TRUE),
                            NASDelay = mean(airline$NASDelay, na.rm = TRUE),
                            SecurityDelay = mean(airline$SecurityDelay, na.rm = TRUE),
                            LateAircraftDelay = mean(airline$LateAircraftDelay, na.rm = TRUE)))

map(airline3, ~sum(is.na(.)))

# Summarizing New Data Frame
airline3 %>% summarize_all(class) %>% gather(variable, class)

# Splitting Columns
airline3 <- airline3 %>% separate(FlightDate, sep = "-", into = c("Year", "Month", "Day"))
head(airline3)

# Formatting
airline3 %>% select(Year, Month, Day) %>% mutate_all(type.convert) %>% 
	mutate_if(is.character, as.numeric)

# Data Normalization Using Scaling
airline3$ArrDelay = airline3$ArrDelay / max(airline3$ArrDelay)
head(airline3$ArrDelay)

airline3$DepDelay <- airline3$DepDelay/max(airline3$DepDelay)
head(airline3$DepDelay)

# Data Normalization Using Min-Max
airline3$ArrDelay = (airline3$ArrDelay - min(airline3$ArrDelay)) /
                (max(airline3$ArrDelay) - min(airline3$ArrDelay))
head(airline3$ArrDelay)

airline3$DepDelay = (airline3$DepDelay - min(airline3$DepDelay)) /
                (max(airline3$DepDelay) - min(airline3$DepDelay))
head(airline3$DepDelay)

# Data Normalization Using Z-Score
airline3$ArrDelay = (airline3$ArrDelay - mean(airline3$ArrDelay)) / sd(airline3$ArrDelay)
head(airline3$ArrDelay)

airline3$DepDelay = (airline3$DepDelay - mean(airline3$DepDelay)) / sd(airline3$DepDelay)
head(airline3$DepDelay)

# Binning
bins = airline3 %>% mutate(quantile_rank = ntile(airline3$ArrDelay,4))

ggplot(data = bins, mapping = aes(x = quantile_rank)) +
  geom_histogram(bins = 4, color = "white", fill = "blue")

# Saving Data For Further Use
write_csv(airline3, 'airline_data.csv')