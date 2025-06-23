clear;clc;close all;

addpath('./ternary2')
addpath('./source codes')
rng(6);

x1 = rejection_sampling_piecewise(100); % 100 sampled data from comp. exp. family

y = ones(100,1); X1 = [x1,y];

figure;
mymap = [0 0.4470 0.7410; 255/255,69/255,0];
colormap(mymap);

terplot;

hold on
ternaryc(X1(:,1), X1(:,2), X1(:,3));

%%

ngrid = 100; i = 12; rng(i);

for n_samples = [500,1000,2000]

    X = rejection_sampling_piecewise(n_samples);
    
    RSF_h = RSF_cv(X);  % obtain h for fixed data X1
    
    [~, RSF_fc] = RSF_den(X, RSF_h, ngrid); % conducted for fixed data X1

    file_name = ['./discontinuous/RSF_fc_',num2str(n_samples),'.csv'];

    writematrix(RSF_fc, file_name);

end
