##### Various Examples

# Change Working Directory Location And Loading Data
setwd('/')
getwd()

load(file = 'PortfolioData.RData')
ls()

# Example 1
BuffTail = c(10, 1, 37, 5, 12)
GardenBee = c(8, 3, 19, 6, 4)
RedTail = c(18, 9, 1, 2, 4)
HoneyBee = c(12, 13, 16, 9, 10)
CarderBee = c(8, 27, 6, 32, 23)
Bees = data.frame(BuffTail, GardenBee, RedTail, HoneyBee, CarderBee)
plantnames = c('Thistle', 'Vipers Bugloss', 'Golden Rain', 'Yellow Alfalfa', 'Blackberry')
rownames(Bees) = plantnames

## Matrix
Bees.mat = as.matrix(Bees, ncol = 5)
rownames(Bees.mat) = plantnames
Bees.mat

Bees.mat2 = cbind(BuffTail, GardenBee, RedTail, HoneyBee, CarderBee)
rownames(Bees.mat2) = plantnames
Bees.mat2

## Ordering
ii = order(Bees$BuffTail, Bees$RedTail, decreasing = TRUE)
Bees.r = Bees[ii,]
ii = order(Bees.r[1,], decreasing = TRUE)
Bees.rc = Bees.r[,ii]
Bees.rc

# Example 2
str(M)
class(M)
summary(M)
mean(M$Speed)
with(M, median(Algae))
colMeans(M)
apply(M, 2, sd)

table(LHA.Stacked)
with(LHA.Stacked, table(count, site))
ftable(LHA.Stacked)
with(LHA.Stacked, table(site, count))

Taxa = c('Aphid', 'Bug', 'Beetle', 'Spider', 'Ant', 'Aphid', 'Bug', 'Beetle', 'Spider', 'Ant', 'Aphid', 'Bug', 'Beetle', 'Spider', 'Ant')
Habitat2 = c(rep('Upper', 5), rep('Lower', 5), rep('Stem', 5))
Qty2 = c(230, 34, 72, 11, 12, 175, 31, 23, 3, 9, 321, 35, 101, 5, 15)
Invert = data.frame(Taxa, Habitat2, Qty2)
(Invert.tab = xtabs(Qty2 ~ Taxa + Habitat2, data = Invert))
class(Invert.tab)

# Example 3
t.test(orchid$open, orchid$closed)
with(orchid, t.test(open, closed, var.equal = TRUE))
t.test(orchid$open, mu = 5)

qwilcox(c(.975, .995), 8, 8)
2*(1-pwilcox(77, 10, 10))
pwilcox(77, 10, 10, lower.tail = FALSE)*2

# Example 4
S1 = c(205, 215, 202, 157, 223, 157, 305, 98, 124, 175, 205, 96, 266, 142, 157, 117)
S2 = c(331, 167, 175, 74, 265, 251, 192, 233, 309, 150, NA, NA, NA, NA, NA, NA)
S3 = c(256, 305, 147, 341, 373, 220, 178, 290, 272, 321, NA, NA, NA, NA, NA, NA)
S4 = c(204, 281, 200, 196, 238, 205, 322, 237, 264, NA, NA, NA, NA, NA, NA, NA)
chick = data.frame(S1, S2, S3, S4)
chicks = na.omit(stack(chick))
names(chicks) = c('Weight', 'Diet')
str(chicks)
summary(chicks)
boxplot(Weight ~ Diet, data = chicks)
chicks.aov = aov(Weight ~ Diet, data = chicks)
summary(chicks.aov)
TukeyHSD(chicks.aov)

# Example 5
plot(Length ~ BOD, data = M, col = 'blue', pch = 14)
abline(lm(Length ~ BOD, data = M), lty = 3, col = 'red')
plot(Length ~ Algae, data = M, col = 'blue', pch = 14, xlim = c(0, 80), ylim = c(12, 24))
abline(lm(Length ~ Algae, data = M), lty = 3, col = 'red')

# Example 6
cars = read.csv(file = 'cars.csv', header = TRUE)
str(cars)
cars.reg = lm(dist ~ speed, data = cars)
summary(cars.reg)
names(cars.reg)
coef(cars.reg)
confint(cars.reg)
fitted(cars.reg)
resid(cars.reg)
plot(dist ~ speed, data = cars)
abline(cars.reg)

# Example 7
fwisort = fwi[order(fwi$speed),]
plot(sfly ~ speed, data = fwisort, type = 'b', pch = 21, lty = 2, ylab = 'Abundance',
	xlab = 'Speed', cex = 1.5, lwd = 2)
points(mfly ~ speed, data = fwisort, type = 'b', pch = 19, lty = 3, cex = 1.5, lwd = 2)
legend(x = 'topr', legend = c('Stonefly', 'Mayfly'), pch = c(21, 19), bty = 'n', lty = c(2,3), pt.cex = 1.5, lwd = 2)

# Example 8
(dl.lm = lm(dark ~ light + I(light^2), data = dl))
plot(dark ~ light, data = dl, type = 'n')
lines(spline(dl$light, fitted(dl.lm)), type = 'b', pch = 16, lty = 3, col = 'darkorange')
title(main = 'Fitted Polynominal Regression')

pn = function(x) (2.06*x)+(-.04 * x^2)-2
curve(pn, from = 0, to = 50, lwd = 2, lty = 3, ylab = 'Function', col = 'blue')
title(main = expression(2.06*x~-.04 * x^2~-2))

# Example 9
data2.norm = rnorm(1000, mean(data2), sd(data2))
data2.norm
hist(data2.norm, freq = FALSE, border = 'gray50', col = 'darkorange', 
	main = 'Data 2 Normal Distribution', xlab = 'Data2 Classes')
lines(density(data2), lwd = 2)
