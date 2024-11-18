function [y] = ilr(X)

% input X is n by D compositional data
% output y is n by D-1 matrix  -> ilr transformed matrix
% Isometric log-ratio transformation (ilr) was introduced in Egozcue et al. (2003)

D = size(X,2);
n = size(X,1);
y = zeros(n,D-1);

for i = 1:D-1
    y(:,i) = (sum(log(X(:,1:i)),2) - i.*log(X(:,i+1)) ) ./ sqrt(i * (i+1));  % n by 1 vector
end

