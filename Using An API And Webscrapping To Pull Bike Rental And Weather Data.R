#### Using An API And Webscrapping To Pull Bike Rental And Weather Data

# Changing Directory Location And Loading Libraries
setwd('/')
getwd()

#install.packages('httr')
#install.packages('rvest')
#install.packages('xml2')
library(httr)
library(rvest)
library(xml2)

# Establishing Connection
url <- "https://en.wikipedia.org/wiki/List_of_bicycle-sharing_systems"
root_html = read_html(url)

# Extracting The Root Node
(root_node = xml_root(root_html))

# Extracting The Table Node
(table_node = html_nodes(root_node, 'table'))

# Converting The Table Node Into A Data Frame
DF = as.data.frame(html_table(table_node[1], fill = TRUE))

# Summarizing The Data
summary(DF)
head(DF)

# Export The Data As A CSV File
write.csv(DF, file = 'raw_bike_sharing_systems.csv')

# Confirming Download
file_path = paste(getwd(), sep="", "/raw_bike_sharing_systems.csv")
print(file_path)
file.exists(file_path)

# Creating Empty Vectors To Fille
city <- c()
weather <- c()
visibility <- c()
temp <- c()
temp_min <- c()
temp_max <- c()
pressure <- c()
humidity <- c()
wind_speed <- c()
wind_deg <- c()
forecast_datetime <- c()
season <- c()

# Setting Up Connection Via A Function
get_weather <- function(city_names){
    df <- data.frame()
    for (city_name in city_names){
        forecast_url = 'https://api.openweathermap.org/data/2.5/forecast'
        forecast_query = list(q = city_name, appid = '738ba8f9647df9ddb9d96f6d6643fcdd', units="metric")
        response = GET(forecast_url, query=forecast_query)
        json_result = content(response, as="parsed")
        for(result in json_result) {
    city <- c(city, json_result$city$name)
    weather <- c(weather, json_result$list[[1]]$weather[[1]]$main)
    visibility <- c(visibility, json_result$list[[1]]$visibility)
    temp <- c(temp, json_result$list[[1]]$main$temp)
    temp_min <-c(temp_min, json_result$list[[1]]$main$temp_min)
    temp_max <- c(temp_max, json_result$list[[1]]$main$temp_max)
    pressure <- c(pressure, json_result$list[[1]]$main$pressure)
    humidity <- c(humidity, json_result$list[[1]]$main$humidity)
    wind_speed <- c(wind_speed, json_result$list[[1]]$wind$speed)
    wind_deg <- c(wind_deg, json_result$list[[1]]$wind$deg)
    forecast_datetime <- c(forecast_datetime, json_result$list[[1]]$dt_txt)
    season <- c(season, json_result$list[[1]]$dt_txt)
        }
        
        # Add the R Lists into a data frame
    df <- data.frame(city = city,
                            weather=weather, 
                             visibility=visibility, 
                             temp=temp, 
                             temp_min=temp_min, 
                             temp_max=temp_max, 
                             pressure=pressure, 
                             humidity=humidity, 
                             wind_speed=wind_speed, 
                             wind_deg=wind_deg, 
				     forecast_datetime = forecast_datetime,
				     season = season)
    }
    
    # Return a data frame
    return(df)
}

cities = c('Seoul', 'Washington, D.C.', 'Paris', 'Suzhou')
apidata = get_weather(cities)
head(apidata)

# Write cities_weather_df to `cities_weather_forecast.csv`
write.csv(apidata, "cities_weather_forecast.csv", row.names=FALSE)
