function [xgrid, fc] = RSF_den_Adaptive(X,ngrid,lambda)
% RSF density estimation with adpative bandwidth
h = RSF_cv(X);

[n,p] = size(X);

m = simplex_grid_size(p-1, ngrid);
xgrid = simplex_grid_index_all(p-1, ngrid, m);
xgrid = xgrid'/ngrid;
Tgrid = size(xgrid,1);

dist = sqrt(sum((xgrid - 1/p).^2,2)); % distance from the centroid
adaptive_h = h*(1+lambda*dist);

SS = sqrt(sum(X.^2, 2));
Xs = X./repmat(SS, 1, p);   
T = size(Xs,1);

fc = zeros(Tgrid,1);

for j = 1:Tgrid

    xgrids = spread(xgrid(j,:));

    for i = 1:2^p

        x = repmat(xgrids(i,:), T, 1);
        K = sum(x.*Xs, 2);

        fc(j) = fc(j)+sum(exp(-(1 - K)./adaptive_h(j)));
    end

end

fc = fc./(n);

Jacobian = (sum(xgrid.^2,2)).^(-p/2);

fc = fc.*Jacobian;

% normalize to integrate to 1

fc = fc./(mean(fc)/factorial(p-1));

end