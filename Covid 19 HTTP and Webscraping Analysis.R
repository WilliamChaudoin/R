##### Covid 19 HTTP and Webscraping Analysis

# Change Working Directory Location
setwd('/')
getwd()

# Install Or Load Required Packages
#install.packages('httr') #Remove Comment If Not Installed
#install.packages('rvest') #Remove Comment If Not Installed
#install.packages('xml2') #Remove Comment If Not Installed
library(httr)
library(rvest)
library(xml2)

# Function To Establish Connection
get_wiki_covid19_page = function() {
    
base_url = "https://en.wikipedia.org/w/index.php"
url_parameter = "title=Template:COVID-19_testing_by_country"
full_url = paste(base_url, "?", url_parameter, sep = "")
response = GET(url = full_url)
return(response)
}

# Calling Established Function
get_wiki_covid19_page()

# Extracting The Root HTML Response
root_html = read_html(get_wiki_covid19_page())

# Extracting The Root Node
root_node = xml_root(root_html)
root_node

# Extracting The Table Node
table_node = html_nodes(root_node, 'table')
table_node

# Converting The Table Node Into A Data Frame
CovidDF = as.data.frame(html_table(table_node[2]))
head(CovidDF)

# Summarizing The Data
summary(CovidDF)

# Data Cleaning And Alteration
preprocessing <- function(data_frame) {
    
    shape <- dim(data_frame)

    # Remove the World row
    data_frame<-data_frame[!(data_frame$`Country.or.region`=="World"),]
    # Remove the last row
    data_frame <- data_frame[1:172, ]
    
    # We dont need the Units and Ref columns, so can be removed
    data_frame["Ref."] <- NULL
    data_frame["Units.b."] <- NULL
    
    # Renaming the columns
    names(data_frame) <- c("Country", "Date", "Tested", "Confirmed", "Confirmed.Tested.Ratio", "Tested.Population.Ratio", "Confirmed.Population.Ratio")
    
    # Convert column data types
    data_frame$Country <- as.factor(data_frame$Country)
    data_frame$Date <- as.factor(data_frame$Date)
    data_frame$Tested <- as.numeric(gsub(",","",data_frame$Tested))
    data_frame$Confirmed <- as.numeric(gsub(",","",data_frame$Confirmed))
    data_frame$'Confirmed.Tested.Ratio' <- as.numeric(gsub(",","",data_frame$`Confirmed.Tested.Ratio`))
    data_frame$'Tested.Population.Ratio' <- as.numeric(gsub(",","",data_frame$`Tested.Population.Ratio`))
    data_frame$'Confirmed.Population.Ratio' <- as.numeric(gsub(",","",data_frame$`Confirmed.Population.Ratio`))
    
    return(data_frame)
}

# Calling Preprocessing Function And Forming A New Data Frame
CovidDF.New = preprocessing(CovidDF)
head(CovidDF.New)

# Summarizing New Data Frame
summary(CovidDF.New)

# Displaying Specific Columns and Rows From Data Frame
CovidDF.New[5:10,c('Country', 'Confirmed')]

# Total Confirmed Covid19 Cases Worldwide
sum(CovidDF.New$Confirmed)

# Total Tested Cases Worldwide
sum(CovidDF.New$Tested)

# Positive Cases Ratio To Tested
sum(CovidDF.New$Confirmed)/sum(CovidDF.New$Tested)

# Altering Column Data Format
## Displaying Column
CovidDF.New$Country
## Checking Column Class
class(CovidDF.New$Country)
## Converting From Factor To Character
CovidDF.New$Country = as.character(CovidDF.New$Country)
class(CovidDF.New$Country)

# Sorting Country Column
sort(CovidDF.New$Country)
sort(CovidDF.New$Country, decreasing = TRUE)
print(sort(CovidDF.New$Country, decreasing = TRUE))

# Finding Matches In Country Column
Index = grep('United.+', CovidDF.New$Country)
for (i in Index) {print(CovidDF.New$Country[i])}

# Comparing Random Country Rates
CovidDF.New[35,c(1, 4, 7)]
CovidDF.New[88,c(1, 4, 7)]

# Which Rate Is Higher
if (CovidDF.New[35,7] > CovidDF.New[88,7]) {
    print('Columbia Has The Higher Ratio Of Confirmed Cases To Population')
 } else {
    print('Kyrgzstan Has The Higher Ratio Of Confirmed Cases To Population')
 }

# Which Countries Have Confirmed Population Ratios Below 1%
CovidSubset = subset(CovidDF.New, subset = Confirmed.Population.Ratio < 1)
print(CovidSubset[,c(1,7)])

# Export The Data As A CSV File
write.csv(CovidDF.New, file = 'Covid.csv')

# Confirming Download
file_path = paste(getwd(), sep="", "/covid.csv")
print(file_path)
file.exists(file_path)

# Loading Saved File As A New Data Frame
Covid19 = read.csv('Covid.csv')
head(Covid19)
