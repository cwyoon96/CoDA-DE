function [fc] = Aitchison_target(X,eval,h,kernel)

n = size(eval,1);

fc = zeros(n,1);

X_zr = zero_replacement(X, 0.001);

if kernel == 1
    for i = 1:n
        if sum(eval(i,:) == 0) > 0
            
            fc(i) = 0;

        else

            fc(i) = compute_density(eval(i,:),X_zr,kernel,h,0);
        end
    end
end

if kernel == 2
    
    X_zr_alr = alr(X_zr);
    
    Sigma = cov(X_zr_alr);
    
    for i = 1:n

        if sum(eval(i,:)==0) > 0

            fc(i) = 0;
            
        else

            fc(i) = compute_density(alr(eval(i,:)), X_zr_alr, kernel, h, Sigma) / prod(eval(i,:));

        end
    end

end