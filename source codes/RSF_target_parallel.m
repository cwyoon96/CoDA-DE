function [fc] = RSF_target_parallel(X, eval, h)

% compute RSF KDE for evaluation points with train X

[n,p] = size(X);

SS = sqrt(sum(X.^2, 2));


Xs = X./repmat(SS, 1, p);   

evals = spread(eval);

Tgrid = size(evals,1);

T = size(Xs,1);
fs = zeros(Tgrid,1);

% with parfor
parfor j = 1:Tgrid
    x = repmat(evals(j,:), T, 1);
    K = sum(x.*Xs, 2);

    fs(j) = sum(exp(-(1 - K)./h));
end

[~, fc] = egcomp(evals, fs);

func = @(t,q,h) exp(-(1-t)/h).*((1-(t).^2).^((1/2).*(q-3))).* (2.* (pi).^((1/2).*(q-1))) ./ gamma((1/2).*(q-1));

nc = integral(@(t) func(t,p,h),-1,1);

fc = fc./(nc.*n);

Jacobian = (sum(eval.^2,2)).^(-p/2);

fc = fc.*Jacobian;


end