function [X_alr] = alr(X)

[n,p] = size(X);

X_alr = X;

for i = 1:n
    X_alr(i,:) = X(i,:) / X(i,p);
end

X_alr = log(X_alr);
X_alr = X_alr(:,1:p-1);



