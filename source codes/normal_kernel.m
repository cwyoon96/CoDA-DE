function [d] = normal_kernel(x, X, h, Sigma)

d = mvnpdf(x,X,h.*Sigma);


