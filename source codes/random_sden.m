function [xgridc, fc, xgrids, fs] = random_sden(X, h, ngrid, seed)
% X: n x p data on the simplex
% h: bandwidth
% ngrid: uniform grid on the simplex
% f: density estimate on the simplex
% xgridc: the grid points on simplex
% xgrids: grid points on the sphere
% fs: density estimate on the sphere grids

% ngrid = 50;
% h = .005;


[n,p] = size(X);

m = simplex_grid_size(p-1, ngrid);
xgrid = simplex_grid_index_all(p-1, ngrid, m);
xgrid = xgrid'/ngrid;

xgrids = spread(xgrid);
Tgrid = size(xgrids,1);

rng(seed)

Xs = random_spread(X);
    
T = size(Xs,1);
fs = zeros(Tgrid,1);
for j = 1:Tgrid
    x = repmat(xgrids(j,:), T, 1);
    K = sum(x.*Xs, 2);
    
    fs(j) = sum(exp(-(1 - K)./h));
end


func = @(t,q,h) exp(-(1-t)/h).*((1-(t).^2).^((1/2).*(q-3))).* (2.* (pi).^((1/2).*(q-1))) ./ gamma((1/2).*(q-1));

nc = integral(@(t) func(t,p,h),-1,1);

fs = fs./(nc.*n);

[xgridc, fc] = egcomp(xgrids, fs);

Jacobian = (sum(xgridc.^2,2)).^(-p/2);

fc = fc.*Jacobian;

end
