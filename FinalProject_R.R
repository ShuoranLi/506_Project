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

mc_rep = 1000
# This function returns the first differences of a t x q matrix of data
returns = function(Y){
  len = nrow(Y)
  yDif = Y[2:len, ] / Y[1:len-1, ] - 1
}

# Get the Stock Returns
stockReturns = returns(stockPrice)

# Get the Variance Covariance Matrix of Stock Returns
coVarMat = cov(stockReturns)
miu = colMeans(stockReturns)

# Extend the vector to a matrix
Miu = matrix(rep(miu, mc_rep), nrow = 3)
set.seed(200)
Z = matrix ( rnorm( dim(stockReturns)[2] * mc_rep ), ncol = mc_rep )

L = t( chol(coVarMat) )

simulated_Returns = Miu + L %*% Z  # 3 * 1000
