function [Y] = random_spread(X)

% X : n x p compositional data
% Y : n x p directional data on unit sphere

[n,p] = size(X);

SS = sqrt(sum(X.^2, 2));


X = X./repmat(SS, 1, p);

prob=0.5;
A=(rand(n,p)<prob);
sp = A*2 - 1;

Y = X.*sp;

end

