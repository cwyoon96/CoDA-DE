clear;clc;close all;

addpath('./../ternary2');
addpath('./../source codes')

d = 3;

ngrid = 50;

m = simplex_grid_size(d-1, ngrid);
xgrid = simplex_grid_index_all(d-1, ngrid, m);
xgridc = xgrid'/ngrid;

true_fc = ddirichlet2(xgridc,ones(1,d));

scatter3(xgridc(:,1),xgridc(:,2),true_fc);

zlim([0, 5]);

X = randdirichlet(ones(1,d),50000);

h = 0.003;

% pull-back density without Jacobian (normalized)

[xgridc, fc] = RSF_den(X,h,50);

J = sum(xgridc.^2,2).^(-3/2);

pb_fc = fc./J;

pb_fc = pb_fc / (mean(pb_fc)/2);

scatter3(xgridc(:,1),xgridc(:,2),pb_fc);

zlim([0, 5]);

% pull-back density with Jacobian

scatter3(xgridc(:,1),xgridc(:,2),fc);

zlim([0, 5]);

% aln kernel

h = 0.001;

[xgridc, fc] = AitchisonKDE(X,h,50,2);

scatter3(xgridc(:,1),xgridc(:,2),fc);

zlim([0, 5]);


