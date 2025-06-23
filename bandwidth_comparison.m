clear;clc;close all;

addpath('./ternary2')
addpath('./source codes')

% visualization

ngrid = 100; i = 6; rng(i); n_samples = 500 ;

%theta = [3, 0, -4, 0, -26, 12]; % parameter for comp. exp. family
theta = [-1,7,-2,-2,12,10];

X1 = rejection_sampling(theta, n_samples);

% PL_cv

h_pl = RSF_cv(X1);  % obtain h for fixed data X1

[~, RSF_fc_pl] = RSF_den(X1, h_pl, ngrid); % conducted for fixed data X1

% ISE_cv

h_ise = RSF_cv_ISE(X1,ngrid);
[~, RSF_fc_ise] = RSF_den(X1, h_ise, ngrid);

% ROT
h_rot = RSF_cv_ROT(X1);
[~, RSF_fc_rot] = RSF_den(X1, h_rot, ngrid);

% adaptive
[~,RSF_fc_adaptive] = RSF_den_Adaptive(X1,ngrid,2);

% export esitmated density

writematrix(RSF_fc_pl, './bandwidth/theta2/RSF_fc_pl.csv');
writematrix(RSF_fc_ise, './bandwidth/theta2/RSF_fc_ise.csv');
writematrix(RSF_fc_rot, './bandwidth/theta2/RSF_fc_rot.csv');
writematrix(RSF_fc_adaptive, './bandwidth/theta2/RSF_fc_adaptive.csv');

%% Variance simulation

clear;clc;close all;

addpath('./ternary2')
addpath('./ternary2_new');
addpath('./source codes')

n_sample = 50000;
d = 3;

rng(6262)

v = 0:7;
m = v./(1.5);
n = (1/2).^m;

eval = zeros(length(m),3);
eval(:,1) = (1/3)*n;
eval(:,2) = 1 - 2*(1/3)*n;
eval(:,3) = (1/3)*n;

figure;

mymap = [0 0.4470 0.7410; 255/255,69/255,0];

colormap(mymap)

terplot3_new;
symbol = 'd';


hold on
tergscatter3_new(eval(:,1), eval(:,2), eval(:,3), ones(8,1), symbol, 60, 1, 'red');

axis equal
hold off

RSF_h = 0.00001;

RSF_array = zeros(1000,8); 

for i=1:1000

    X = randdirichlet(ones(1,d),n_sample);

    fc = RSF_target(X, eval, RSF_h);

    RSF_array(i,:) = fc;

end

eval_mean = mean(RSF_array,1);
 
eval_var = var(RSF_array,[],1);


plot(v, eval_var);          % Plot the line
xlabel('m');         % Label x-axis
ylabel('Sample variance');    % Label y-axis
fontsize(16,"points")
grid on;      

