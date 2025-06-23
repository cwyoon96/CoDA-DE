function [best_h] = RSF_cv_ISE(X,ngrid)
% CV for RSF KDE with ISE when

[n,p] = size(X);

k_grid = linspace(2,10,9);

h_grid = 1./(2.^k_grid);

best_h = 0;
best_value = -Inf;

for h = h_grid
    den = RSF_den(X,h,ngrid);
    loo = loo_RSF(X,h);
    cv = -mean(den.^2)/factorial(p-1) + 2*mean(loo);
    
    if cv > best_value
        
        best_value = cv;
        best_h = h;
        
    end
    
    
end