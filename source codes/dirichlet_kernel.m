function [d] = dirichlet_kernel(x, X, h)

alpha = ones((size(x))) + (X ./ h);

d = ddirichlet(x, alpha);