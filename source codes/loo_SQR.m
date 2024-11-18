function [loo_den] = loo_SQR(X, h)
% Leave-One-Out density estimation for cv

n = size(X,1);

loo_den = zeros(n,1);

X_zr = zero_replacement(X, 0.001); % since SQR can not give density on the boundary

for i = 1:n

    X_zr_mi = X_zr;
    X_zr_mi(i,:) = [];

    loo_den(i) = SQR_target(X_zr_mi,X_zr(i,:),h);

end

end

