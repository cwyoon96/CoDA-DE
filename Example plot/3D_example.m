clear;clc;close all;

addpath('./../ternary2');
addpath('./../source codes');

alpha = [1,2.5,2.5];

rng(26)

X = randdirichlet(alpha, 500);

% on the first orthant sphere

SS = sqrt(sum(X.^2, 2));


X_s = X./repmat(SS, 1, 3);

[x y z] = sphere(128);
h = surf(x, y, z); 
set(h, 'FaceAlpha', 0.3)
shading flat
hold on;
theta = linspace(0, 2*pi, 100);
plot3(sin(theta), cos(theta), zeros(100,1), 'b-');
plot3(zeros(100,1), sin(theta), cos(theta), 'b-');
plot3(sin(theta), zeros(100,1), cos(theta), 'b-');

plot3(X_s(:,1), X_s(:,2), X_s(:,3), 'k*');

axis equal;
view([1.5, 1, .5]);
hold off;

% After random reflection

rng(12);

Y = random_spread(X);


[x y z] = sphere(128);
h = surf(x, y, z); 
set(h, 'FaceAlpha', 0.3)
shading flat
hold on;
theta = linspace(0, 2*pi, 100);
plot3(sin(theta), cos(theta), zeros(100,1), 'b-');
plot3(zeros(100,1), sin(theta), cos(theta), 'b-');
plot3(sin(theta), zeros(100,1), cos(theta), 'b-');

plot3(Y(:,1), Y(:,2), Y(:,3), 'k*');

axis equal;
view([1.5, 1, .5]);
hold off;

% After KDE

ngrid = 100;

h = sden_cv_detour(X,1,12);

[xgridc, fc, xgrids, fs] = random_sden(X, h, ngrid, 12);

pointsize = 20;
scatter3(xgrids(:,1), xgrids(:,2), xgrids(:,3), pointsize, fs);
colormap(gca,"turbo")
hold on;
axis equal;
view([1.5, 1, .5]);
hold off;

writematrix(fc,'./Step_illustration/RSF_KDE.csv') 
