% ISE2 simulation for theta1

clear;clc;close all;

addpath('./source codes')

% For each k=2,3,..,10, store average of 100 ISE for each kernel

ngrid = 100; n_iter = 100; theta1 = [3,0,-4,0,-26,12]; theta1_nc = nc_calculator(theta1);

data = ISE2_MC_mean(ngrid,theta1,n_iter,0,500,theta1_nc,1); % original case

writematrix(data, './ISE_MC_grid/theta1/original/grid_mc_mean_ISE_new_cef1.csv');

data_nondetect = ISE2_MC_mean(ngrid,theta1,n_iter,0.03,500,theta1_nc,1); % non-detect case

writematrix(data_nondetect, './ISE_MC_grid/theta1/nondetect/grid_mc_mean_ISE_new_cef1.csv');