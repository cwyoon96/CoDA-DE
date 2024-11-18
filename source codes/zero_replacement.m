function [X_zr] = zero_replacement(X, delta)


p = size(X,2);  

X_zr = X;

for i = 1:size(X_zr,1)  
    
    c = sum(X_zr(i,:) == 0);  

    if c > 0 
        
        X_zr(i,X_zr(i,:) ~= 0) = X_zr(i,X_zr(i,:) ~= 0) - delta*c*(c+1)/p^2;  
      
        X_zr(i,X_zr(i,:) == 0) = delta*(c+1)*(p-c)/p^2;
        
    end
end

