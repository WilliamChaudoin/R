##### Box, Pie, Bar, Line, and Other Plots

# Change Working Directory Location And Loading Data
setwd('/')
getwd()

load(file = 'PortfolioData.RData')
ls()

# Basic Boxplots
boxplot(af)
boxplot(af$flow)
boxplot(af$abund)

# Stylized Boxplots
## Separate Commands
boxplot(df$sample1, df$sample2, names = c('sample1', 'sample2'))
title(xlab = 'Variables', ylab = 'Values')

## Single Command
boxplot(df$sample1, df$sample2, names = c('sample1', 'sample2'), xlab = 'Variables', ylab = 'Values')

## Adding Colors
boxplot(species ~ cut, data = grass, range = 0, col = 'darkorange',
	xlab = 'Predictor', ylab = 'Response')

## Changing Direction
boxplot(species ~ cut, data = grass, range = 0, col = 'darkorange', horizontal = TRUE,
	xlab = 'Predictor', ylab = 'Response')

# Basic Scatterplots
plot(af$abund, af$flow)
with(orchid, plot(closed, open))

## Alternative Method
plot(flow ~ abund, data = af)

# Stylized Scatterplots
## Titles
plot(af$flow ~ af$abund, xlab = 'Flow', ylab = 'Abund')

## Axis Limits
plot(af$flow ~ af$abund, xlab = 'Flow', ylab = 'Abund', xlim = c(0, 50), ylim = c(0,50))

## Special Characters And Color
plot(af$flow ~ af$abund, xlab = 'Flow', ylab = 'Abund', xlim = c(0, 50), ylim = c(0,50), 
	pch = 17, col = 'darkorange')

## Adding Best Fit Lines
plot(af$flow ~ af$abund, xlab = 'Flow', ylab = 'Abund', xlim = c(0, 50), ylim = c(0,50), 
	pch = 17, col = 'darkorange')
abline(lm(flow ~ abund, data = af), lty = 1, lwd = 2, col = 'turquoise1')

# Plotting Larger Data Objects
plot(M)
plot(birds)

# Multiple Correlation Plots
pairs(~ Length + Speed + NO3, data = M)

## Stylized 
pairs(~ Length + Speed + NO3, data = M, col = 'blue', pch = 3)

# Line Charts
## Numerical
plot(data1, type = 'l')

## Categorical
plot(rain, type = 'l', axes = FALSE, xlab = 'Month', ylab = 'Rainfall in CM')
axis(side = 1, at = 1: length(rain), labels = months)
axis(side = 2)
box()

# Pie Chart
pie(rain, labels = months)

## Stylized
pcol = c('pink3', 'orchid4', 'seagreen3', 'paleturquoise1', 'magenta3', 'gray90')
pie(rain, labels = months, col = pcol, clockwise = TRUE, init.angle = 180)

# Dot Charts
dotchart(rain, labels = months)
dotchart(bird)

## Stylized
dotchart(rain, labels = months, color = pcol, ylab = 'Month', xlab = 'Rainfall in CM')
title(main = 'Yearly Rainfall By Month')

dotchart(bird, color = 'blue', gcolor = 'black', lcolor = 'green', cex = .7,
	xlab = 'Bird Counts', bg = 'gray90', pch = 21)
title(main = 'Bird Counts By Location')

# Bar Charts
barplot(rain)
barplot(grass$species)

## Stylized
barplot(rain, names = months, col = 'darkorange')
title(main = 'Yearly Rainfall By Month', xlab = 'Month', ylab = 'RainFall In CM')
abline(h = seq(1,9,2), lty = 2, lwd = .5, col = 'blue')
box()

barplot(table(rain), ylab = 'Frequency', xlab = 'Numeric Category', col = 'blue')
abline(h = 0)
box()

# Stacked Bar Charts
barplot(bird)

## Stylized
barplot(bird, col = pcol, beside = TRUE, legend = TRUE, 
	ylab = 'Total Birds Counted', xlab = 'Habitat')
title(main = 'Bird Counts By Habitat')

# Horizontal Bar Charts
barplot(bird, horiz = TRUE, col = pcol, beside = TRUE, legend = TRUE, 
	xlim = c(0, 60))
title(main = 'Bird Counts By Habitat', xlab = 'Total Birds Counted', ylab = 'Habitat')

# Saving Graphics
barplot(bird, col = pcol, beside = TRUE, legend = TRUE, 
	ylab = 'Total Birds Counted', xlab = 'Habitat')
title(main = 'Bird Counts By Habitat')
dev.copy(pdf, file = 'Bird Bar Chart.pdf')
dev.off()
