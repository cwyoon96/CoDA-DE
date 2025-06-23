function [xgridc, fc] = AitchisonKDE(X, h, ngrid, kernel)

% X: n x p data on the simplex
% h: bandwidth
% ngrid: uniform grid on the simplex
% kernel: dirichlet or log-normal kernel
% fc: density estimate on the simplex
% xgridc: the grid points on simplex

% ngrid = 50;
% h = .005;

p = size(X,2);

m = simplex_grid_size(p-1, ngrid);
xgridc = simplex_grid_index_all(p-1, ngrid, m);
xgridc = xgridc'/ngrid;

n = size(xgridc,1);

fc = zeros(n,1);

X_zr = zero_replacement(X, 0.001);

if kernel == 1
    for i = 1:n

        if sum(xgridc(i,:) == 0) > 0
            
            fc(i) = 0;
        else

            fc(i) = compute_density(xgridc(i,:),X_zr,kernel,h,0);
        end
    end
end

if kernel == 2
    
    X_zr_alr = alr(X_zr);  % alr transform
    
    Sigma = cov(X_zr_alr); 
    
    for i = 1:n

        if sum(xgridc(i,:)==0) > 0
            
            fc(i) = 0;
            
        else

            fc(i) = compute_density(alr(xgridc(i,:)), X_zr_alr, kernel, h, Sigma) / prod(xgridc(i,:));

        end
    end
   
end


    