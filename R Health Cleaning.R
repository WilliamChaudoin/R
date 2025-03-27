####### Cleaning Raw Data For Biomedical Data Study
## Libraries and Directory
setwd("C:/Users/willc/OneDrive/Documents/Game Plan/Portfolio/Staging")
if(!require(readxl)) { install.packages("readxl"); library(readxl) }

## Loading Collected Biomedical Data
health = read_excel('Health Data.xlsx')

## Viewing Data
for (i in 1:length(health)) {
  current = health[,i]
  print(current)
}

## Structure of Data
str(health)

## Cleaning Data
### Changing Column Names
names(health)[2] = 'Weight'
names(health)[3] = 'Waist'
names(health)[4] = 'Neck'
names(health)[25] = 'Water'
colnames(health)

### Checking For Missing Values
sum(is.na(health))
which(is.na(health))

### Checking Means
columns = data.frame(health['Calories'], health['Carbs'], health['Fat'], health['Protein'], health['Fiber'], health['Sugar'], 
	health['Servings'], health['Water'], health['Fat Calories'])

meanbefore = NULL
for(i in 1:length(columns)) {
	mean = sapply(health[17+i], mean, na.rm = TRUE)
	print(mean)
	meanbefore=rbind(meanbefore, colnames(columns[i]), mean)
}

print(meanbefore)

### Replacing Missing Values With Mean
for(i in 1:length(columns)) {
	columns[is.na(columns[,i]), i] = mean(columns[,i], na.rm = TRUE)
	print(columns[,i])
}

### Pasting Clean Columns Into Health
for(i in 1:length(columns)) {
	health[,17+i] = columns[,i]
}

### Rounding Numerical Varaibles To 2 Decimal Places
for(i in 1:length(columns)) {
	columns[,i] = round(columns[,i], 2)
}

### Setting Categorical Varaibles and Changing Formats
health$Gym = as.factor(health$Gym)
health$Cardio = as.factor(health$Cardio)
health$Date = as.Date(health$Date)

## Comparing Means
meanafter = NULL
for(i in 1:length(columns)) {
	mean = sapply(health[17+i], mean, na.rm = TRUE)
	print(mean)
	meanafter=rbind(meanbefore, colnames(columns[i]), mean)
}

print(meanbefore)
print(meanafter)

## Confirming Cleaning Worked
sum(is.na(health))

print.data.frame(health[212:218,18:26])

str(health)

## Saving Data To A File
save(list = ls(), file = 'Cleaned_Health.RData')
