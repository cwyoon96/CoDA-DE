function [xgridc, fc] = ilrKDE(X, H, ngrid)
% KDE using iln kernel
% X : compositional data

p = size(X,2);

m = simplex_grid_size(p-1, ngrid);
xgridc = simplex_grid_index_all(p-1, ngrid, m);
xgridc = xgridc'/ngrid;

n = size(xgridc,1);

fc = zeros(n,1);

X_zr = zero_replacement(X, 0.001);

X_zr_ilr = ilr(X_zr);
    
    
for i = 1:n

    if sum(xgridc(i,:)==0) > 0
        
        fc(i) = 0;
        
    else

        J = 1/(sqrt(p) * prod(xgridc(i,:)));

        fc(i) = compute_density_ilr(H, ilr(xgridc(i,:)), X_zr_ilr)*J;

    end
end

end