function Y = spread(X)

% X : n x p compositional data
% Y : N x p directional data on unit sphere
% N = n x 2^p


% X = rand(10,3);

[n,p] = size(X);

% S = sum(X,2);

% X = X./repmat(S,1,p);

X = sqrt(X);

X0 = X;

for k = 1:p
    
    V = nchoosek([1:p], k);
    
    M = size(V,1);
    
    for j = 1:M
        Y = X0;
        Y(:,V(j,:)) = (-1)* Y(:, V(j,:));
        
        X = [X; Y];
    end
    
    
end


Y = X;








