#### Data Analysis With R

# Changing Directory Location And Loading Libraries
setwd('/')
getwd()
#install.packages('tidyverse')
#install.packages('lubridate')
#install.packages("corrplot")
library(corrplot)
library(tidyverse)
library(lubridate)

# Loading Data For Analysis
url = "https://dax-cdn.cdn.appdomain.cloud/dax-airline/1.0.1/lax_to_jfk.tar.gz"
download.file(url, destfile = "lax_to_jfk.tar.gz")
untar('lax_to_jfk.tar.gz', tar = 'internal')

airline = read_csv('lax_to_jfk/lax_to_jfk.csv', col_types = 
	cols('DivDistance' = col_number(), 'DivArrDelay' = col_number()))

# Summarizing Arrival Delays
airline %>% group_by(Reporting_Airline) %>% summarize(count = n(), 
            mean = mean(ArrDelayMinutes, na.rm = TRUE),
            std_dev = sd(ArrDelayMinutes, na.rm = TRUE), 
            min = min(ArrDelayMinutes, na.rm = TRUE), 
            median = median(ArrDelayMinutes, na.rm=TRUE),
            iqr = IQR(ArrDelayMinutes, na.rm = TRUE), 
            max = max(ArrDelayMinutes, na.rm = TRUE))

# Distribution Of Arrival Delays
ggplot(data = airline, mapping = aes(x = Reporting_Airline, y = ArrDelay)) +
  geom_boxplot(fill = "blue", color = "red", alpha = 0.3) +
  geom_jitter(aes(color = 'green'), alpha=0.2) +
  labs(x = "Airline") +
  ggtitle("Arrival Delays by Airline") +
  guides(color = FALSE) +
  theme_minimal() +
  coord_cartesian(ylim = quantile(airline$ArrDelay, c(0, 0.99)))

# Isolating Alaska Flights Data
alaska <- airline %>% filter(Reporting_Airline == "AS") %>%
  filter(!is.na(DepDelay) & !is.na(ArrDelay)) %>% filter(DepDelay < 40)

# Measuring Alaska Arrival And Depature Delays
ggplot(data = alaska, mapping = aes(x = DepDelay, y = ArrDelay)) +
   geom_point() +
   ggtitle("Alaska Flight Depature Delays vs Arrival Delays")

# Checking For A Linear Relationships
## DepDelayMinutes And ArrDelayMinutes
cor(airline$DepDelayMinutes, airline$ArrDelayMinutes)
ggplot(data = airline, mapping = aes(x = DepDelayMinutes, y = ArrDelayMinutes)) +
    geom_point() + geom_smooth(method = "lm", na.rm = TRUE)

cor(alaska$DepDelayMinutes, alaska$ArrDelayMinutes)
ggplot(data = alaska, mapping = aes(x = DepDelayMinutes, y = ArrDelayMinutes)) +
    geom_point() + geom_smooth(method = "lm", na.rm = TRUE)

## WeatherDelay And ArrDelayMinutes
cor(airline$WeatherDelay, airline$ArrDelayMinutes, use = "complete.obs")

ggplot(data = airline, mapping = aes(x = WeatherDelay, y = ArrDelayMinutes)) +
    geom_point() + geom_smooth(method = "lm", na.rm = TRUE)

## CarrierDelay And ArrDelayMinutes
cor(airline$CarrierDelay, airline$ArrDelayMinutes, use = "complete.obs")

ggplot(data = airline, mapping = aes(x = CarrierDelay, y = ArrDelayMinutes)) +
    geom_point() + geom_smooth(method = "lm", na.rm = TRUE)   

# Determining The Average Daily Arrival Delay For Each Airline
delays = airline %>% group_by(Reporting_Airline, DayOfWeek) %>%
  summarize(mean_delays = mean(ArrDelayMinutes), .groups = 'keep')
head(delays)

## Sort The Delays
delays %>% arrange(desc(mean_delays))

# Heatmap
avg_delays <- airline %>%
  group_by(Reporting_Airline, DayOfWeek) %>%
  summarize(mean_delays = mean(ArrDelayMinutes), .groups = 'keep') %>%
  mutate(bins = cut(mean_delays,breaks = c(-0.1,0.1,10,20,30,50, max(mean_delays)),
                         labels = c("0","0-10","10-20","20-30","30-50",">50"))) %>%
  mutate(bins = factor(as.character(bins),levels = rev(levels(bins))))


ggplot(avg_delays, aes(x = Reporting_Airline, 
                      y = lubridate::wday(DayOfWeek, label = TRUE), 
                      fill = bins)) +
    geom_tile(colour = "white", size = 0.2) +
    geom_text(aes(label = round(mean_delays, 3))) +
    guides(fill = guide_legend(title = "Delays Time Scale"))+
    labs(x = "Reporting Airline",y = "Day of Week",title = "Average Arrival Delays")+
    scale_fill_manual(values = c("#d53e4f", "#f46d43", "#fdae61", "#fee08b", "#e6f598", "#abdda4"))

# Average Arrival Delay By Airline
airline %>% group_by(Reporting_Airline) %>%
  summarize(mean_delays = mean(ArrDelayMinutes))

# Pearson Correlation Matrix
airline %>% select(DepDelayMinutes, ArrDelayMinutes) %>% 
  cor(method = "pearson")

# Correlation Test
airline %>% cor.test(~DepDelayMinutes + ArrDelayMinutes, data = .) 

# Larger Correlation Matrix
airline %>% select(ArrDelayMinutes, DepDelayMinutes, 
         CarrierDelay, WeatherDelay, NASDelay, SecurityDelay, LateAircraftDelay) %>% 
  cor(use = "pairwise.complete.obs", method = "pearson")

# Correlation Plot
variables = airline %>% select(ArrDelayMinutes, DepDelayMinutes, CarrierDelay,
         WeatherDelay, NASDelay, SecurityDelay, LateAircraftDelay)

airlinescor = cor(variables, method = "pearson", use='pairwise.complete.obs')

col = colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))

corrplot(airlinescor, method = "color", col = col(200),  
         type = "upper", order = "hclust", 
         addCoef.col = "black", 
         tl.col = "black", tl.srt = 45,
         )

# Analysis Of Variance
## Pulling Subsets
subset1 = airline %>% select(ArrDelay, Reporting_Airline) %>%
  filter(Reporting_Airline == 'AA' | Reporting_Airline == 'AS')

subset2 = airline %>% select(ArrDelay, Reporting_Airline) %>%
  filter(Reporting_Airline == 'AA' | Reporting_Airline == 'PA (1)')

## Results
aov1 = aov(ArrDelay ~ Reporting_Airline, data = subset1)
summary(aov1)

aov2 <- aov(ArrDelay ~ Reporting_Airline, data = subset2)
summary(aov2)
