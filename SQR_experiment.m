clear;clc;close all;

addpath('./ternary2')
addpath('./source codes')
rng(6);

theta1 = [3, 0, -4, 0, -26, 12]; % parameter for comp. exp. family

ngrid = 100; i = 6; rng(i); n_samples = 500 ;

X1 = rejection_sampling(theta1, n_samples);

best_h = SQR_cv(X1);  % obtain h for fixed data X1

[~, SQR_fc1] = SQR_den(X1, best_h, ngrid); % conducted for fixed data X1

SQR_fc1(SQR_fc1 == Inf,1) = 0;




theta2 = [-1,7,-2,-2,12,10];  % parameter for comp. exp. family

grid = 100; i = 6; rng(i); n_samples = 200 ;

X2 = rejection_sampling(theta2, n_samples);

best_h = SQR_cv(X2); 

[~, SQR_fc2] = SQR_den(X2, best_h, ngrid); % conducted for fixed data X1

SQR_fc2(SQR_fc2 == Inf,1) = 0;


writematrix(SQR_fc1, './ISE1_estimated/theta1/ISE1_theta1_SQR_estimated_density.csv');
writematrix(SQR_fc2, './ISE1_estimated/theta2/ISE1_theta2_SQR_estimated_density.csv');