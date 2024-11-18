% ISE1 

% 1. 100 sampled data from compositional exponential family

clear;clc;close all;

addpath('./ternary2')
addpath('./source codes')
rng(6);

theta2 = [-1,7,-2,-2,12,10];  % parameter for comp. exp. family

theta2_nc = nc_calculator(theta2);  % normalizing constant for density 

x2 = rejection_sampling(theta2, 100); % 100 sampled data from comp. exp. family

y = ones(100,1); X2 = [x2,y];

figure;
mymap = [0 0.4470 0.7410; 255/255,69/255,0];
colormap(mymap);

terplot;

hold on
ternaryc(X2(:,1), X2(:,2), X2(:,3));

% 2. ISE1 simulation

% To get 50 H matrices of iln kernel for each n_sample

for i = 1:100 % for original data 
    for n_sample = [50,100,200,500,1000]
        rng(i);
        X = rejection_sampling(theta2, n_sample);
        X = ilr(X); % ilr transformed data

        folder_name = sprintf('./iln_H/theta2/without nondetect/n_%d', n_sample);
        if ~exist(folder_name, 'dir')
            mkdir(folder_name);
        end

        file_name = sprintf('%s/X_%d.csv', folder_name, i);
        writematrix(X, file_name);

    end
end


for i = 1:100 % for non-detect data (including zero)
    for n_sample = [50,100,200,500,1000]
        rng(i);
        X = rejection_sampling(theta2, n_sample);
        X1 = nondetect(X, 0.03); % non-detect data
        X1 = ilr(zero_replacement(X,0.001));

        folder_name = sprintf('./iln_H/theta2/nondetect/n_%d', n_sample);
        if ~exist(folder_name, 'dir')
            mkdir(folder_name);
        end

        file_name = sprintf('%s/X_%d.csv', folder_name, i);
        writematrix(X1, file_name);

    end
end

% ISE with original and non-detect data (100 iterations)

% original case / all grid used  : threshold = 0; p = 1; 

ngrid = 100 ; n_iter = 100;

data = ISE1_MC_mean(ngrid, theta2, n_iter , 0, theta2_nc, 1); % original
% average of 50 ISE with n=50,100,200,500,1000 for each kernel method

writematrix(data, './ISE_MC/theta2/original/mc_mean_ISE_new_cef2.csv');

data1 = ISE1_MC_mean(ngrid, theta2 , n_iter , 0.03, theta2_nc, 1); % non-detect

writematrix(data1, './ISE_MC/theta2/nondetect/mc_mean_ISE_new_cef2.csv');


% 3. export estimated density (import density in python for ternary plot)

ngrid = 100; i = 6; rng(i); n_samples = 500 ;

X2 = rejection_sampling(theta2, n_samples);

% RSF

best_h = RSF_cv(X2);  % obtain h for fixed data X1

[~, RSF_fc2] = RSF_den(X2, best_h, ngrid); % conducted for fixed data X1

% SQR

best_h = SQR_cv(X2);  % obtain h for fixed data X1

[~, SQR_fc2] = SQR_den(X2, best_h, ngrid); % conducted for fixed data X1

% dirichlet
    
best_h = Aitchison_cv(X2,1); % dirichlet

[~, dirichlet_fc2] = AitchisonKDE(X2, best_h, ngrid, 1);

% logistic-normal (aln kernel ; additive logistic normal)
    
best_h = Aitchison_cv(X2,2);

[~, log_norm_fc2] = AitchisonKDE(X2, best_h, ngrid, 2);


% iln kernel

h_str = ['./iln_H/theta2/without nondetect/n_' num2str(n_samples) '/H_' num2str(i) '.csv'];

best_h = readmatrix(h_str);
    
best_h(2,1) = best_h(1,2); % fix symmetry error
  
[~, iln_fc2] = ilrKDE(X2, best_h, ngrid);

% export esitmated density

writematrix(RSF_fc2, './ISE1_estimated/theta2/ISE1_theta2_RSF_estimated_density.csv');
writematrix(SQR_fc2, './ISE1_estimated/theta2/ISE1_theta2_SQR_estimated_density.csv');
writematrix(dirichlet_fc2, './ISE1_estimated/theta2/ISE1_theta2_dir_estimated_density.csv');
writematrix(log_norm_fc2, './ISE1_estimated/theta2/ISE1_theta2_log_estimated_density.csv');
writematrix(iln_fc2, './ISE1_estimated/theta2/ISE1_theta2_iln_estimated_density.csv');

