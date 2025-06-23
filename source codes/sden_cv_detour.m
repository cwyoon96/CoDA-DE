function [best_h] = sden_cv_detour(X, loss, seed)
% CV for sden with ISE (1) or KLD (2)

p = linspace(2,8,7);

h_grid = 1./(2.^p);

n = size(X,1);

best_h = 0;
best_value = -Inf;

rng(seed);

X = random_spread(X);

inner_mat = X * X.';

sum_mat = repmat(X,n,1) + repelem(X,n,1);

sum_mat_norm = sqrt(sum(sum_mat.^2,2));


for h = h_grid
    
    k = 1/h;

    if loss == 1

        lhs = sum(exp(k.*inner_mat),'all') - trace(exp(k.*inner_mat));

        rhs = sum((1./sum_mat_norm) .* sinh(k .* sum_mat_norm));

        cv = (k/sinh(k)) * (2*(1/(1-(1/n))) * lhs - (1/sinh(k))*rhs);

        cv = cv / (4*pi*(n^2));
        
    end
    
    if loss == 2
        
        rhs = 0;

        for i = 1:n
            
            rhs = rhs + log(sum(exp(k.*inner_mat(i,:))) - exp(k)); 
            
        end

        cv = n*log(k*sinh(k)) + rhs;
        
    end
    
    if cv > best_value
        
        best_value = cv;
        best_h = h;
        
    end
    
    
end

end
