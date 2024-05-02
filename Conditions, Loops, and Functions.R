#### Conditions, Loops, and Functions

# Changing Working Directory Location
setwd('/')
getwd()

# If Statements 
## Example 1
Year = 1995

if(Year < 1996){
    print('Person is a legal adult')
	
}

## Example 2
Year = 1997

if(Year < 1996){
    print('Person is a legal adult')
	} else {
	print('Person is not a legal adult')

}

## Example 3
DOB = 1995

if(DOB < 2000 & DOB > 1990 ) {
    print('Date of Birth is between 1990 and 2000') 
} else {
	print('Date of Birth is not between 1990 and 2000')
}

# Loops
download.file("https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0101EN-Coursera/v2/dataset/movies-db.csv", destfile="movies-db.csv")
films <- read.csv("movies-db.csv", header=TRUE, sep=",")
(years <- films['year'])

## Example 1
for (value in years) {
    print(value)
}

## Example 2
i = 1

while (i <= 5) {
    
    print(c("This is iteration number", as.character(i)))
    
    print(films[i,]$name)
    i = i + 1
}

# Functions
## Example 1
add <- function(x, y) {
    x + y
}
add(3, 4)

## Example 2
Hello <- function(){
  print("Hello World")
}
Hello()

## Example 3
NiceScore <- function(score){
    if(score < 20){

# If score is greater than 20, it is a nice score, otherwise it is not.
        return('NO')
    
    } else {
        return('YES')
    }
}
NiceScore(21)









