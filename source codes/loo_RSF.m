function [loo_den] = loo_RSF(X, h)
% Leave-One-Out density estimation for cv

n = size(X,1);

loo_den = zeros(n,1);

for i = 1:n

    X_mi = X;
    X_mi(i,:) = [];

    loo_den(i) = RSF_target(X_mi,X(i,:),h);

end

end

