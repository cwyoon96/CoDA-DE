function [loo_den] = loo_Aitchison(X, h, kernel)
% Leave-One-Out density estimation for cv
n = size(X,1);

loo_den = zeros(n,1);

X_zr = zero_replacement(X, 0.001);

if kernel == 1

    for i = 1:n

        X_zr_mi = X_zr;
        X_zr_mi(i,:) = [];

        loo_den(i) = compute_density(X_zr(i,:),X_zr_mi,kernel,h,0);

    end
    
end

if kernel == 2
    
    X_alr = alr(X_zr);
    
    for i = 1:n

        X_alr_mi = X_alr;
        X_alr_mi(i,:) = [];
        
        Sigma = cov(X_alr_mi);

        loo_den(i) = compute_density(X_alr(i,:),X_alr_mi,kernel,h,Sigma) / prod(X_zr(i,:));
    
    end
    
end

