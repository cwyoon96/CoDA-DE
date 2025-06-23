function [fc] = egcomp_degree(Xs, fs, degree)

% Xs, fs: N x p, N x 1 directional on unit sphere, function value
% Xs are "spread out" compositional data
% N = n x 2^p
% Xc, fc :n x p, n x 1 compositional input and output
% pull-back procedure

[N, p] = size(Xs);

M = 0;
for k=0:degree
    M = M + factorial(p)/(factorial(k)* factorial(p-k));
end

n = N/M;


fc = sum(reshape(fs, n, M), 2);  