function [fc] = ilr_target(X, H, eval)

% input X is entire sample(train) data -> m by D
% H is symmetric positive matrix of order (D-1) by (D-1)
% target = evaluation points -> n by D
% fc is n by 1 vector where each row represents the estimated density at each grid point   

X_zr = zero_replacement(X, 0.001);

n = size(eval, 1);     

D = size(X,2);

fc = zeros(n,1);

for i=1:n

    if sum(eval(i,:)==0) > 0

        fc(i) = 0;
            
    else
        
        J = 1/(sqrt(D) * prod(eval(i,:)));

        fc(i) = compute_density_ilr(H, ilr(eval(i,:)), ilr(X_zr))*J;

    end


end

