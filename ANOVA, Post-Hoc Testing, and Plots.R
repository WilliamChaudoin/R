##### ANOVA, Post-Hoc Testing, and Plots

# Change Working Directory Location And Loading Data
setwd('/')
getwd()

load(file = 'PortfolioData.RData')
ls()

# ANOVA
(LHA.aov = aov(count ~ site, data = LHA.Stacked))
summary(LHA.aov)

# Post-Hoc Testing
TukeyHSD(LHA.aov)

# Extracting Means
model.tables(LHA.aov, type = 'effects')
model.tables(LHA.aov, type = 'means')

# Two-Way ANOVA
(nature.aov1 = aov(height ~ plant + water, data = nature))
summary(nature.aov1)

## Interactions
(nature.aov2 = aov(height ~ plant * water, data = nature))
summary(nature.aov2)

(nature.aov3 = aov(height ~ plant + water + plant:water, data = nature))
summary(nature.aov3)

# Comparing Multiple ANOVA Results
anova(nature.aov1, nature.aov2, nature.aov3)

TukeyHSD(nature.aov1)
TukeyHSD(nature.aov2)
TukeyHSD(nature.aov3, which = 'plant:water', conf.level = .99)

# Graphing An ANOVA
boxplot(height ~ plant * water, data = nature, cex.axis = .9, xlab = 'Interaction', ylab = 'Height')

# Graphing Post-Hoc Testing
op = par(mar = c(5, 8, 4, 2))
plot(TukeyHSD(nature.aov2, ordered = TRUE), cex.axis = .7, las = 1)
abline(v = 0, lty = 2, col = 'darkorange')
par(op)

# Model Tables For Two-Way ANOVA
model.tables(nature.aov2, type = 'means', se = TRUE)

# Interaction Plots
interaction.plot(water, plant, height)
interaction.plot(plant, water, height)

# Replication Command
replications(nature.aov2, data = nature)
nat2 = nature[1:17,]
replications(height ~ plant * water, data = nat2)

# Alternative Sequence
gl(2, 5, labels = c('mow', 'unmow'))

# Complex Data Frames
(daisy = c(12, 15, 17, 11, 15, 9, 9, 7, 9, 12, 14, 17, 21, 17))
(cutting = c(rep('mow', 5), rep('unmow', 4), rep('sheep', 5)))
(time = rep(gl(2, 1, length = 5, labels = c('early', 'late')), 3)[-10])
(flwr = data.frame(daisy, cutting, time))

mow = c(12, 15, 17, 11, 15)
unmow = c(8, 9, 7, 9)
length(unmow) = length(mow)
grassy = data.frame(mow, unmow)
names(grassy) = c('cut', 'uncut')
grn = c('Top', 'Middle', 'Lower', 'Set Aside', 'Verge')
row.names(grassy) = grn
grassy

# Adding Rows or Columns
grazed = c(11, 14, 17, 10, 8)
grassy$grazed = grazed
grassy['New',] = c(10, NA, 10)
grassy

poa = c(8, 9, 11, 12, 10, 15, 17, 16, 16, 7, 8, 8, 5, 9)
flwr$poa = poa
flwr = flwr[c(1,4,2,3)]
row15 = data.frame(10,18,'mow','early')
flwr[15,] = row15
flwr

# Aggregate Command
aggregate(flwr$daisy, by = list(flwr$cutting), FUN = mean)
aggregate(flwr$daisy, by = list(flwr$cutting, flwr$time), FUN = mean)
aggregate(flwr[1:2], by = list(flwr$cutting, flwr$time), FUN = mean)
aggregate(poa ~ cutting + time, data = flwr, FUN = mean)
aggregate(. ~ cutting + time, data = flwr, FUN = mean)
aggregate(cbind(poa, daisy) ~ cutting + time, data = flwr, FUN = mean)
aggregate(cbind(poa, daisy) ~ ., data = flwr, FUN = mean)
aggregate(cbind(poa, daisy) ~ 1, data = flwr, FUN = mean)

