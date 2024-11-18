function [d] = ddirichlet(x, alpha)

d = gammaln(sum(alpha,2)) - sum(gammaln(alpha),2) + sum((alpha - 1).* log(x), 2);

d = exp(d);