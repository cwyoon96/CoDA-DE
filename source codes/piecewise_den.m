function [den] = piecewise_den(x)

n = size(x,1);

den = ones(n,1);

a = (x(:,1) + x(:,2) <= 0.2);
b = (x(:,1) + x(:,2) <= 0.5);

den(b,:) = den(b,:) - 1 + (0.425/0.123);
den(a,:) = den(a,:) -(0.425/0.123) + 10;

end