% ISE1 

% 1. 100 sampled data from compositional exponential family

clear;clc;close all;

addpath('./ternary2')
addpath('./source codes')
rng(6);

theta1 = [3, 0, -4, 0, -26, 12]; % parameter for comp. exp. family

theta1_nc = nc_calculator(theta1);  % normalizing constant for density

x1 = rejection_sampling(theta1, 100); % 100 sampled data from comp. exp. family

y = ones(100,1); X1 = [x1,y];

figure;
mymap = [0 0.4470 0.7410; 255/255,69/255,0];
colormap(mymap);

terplot;

hold on
ternaryc(X1(:,1), X1(:,2), X1(:,3));

% 2. ISE1 simulation

% To get 100 H matrices of iln kernel for each n_sample

for i = 1:100 % for original data 
    for n_sample = [50,100,200,500,1000]
        rng(i);
        X = rejection_sampling(theta1, n_sample);
        X = ilr(X); % ilr transformed data

        folder_name = sprintf('./iln_H/theta1/without nondetect/n_%d', n_sample);
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
        X = rejection_sampling(theta1, n_sample);
        X1 = nondetect(X, 0.03); % non-detect data
        X1 = ilr(zero_replacement(X,0.001));

        folder_name = sprintf('./iln_H/theta1/nondetect/n_%d', n_sample);
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

data = ISE1_MC_mean(ngrid, theta1 , n_iter , 0, theta1_nc, 1); % original
% average of 50 ISE with n=50,100,200,500,1000 for each kernel method
% different file path name used in ISE1_MC for different theta

writematrix(data, './ISE_MC/theta1/original/mc_mean_ISE_new_cef1.csv');

data1 = ISE1_MC_mean(ngrid, theta1 , n_iter , 0.03, theta1_nc, 1); % non-detect

writematrix(data1, './ISE_MC/theta1/nondetect/mc_mean_ISE_new_cef1.csv');


% 3. export estimated density (import density in python for ternary plot)

ngrid = 100; i = 6; rng(i); n_samples = 500 ;

X1 = rejection_sampling(theta1, n_samples);

% RSF

best_h = RSF_cv(X1);  % obtain h for fixed data X1

[~, RSF_fc1] = RSF_den(X1, best_h, ngrid); % conducted for fixed data X1

% SQR

best_h = SQR_cv(X1);  % obtain h for fixed data X1

[~, SQR_fc1] = SQR_den(X1, best_h, ngrid); % conducted for fixed data X1

% dirichlet
    
best_h = Aitchison_cv(X1,1); % dirichlet

[~, dirichlet_fc1] = AitchisonKDE(X1, best_h, ngrid, 1);

% logistic-normal (aln kernel ; additive logistic normal)
    
best_h = Aitchison_cv(X1,2);

[~, log_norm_fc1] = AitchisonKDE(X1, best_h, ngrid, 2);


% iln kernel

h_str = ['./iln_H/theta1/without nondetect/n_' num2str(n_samples) '/H_' num2str(i) '.csv'];

best_h = readmatrix(h_str);
    
best_h(2,1) = best_h(1,2); % fix symmetry error
  
[~, iln_fc1] = ilrKDE(X1, best_h, ngrid);

% export esitmated density

writematrix(RSF_fc1, './ISE1_estimated/theta1/ISE1_theta1_RSF_estimated_density.csv');
writematrix(SQR_fc1, './ISE1_estimated/theta1/ISE1_theta1_SQR_estimated_density.csv');
writematrix(dirichlet_fc1, './ISE1_estimated/theta1/ISE1_theta1_dir_estimated_density.csv');
writematrix(log_norm_fc1, './ISE1_estimated/theta1/ISE1_theta1_log_estimated_density.csv');
writematrix(iln_fc1, './ISE1_estimated/theta1/ISE1_theta1_iln_estimated_density.csv');