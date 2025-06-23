function [dens] = compute_density_ilr(H, y1, y2)

% H is symmetric positive matrix of order (D-1) by (D-1)
% y1 : 1 by D-1 vector ; y2 : n by D-1 matrix
% y1 - y2 : n by D-1 matrix 

D = size(y1,2) + 1 ;
mu = zeros(1,D-1);

n = size(y2,1);

dens = mvnpdf(y1-y2, mu, H);

dens = sum(dens)/n;