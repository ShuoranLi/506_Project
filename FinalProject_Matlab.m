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
stockPrices = readtable('Group21_ProjectData.csv');

stockPrices(1)






























