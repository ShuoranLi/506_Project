# Final Project STATS 506
# Monte Carlo Simulation of Portfolio Stock Returns
#
# This is a tutorial code for running a simple monte carlo simulation to
# estimate the value of our Portfolio one period ahead.
#
# Apple, Google, and Facebook adjusted close Prices from November 14th, 2017 - 
# November 14th, 2018. Data comes from Yahoo Finance.
#
# Author: Shuoran Li (shuoranl@umich.edu)
# Due Date: December 7, 2018

# Load library
library(data.table)

# Load data 
stockData = fread('./Group21_ProjectData.csv')
stockPrice = as.matrix( stockData[ , 2:4] )

mc_rep = 1000 # Number of Monte Carlo Simulations
init_Investment = 100000 # $100,000 Initial Investment Portfolio at t = 0

# This function returns the first differences of a t x q matrix of data
returns = function(Y){
  len = nrow(Y)
  yDif = Y[2:len, ] / Y[1:len-1, ] - 1
}

# Get the Stock Returns
stockReturns = returns(stockPrice)

# Suppose we invest our money evenly among all three assets 
# We use today's Price 11/14/2018 to find the number of shares each stock 
# that we buy
portfolio_Weights = t(as.matrix(rep(1/ncol(stockReturns), ncol(stockReturns))))


# Get the Variance Covariance Matrix of Stock Returns
coVarMat = cov(stockReturns)
miu = colMeans(stockReturns)

# Extend the vector to a matrix
Miu = matrix(rep(miu, mc_rep), nrow = 3)
set.seed(200)
Z = matrix ( rnorm( dim(stockReturns)[2] * mc_rep ), ncol = mc_rep )

# Lower Triangular Matrix from our Choleski Factorization
L = t( chol(coVarMat) )

# Calculate our portfolio returns for each monte carlo simulation
simulated_Returns = Miu + L %*% Z  

# Porfolio Returns
portfolio_Returns = init_Investment * (portfolio_Weights %*% simulated_Returns + 1)

Avg_Portfolio_Returns = mean(portfolio_Weights %*% simulated_Returns)
SD_Portfolio_Returns = sd(portfolio_Weights %*% simulated_Returns)





