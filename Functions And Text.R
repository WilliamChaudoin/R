##### Functions And Text

# Change Working Directory Location And Loading Data
setwd('/')
getwd()

load(file = 'PortfolioData.RData')
ls()

# Functions
log2 = function(x) log(x, base = 2)
log2(64)
log2(seq(2, 8, 2))

manning = function(r, g, coef=.11125) (r^(2/3)*g^.5/coef)
manning(r = 1, g = 1/500)
manning(r = 1, g = 1/500, coef = c(.08, .11, .2))

TR = function(P,Q) P*Q
TR(10,10)

TC = function(C,Q) C*Q
TC(9, 10)

Profit = function(TR,TC) TR-TC
Profit(100, 90)

cummedian = function(x) {
tmp = seq_along(x)
for(i in 1:length(tmp)) tmp[i] = median(x[1:i])
print(tmp)
}
cummedian(M$Length)

# Args Command
args(log2)
args(manning)
args(cummedian)

# Saving and Loading Functions
save(manning, cummedian, TR, TC, file = 'My Functions.R')
load('My Functions.R')

# Text
msg = 'My work is far from done'
cat(msg)

cat('This is line 1\nThis is line 2\nThis is line 3')

cat('Am I done?\n', msg, '\n')

# Functions With Text
cum.fun = function(x, fun = median, ...) {
	tmp = seq_along(x)
	for(i in 1:length(tmp)) tmp[i] = fun(x[1:i], ...)
	cat('\n', deparse(substitute(fun)), 'of', deparse(substitute(x)), '\n')
	print(tmp)
}

cum.fun(M$BOD, mean)

# Messages For User Intervention
mopts = function() {
	yorn = readline(prompt = 'Do you want to carry on? Y or N : ')
	if(yorn == 'Y' || yorn == 'y') {
		cat('Thank goodness')
	}
	if(yorn == 'N' || yorn == 'n') {
		cat('Oh dear')
	}
}
mopts()