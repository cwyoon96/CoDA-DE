function [fc,fs] = comp_exp_den(x,theta)

% density of compositional exponential family (w/o normarlizing constant)
% x: data point (compositional)
% theta: theta paramter (array)

[~,p] = size(x);

SS = sqrt(sum(x.^2, 2));

y = x./repmat(SS, 1, p);

y4 = y.^4;

y2 = y.^2;

dens = sum((theta([1,2,3]).* y4),2) + theta(4).*y2(:,1).*y2(:,2) + theta(5).*y2(:,1).*y2(:,3) + theta(6).*y2(:,2).*y2(:,3); 

fs = exp(dens);

Jacobain = ((sum(x.^2,2)).^(-p/2));

fc = fs.*Jacobain;



end