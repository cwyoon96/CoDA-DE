function [fc] = SQR_target(X, eval, h)

% X: n x p data on the simplex
% h: bandwidth
% ngrid: uniform grid on the simplex
% f: density estimate on the simplex
% xgridc: the grid points on simplex
% xgrids: grid points on the sphere
% fs: density estimate on the sphere grids

% ngrid = 50;
% h = .005;


[n,p] = size(X);

evals = SQR_spread(eval);
Tgrid = size(evals,1);

Xs = sqrt(X);

T = size(Xs,1);
fs = zeros(Tgrid,1);
for j = 1:Tgrid
    x = repmat(evals(j,:), T, 1);
    K = sum(x.*Xs, 2);
    
    fs(j) = sum(exp(-(1 - K)./h));
end


func = @(t,q,h) exp(-(1-t)/h).*((1-(t).^2).^((1/2).*(q-3))).* (2.* (pi).^((1/2).*(q-1))) ./ gamma((1/2).*(q-1));

nc = integral(@(t) func(t,p,h),-1,1);

fs = fs./(nc.*n);

[~, fc] = SQR_egcomp(evals, fs);

Jacobian = ((1/2)^(p-1)) .* (prod(eval,2).^(-1/2));

fc = fc.*Jacobian;

fc(fc== Inf ,1) = 0;

end