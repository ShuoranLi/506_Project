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

% Load Stock Price Data
mc_rep = 1000;

stockData = readtable('Group21_ProjectData.csv');

stockPrices = table2array(stockData(:, 2:end));

stockReturns = returns(stockPrices);

% Get the Variance Covariance Matrix of our Stock Returns
coVarMat = cov(stockReturns);
mu = transpose(mean(stockReturns));
mu = repmat(mu, 1, mc_rep);
Z = randn(size(stockReturns,2), mc_rep);

L = chol(coVarMat, 'lower');

simulatedReturns = mu + L * Z;

% This function returns the first differences of a t x q matrix of data
function [yDif] = returns(y)
    yDif = y(2:end, :) ./ y(1:end-1, :) - 1;
end































