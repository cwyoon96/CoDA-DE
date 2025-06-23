function [h] = RSF_cv_ROT(X)
% return rule of thumb bandwidth parameter for X when p = 3 (Garcia–Portugues 2013).

Y = random_spread(X);

[n,p] = size(Y);

% approximate kappa
R = sum(Y,1);
R = sqrt(sum(R.^2,2));
R = R/n;

k = R*(p-R^2)/(1-R^2);

% give ROT bandwdith

num = 8*(sinh(k)^2);
den = k*((1+4*k^2)*sinh(2*k)-2*k*cosh(2*k))*n;
h = (num/den)^(1/6);

h = h^2; % ROT give h not h^2.


end