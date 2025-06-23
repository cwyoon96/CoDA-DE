% ISE2 simulation for theta2

clear;clc;close all;

addpath('./source codes')

% For each k=2,3,..,10, store average of 100 ISE for each kernel

ngrid = 100; n_iter = 100; theta2 = [-1,7,-2,-2,12,10]; theta2_nc = nc_calculator(theta2);

data = ISE2_MC_mean(ngrid,theta2,n_iter,0,500,theta2_nc,1); % original case

writematrix(data, './ISE_MC_grid/theta2/original/grid_mc_mean_ISE_new_cef2.csv');

data_nondetect = ISE2_MC_mean(ngrid,theta2,n_iter,0.03,500,theta2_nc,1); % non-detect case

writematrix(data_nondetect, './ISE_MC_grid/theta2/nondetect/grid_mc_mean_ISE_new_cef2.csv');