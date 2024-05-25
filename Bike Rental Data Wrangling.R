#### Bike Rental Data Wrangling

# Changing Directory Location And Loading Libraries
setwd('/')
getwd()
#install.packages('tidyverse')
library(tidyverse)

# Downloading Datasets
bike = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0321EN-SkillsNetwork/labs/datasets/raw_bike_sharing_systems.csv"
cities = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0321EN-SkillsNetwork/labs/datasets/raw_cities_weather_forecast.csv"
world = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0321EN-SkillsNetwork/labs/datasets/raw_worldcities.csv"
seoul = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0321EN-SkillsNetwork/labs/datasets/raw_seoul_bike_sharing.csv"
download.file(bike, destfile = 'raw_bike_sharing_systems.csv')
download.file(cities, destfile = 'raw_cities_weather_forecast.csv')
download.file(world, destfile = 'raw_worldcities.csv')
download.file(seoul, destfile = 'raw_seoul_bike_sharing.csv')

# Storing The Datasets
dataset_list = c('raw_bike_sharing_systems.csv', 'raw_seoul_bike_sharing.csv', 'raw_cities_weather_forecast.csv', 'raw_worldcities.csv')

# Preparing The Files
for (data in dataset_list){
    dataset = read_csv(data)
    names(dataset) = toupper(names(dataset))
    names(dataset) = str_replace_all(names(dataset), " ", "_")
    write.csv(dataset, data, row.names=FALSE)
}

# Analyzing Data State
for (data in dataset_list){
    dataset = read_csv(data)
    print(summary(dataset))
    print(str(dataset))
}

# Loading Webscrapping Data For Formatting
Bike = read_csv("raw_bike_sharing_systems.csv")
class(Bike)
head(Bike, 10)

# Creating Subset
subset = Bike %>% select(COUNTRY, CITY, SYSTEM, BICYCLES)
head(subset, 10)

# Searching For Unnecessary Characters
find_character = function(strings) grepl('[^0-9]', strings)
find_pattern = function(strings) grepl('\\[[A-z0-9]+\\]', strings)

subset %>% select(BICYCLES) %>% filter(find_character(BICYCLES)) %>% slice(0:20)
subset %>% select(BICYCLES) %>% filter(find_pattern(BICYCLES)) %>% slice(0:20)

subset %>% select(COUNTRY) %>% filter(find_character(COUNTRY)) %>% slice(0:20)
subset %>% select(COUNTRY) %>% filter(find_pattern(COUNTRY)) %>% slice(0:20)

subset %>% select(CITY) %>% filter(find_character(CITY)) %>% slice(0:20)
subset %>% select(CITY) %>% filter(find_pattern(CITY)) %>% slice(0:20)

subset %>% select(SYSTEM) %>% filter(find_character(SYSTEM)) %>% slice(0:20)
subset %>% select(SYSTEM) %>% filter(find_pattern(SYSTEM)) %>% slice(0:20)

# Remove Unnecessary Characters
remove = function(strings) {
    pattern = '\\[.*?\\]'
    result = str_replace_all(strings,pattern,'')
    result =  trimws(result) 
    return(result)
}

subset2 = subset %>% mutate(BICYCLES=remove(BICYCLES), SYSTEM=remove(SYSTEM), CITY=remove(CITY))

# Confirming All Unnecessary Characters Have Been Removed
subset2 %>% select(BICYCLES) %>% filter(find_character(BICYCLES)) %>% slice(0:20)
subset2 %>% select(BICYCLES) %>% filter(find_pattern(BICYCLES)) %>% slice(0:20)

subset2 %>% select(CITY) %>% filter(find_character(CITY)) %>% slice(0:20)
subset2 %>% select(CITY) %>% filter(find_pattern(CITY)) %>% slice(0:20)

subset2 %>% select(SYSTEM) %>% filter(find_character(SYSTEM)) %>% slice(0:20)
subset2 %>% select(SYSTEM) %>% filter(find_pattern(SYSTEM)) %>% slice(0:20)

# Issues Still Exist With Bicycles Column
extract = function(columns){
    digital_pattern = "\\d+"
    str_extract(columns, digital_pattern) %>% as.numeric()
}

subset2 = subset2 %>% mutate(BICYCLES=extract(BICYCLES))

# Checking If Issues Are Fixed
subset2 %>% select(CITY, SYSTEM, BICYCLES) %>% 
filter(find_pattern(CITY) | find_pattern(SYSTEM) | find_pattern(BICYCLES) |  find_character(BICYCLES))

summary(subset2)

# Fixing Missing Values
subset2 = drop_na(subset2, BICYCLES)
subset2 = drop_na(subset2, SYSTEM)
summary(subset2)
dim(subset2)

# Saving Cleaned Data
write.csv(subset2, 'bike_sharing_data.csv')








