% Final Project STATS 506
% Monte Carlo Simulation of Portfolio Stock Returns
%
% This is a tutorial code for running a simple monte carlo simulation to
% estimate the value of our Portfolio one period ahead.
%
% Apple, Google, and Facebook adjusted close Prices from November 14th, 2017 - 
% November 14th, 2018. Data comes from Yahoo Finance.
%
% Author: Israel Diego (israeldi@umich.edu)
% Due Date: December 7, 2018

clear
clc

addpath '/Users/israeldiego/Documents/GitHub/506_Project'

% Set Seed of Random Number Generator 
rng('default');
rng(1);

mc_rep = 1000; % Number of Monte Carlo Simulations
initInvestment = 100000; % $100,000 Initial Investment Portfolio at t = 0

% Load Stock Price Data
stockData = readtable('Group21_ProjectData.csv');
stockPrices = table2array(stockData(:, 2:end));

% Calculate our Daily Returns
stockReturns = returns(stockPrices);

% Suppose we invest our money evenly among all three assets 
% We use today's Price 11/14/2018 to find the number of shares each stock
% that we buy
portfolioWeights = (1/3) * ones(1, size(stockPrices,2));

% Get the Variance Covariance Matrix of our Stock Returns
coVarMat = cov(stockReturns);

% Average returns of each asset 
mu = transpose(mean(stockReturns));
mu = repmat(mu, 1, mc_rep);

% Randomly generated numbers from N(0,1) distribution 
Z = randn(size(stockReturns,2), mc_rep);

% Lower Triangular Matrix from our Choleski Factorization
L = chol(coVarMat, 'lower');

% Calculate our portfolio returns for each monte carlo simulation
simulatedReturns = mu + L * Z;

% Portfolio Returns
portfolioReturns = initInvestment * (portfolioWeights * simulatedReturns + 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate some statistics for our simulated portfolio returns
averagePortfolioReturns = mean(portfolioWeights * simulatedReturns);
stdDevPortfolioReturns = std(portfolioWeights * simulatedReturns);

% This function returns the first differences of a t x q matrix of data
function [yDif] = returns(y)
    yDif = y(2:end, :) ./ y(1:end-1, :) - 1;
end































