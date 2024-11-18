function [Xc, fc] = egcomp(Xs, fs)

% Xs, fs: N x p, N x 1 directional on unit sphere, function value
% Xs are "spread out" compositional data
% N = n x 2^p
% Xc, fc :n x p, n x 1 compositional input and output
% pull-back procedure

[N, p] = size(Xs);

n = N/(2^p);

Xc = Xs(1:n,:);

Xc = Xc.^2;
fc = sum(reshape(fs, n, 2^p), 2);  