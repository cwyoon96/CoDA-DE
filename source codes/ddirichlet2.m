function [d] = ddirichlet2(x, alpha)


nc = prod(gamma(alpha),2) ./ gamma(sum(alpha,2));

d = prod(x.^(alpha - 1),2) ./ nc;
