function r = randdirichlet(a,n) 

% a=alpha , n = number of sample

p = length(a);
r = gamrnd(repmat(a,n,1),1,n,p);
r = r ./ repmat(sum(r,2),1,p);
end
