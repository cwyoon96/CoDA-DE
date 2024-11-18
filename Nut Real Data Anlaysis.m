% food Real Data Analysis

clear;clc;close all;
addpath('./ternary2');
addpath('./source codes')

beef = readmatrix('./food/beef_nut.csv'); 
fish = readmatrix('./food/fish_nut.csv'); 

beef = beef(:,2:4); 
fish = fish(:,2:4); 


% ILR transformed data -> need to obtain bandwidth parameter H

ilr_beef = ilr(zero_replacement(beef,0.001)); 
ilr_fish = ilr(zero_replacement(fish,0.001)); 

writematrix(ilr_beef, './food/H_iln/ilr_beef.csv'); 
writematrix(ilr_fish, './food/H_iln/ilr_fish.csv'); 

%% ================================ %%
% KDE for nut data

ngrid = 100;
m = simplex_grid_size(2, ngrid);
xgrid = simplex_grid_index_all(2, ngrid, m);
xgrid = xgrid'/ngrid;

% estimated density for each group with three kernel methods

[RSF_fc_beef, SQR_fc_beef , dirichlet_fc_beef, log_norm_fc_beef,h1,h2,h3,h4] = real_data_result(ngrid,beef);

[RSF_fc_fish, SQR_fc_fish, dirichlet_fc_fish, log_norm_fc_fish,h9,h10,h11,h12] = real_data_result(ngrid,fish);

% esitmated density for each group with iln kernel

best_h = readmatrix('./food/H_iln/H_beef.csv');
best_h(2,1) = best_h(1,2); % fix symmetry error
[~, iln_fc_beef] = ilrKDE(beef, best_h, ngrid); % ngrid = 100


best_h = readmatrix('./food/H_iln/H_fish.csv');
best_h(2,1) = best_h(1,2); % fix symmetry error
[~, iln_fc_fish] = ilrKDE(fish, best_h, ngrid); % ngrid = 100



% export estimated density 

writematrix(RSF_fc_beef, './food/estimated density/KDE_RSF_beef.csv');
writematrix(SQR_fc_beef, './food/estimated density/KDE_SQR_beef.csv'); 
writematrix(dirichlet_fc_beef, './food/estimated density/KDE_dir_beef.csv'); 
writematrix(log_norm_fc_beef, './food/estimated density/KDE_log_beef.csv'); 
writematrix(iln_fc_beef ,'./food/estimated density/KDE_iln_beef.csv'); 

writematrix(RSF_fc_fish, './food/estimated density/KDE_RSF_fish.csv');
writematrix(SQR_fc_fish, './food/estimated density/KDE_SQR_fish.csv'); 
writematrix(dirichlet_fc_fish, './food/estimated density/KDE_dir_fish.csv'); 
writematrix(log_norm_fc_fish, './food/estimated density/KDE_log_fish.csv'); 
writematrix(iln_fc_fish, './food/estimated density/KDE_iln_fish.csv');

%%

% food Real Data Analysis

clear;clc;close all;
addpath('./ternary2');
addpath('./ternary2_new');
addpath('./source codes')


sweet = readmatrix('./food/sweet_nut.csv');

sweet(40,:) = []; % due to zero replacement error

sweet = sweet(:,2:4);


mymap = [0 0.4470 0.7410; 255/255,69/255,0]; colormap(mymap);


% sweet

terplot3_new;
hold on
symbol = 'o';   size_ = 60;  alpha = 0.2;    color = 'blue'; % blue color
tergscatter3_new(sweet(:,1), sweet(:,2), sweet(:,3), ones(size(sweet,1),1), symbol, size_, alpha, color);
terlabel3_new('Carbohydrate',  'Protein','Fat',18);


% ILR transformed data -> need to obtain bandwidth parameter H

ilr_sweet = ilr(zero_replacement(sweet,0.001));

writematrix(ilr_sweet, './food/H_iln/ilr_sweet.csv'); 

%% ================================ %%
% KDE for nut data

ngrid = 100;
m = simplex_grid_size(2, ngrid);
xgrid = simplex_grid_index_all(2, ngrid, m);
xgrid = xgrid'/ngrid;

% estimated density for each group with three kernel methods

[RSF_fc_sweet, SQR_fc_sweet, dirichlet_fc_sweet, log_norm_fc_sweet,h13,h14,h15,h16] = real_data_result(ngrid,sweet);

% esitmated density for each group with iln kernel


best_h = readmatrix('./food/H_iln/H_sweet.csv');
best_h(2,1) = best_h(1,2); % fix symmetry error
[~, iln_fc_sweet] = ilrKDE(sweet, best_h, ngrid); % ngrid = 100


% export estimated density 

writematrix(RSF_fc_sweet, './food/estimated density/KDE_RSF_sweet.csv');
writematrix(SQR_fc_sweet, './food/estimated density/KDE_SQR_sweet.csv'); 
writematrix(dirichlet_fc_sweet, './food/estimated density/KDE_dir_sweet.csv'); 
writematrix(log_norm_fc_sweet, './food/estimated density/KDE_log_sweet.csv'); 
writematrix(iln_fc_sweet, './food/estimated density/KDE_iln_sweet.csv');