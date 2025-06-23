function [best_h] = Aitchison_cv(X, kernel)
% CV for Aitchison KDE pseudo-likelihood

k_grid = linspace(2,10,9);
h_grid = 1./(2.^k_grid);

best_h = 0;
best_value = -Inf;


for h = h_grid
        
    cv = mean(log(loo_Aitchison(X,h, kernel)));
        
    
    if cv > best_value
        
        best_value = cv;
        best_h = h;
        
    end
    
    
end

end

