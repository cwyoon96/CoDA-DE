function Y = spread_degree(X,degree)

% X = rand(10,3);

[~,p] = size(X);

if degree > p
    error('degree can not be larger than p');
end

SS = sqrt(sum(X.^2, 2));


X = X./repmat(SS, 1, p);
X0 = X;

for k = 1:degree
    
    V = nchoosek(1:p, k);
    
    M = size(V,1);
    
    for j = 1:M
        Y = X0;
        Y(:,V(j,:)) = (-1)* Y(:, V(j,:));
        
        X = [X; Y];
    end
    
    
end


Y = X;








