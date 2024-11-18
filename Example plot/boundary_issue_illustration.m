%% Sample compositional data

clear;clc;close all;


addpath('./../ternary2');
addpath('./../ternary2_new');
addpath('./../source codes');

alpha = [1,2.5,2.5];

rng(26)

n_sample = 500;

X = randdirichlet(alpha, n_sample);


% define sequence of evaluation points

m = 2:15;

n = 2.^m;

eval = zeros(length(m),3);
eval(:,1) = 2./n;
eval(:,2) = 1/2 - 1./n;
eval(:,3) = 1/2 - 1./n;

eval(length(m) + 1,:) = [0,1/2,1/2];

figure;

mymap = [0 0.4470 0.7410; 255/255,69/255,0];

colormap(mymap)

terplot3_new;
symbol = 'd';


hold on
tergscatter3_new(X(:,1), X(:,2), X(:,3), ones(500,1), symbol, 60, 0.3, 'blue');
tergscatter3_new(eval(:,1), eval(:,2), eval(:,3), ones(15,1), symbol, 60, 1, 'red');

axis equal
hold off

RSF_h = RSF_cv(X);
dirichlet_h = Aitchison_cv(X,1);
log_norm_h = Aitchison_cv(X,2);

true_fc = ddirichlet2(eval, alpha);
RSF_fc = RSF_target(X, eval, RSF_h);
dirichlet_fc = Aitchison_target(X,eval,dirichlet_h,1);
log_norm_fc = Aitchison_target(X,eval,log_norm_h,2);

writematrix(true_fc,'./Boundary issue/true_pdf_eval.csv') 
writematrix(RSF_fc,'./Boundary issue/RSF_KDE_eval.csv') 
writematrix(dirichlet_fc,'./Boundary issue/Dirichlet_KDE_eval.csv') 
writematrix(log_norm_fc,'./Boundary issue/log_norm_KDE_eval.csv') 