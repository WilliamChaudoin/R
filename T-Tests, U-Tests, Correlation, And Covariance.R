##### T-Tests, U-Tests, Correlation, And Covariance

# Change Working Directory Location And Loading Data
setwd('/')
getwd()

load(file = 'PortfolioData.RData')
ls()

# T-Test
## Unequal Variance
t.test(data1, data2)
## Equal Variance
t.test(data1, data2, var.equal = TRUE)

# One Sample T Test
## Two-Sided
t.test(data1, mu = 5, alternative = 'two.sided')
## Greater
t.test(data1, mu = 5, alternative = 'greater')
## Less
t.test(data1, mu = 5, alternative = 'less')

# Two Sample T Test
t.test(species ~ cut, data = grass)
## Subsetting A Column
t.test(species ~ cut, data = grass, subset = cut %in% c('mow', 'unmow'))

# Mann-Whitney/Wilcoxon U-Test
wilcox.test(data1, data2)
## Determining The p-value
wilcox.test(data1, data2, exact = FALSE)

# One Sample U Test
wilcox.test(data1, exact = FALSE)
## Providing A Mean
wilcox.test(data1, mu = 5, exact = FALSE)

# One Sample Two Sided U Test
wilcox.test(data1, exact = FALSE, alternative = 'two.sided', mu = 5)

# Two Sample U Test With Confidence Interval
wilcox.test(df$sample1, df$sample2, exact = FALSE, alternative = 'two.sided', conf.int = TRUE, conf.level = .975)

# Deeper Look Into The Tests
data1.tt = t.test(data1, mu = 5)
data1.wt = wilcox.test(data1, mu = 5, exact = FALSE)
names(data1.tt)
names(data1.wt)
data1.tt$statistic
data1.wt$statistic

# Paired U Test
summary(df)
wilcox.test(df$sample1, df$sample2, exact = FALSE, paired = TRUE)

# Paired T Test
with(df, t.test(sample1, sample2, mu = 1, paired = TRUE, alt = 'less'))

# Correlation
cor(sample1, sample2)
## Alternative Methods
cor(sample1, sample2, method = 'spearman')
cor(sample1, sample2, method = 'kendall')

# Covariance
cov(sample1, sample2)

# Covariance Matrix
cov2cor(cov(df))

# Correlation Tests
cor.test(sample1, sample2)
cor.test(~ sample1 + sample2, data = df, method = 'spearman', exact = FALSE)

# Chi-Squared Test
df.chi = chisq.test(df)
summary(df.chi)
df.chi$statistic
df.chi$p.value
df.chi$expected
df.chi$residuals

# Monte Carlo Simulation
chisq.test(df, simulate.p.value = TRUE, B = 2500)

# Goodness Of Fit Test
chisq.test(df$sample1, p = df$sample2, rescale.p = TRUE)
