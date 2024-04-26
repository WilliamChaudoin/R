##### Graphing

# Change Working Directory Location And Loading Data
setwd('/')
getwd()

load(file = 'PortfolioData.RData')
ls()

# Segments Command
LHA.m = apply(LHA, 2, mean, na.rm = TRUE)
LHA.sd = apply(LHA, 2, sd, na.rm = TRUE)
LHA.s = apply(LHA, 2, sum, na.rm = TRUE)
LHA.l = LHA.s / LHA.m
LHA.se = LHA.sd / sqrt(LHA.l)
LHA.max = round(max(LHA.m + LHA.se) + .5, 0)
bp = barplot(LHA.m, ylim = c(0, LHA.max)) 
segments(bp, LHA.m + LHA.se, bp, LHA.m - LHA.se)
segments(bp - .1, LHA.m + LHA.se, bp + .1, LHA.m + LHA.se)
segments(bp - .1, LHA.m - LHA.se, bp + .1, LHA.m - LHA.se)
box()
title(xlab = 'Site - Habitat', ylab = 'Butterfly Abundance')
abline(h = seq(2, 10, 2), lty = 2, col = 'darkorange')

# Legends
barplot(bird, beside = TRUE, legend = TRUE, args.legend = list(x = 'right', bty = 'n'))

# Palette
palette(gray(seq(.5, 1, len = 6)))
palette()

palette(c('blue', 'green', 'yellow', 'pink', 'black', 'white'))
barplot(bird, beside = TRUE, col = palette(), legend = TRUE, args.legend = list(bty = 'n'))

# Graph Text
plot(abund ~ flow, data = af, xlab = "", ylab = "")
title(xlab = expression(italic('Speed ms'^-1)))
title(ylab = expression(italic('Count '['per net'])))
title(main = 'Superscript\nand\nSubscript')

# Adding Text To Plot Area
plot(1:10, 1:10, pch = 3, cex = 1.5)
text(4, 4, 'Centered On Point')
text(3, 3, 'Under Point (pos = 1)', pos = 1)
text(5, 5, 'Left Of Point (pos = 2)', pos = 2)
text(6, 6, 'Above Point (pos = 3)', pos = 3)
text(7, 7, 'Right Of Point (pos = 4)', pos = 4)

# Adding Text To Plot Margin
plot(1:10, 1:10)
mtext('mtext(side = 1, line = -1)', side = 1, line = -1)

# Mathematical Expressions
plot(1:8, 1:8, type = 'n')
opt = par(cex = 1.5)
text(1, 1, expression(hat(x)))
text(2, 2, expression(alpha==x))
text(3, 3, expression(beta==y))
text(4, 4, expression(frac(x,y)))
text(5, 5, expression(sum(x)))
text(6, 6, expression(sqrt(x)))
text(7, 7, expression(sqrt(x,3)))
par(opt)

# Adding Points To An Existing Graph
plot(sfly ~ speed, data = fwi, pch = 21, ylab = 'Abundance', xlab = 'Speed')

points(mfly ~ speed, data = fwi, pch = 19)
legend(x = 'topright', legend = c('Stonefly', 'Mayfly'), pch = c(21, 19), bty = 'n')

# Adding Lines To Graphs
plot(sfly ~ speed, data = fwi, ylim = c(0, 30), xlim = c(0,10))
abline(lm(sfly ~ speed, data = fwi))
abline(h = seq(5, 30, 5), lty = 2, col = 'darkorange')
abline(v = 1:9, lty = 2, col = 'darkorange')
abline(a = 0, b = 1, lty = 3, lwd = 1.8)

# Adding Curved Lines To Graphs
(dl.lm = lm(dark ~ light + I(light^2), data = dl))
plot(dark ~ light, data = dl, type = 'n')
lines(spline(dl$light, fitted(dl.lm)), type = 'b', pch = 16, lty = 3, col = 'darkorange')
title(main = 'Fitted Polynominal Regression')

# Plotting Mathematical Expressions
curve(sin, -pi*2, pi*2, lty = 2, lwd = 1.5, ylab = 'Function', ylim = c(-1, 1.5))
curve(cos, -pi*2, pi*2, lty = 3, lwd = 1, add = TRUE)
legend(x = 'topright', legend = c('Sine', 'Cosine'), lty = c(2,3), lwd = c(1.5, 1), bty = 'n')
title(main = 'Sine and Cosine functions')

# Adding Arrows To A Plot
plot(abund ~ flow, data = af, pch = '.')
s = seq(length(af$flow)-1)
arrows(af$flow[s], af$abund[s], af$flow[s+1], af$abund[s+1], length = .15, 
	angle = 20, lwd = 2, col = 'purple')

# Multiple Plots
## All
opt = par(mfrow = c(2,2))
plot(Length ~ BOD, data = M, main = 'plot 1')
plot(Length ~ Algae, data = M, main = 'plot 2')
plot(Length ~ Speed, data = M, main = 'plot 3')
plot(Length ~ NO3, data = M, main = 'plot 4')
par(opt)

## Split Screen
split.screen(figs = c(2, 1))
screen(2)
plot(Length ~ Algae, data = M, main = 'plot 2')
screen(1)
plot(Length ~ NO3, data = M, main = 'plot 4')
close.screen(all.screens = TRUE)

# Saving A Graph To Disc
plot(sfly ~ speed, data = fwi, main = 'Scatter Plot', pch = 16, cex = 2, las = 1)
abline(h = mean(fwi$sfly), lty = 3, lwd = 2)
abline(v = mean(fwi$speed), lty = 3, lwd = 2)
abline(lm(sfly ~ speed, data = fwi), lty = 2, col = 'purple')
text(max(fwi$speed), mean(fwi$sfly)+ .5, 'Mean sfly', pos = 2, font = 3)
text(mean(fwi$speed), max(fwi$sfly), pos = 4, srt = 270, 'Mean speed', font = 3)
windows(width = 7, height = 7)
png(file = 'fwi', height = 2100, width = 2100, res = 300, bg = 'white')
dev.off()
