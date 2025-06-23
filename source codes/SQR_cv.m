function [best_h] = SQR_cv(X)
% CV for RSF KDE with psudeo-likelihood

k_grid = linspace(2,10,9);

h_grid = 1./(2.^k_grid);

best_h = 0;
best_value = -Inf;

for h = h_grid
        
    cv = mean(log(loo_SQR(X,h)));
        
    
    if cv > best_value
        
        best_value = cv;
        best_h = h;
        
    end
    
    
end

end
