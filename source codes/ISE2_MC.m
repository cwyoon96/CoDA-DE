function [RSF_mc, SQR_mc, dirichlet_mc, log_norm_mc] = ISE2_MC(ngrid,theta, n_iter, n_samples,threshold , nc, k,p)

% Second ISE MC simulation 
% p =0 : non-zero grid only used, p = 1 : all grid used

m = simplex_grid_size(2, ngrid);
xgrid = simplex_grid_index_all(2, ngrid, m);
xgridc = xgrid'/ngrid;

[fc,~] = comp_exp_den(xgridc, theta); % unnormalized density

fc = fc./nc ; % true normalized density 

RSF_mc = ones(n_iter,1);
SQR_mc = ones(n_iter,1);
dirichlet_mc = ones(n_iter,1);
log_norm_mc = ones(n_iter,1);


non_zero_index = all(xgridc ~= 0, 2); % logical -> takes 1 if no zero values in row ; 4851

for i = 1:n_iter

    rng(i) ;
    
    if threshold == 0 % without non-detect
        X1 = rejection_sampling(theta, n_samples); % sampling from comp exp-family
    else   % non-detect
        X1 = rejection_sampling(theta, n_samples);
        X1 = nondetect(X1, threshold);
    end

    % RSF

    h = 1/2^k ; 
    
    [~, RSF_fc1] = RSF_den(X1, h, ngrid); % conducted for fixed data X1
    
    a = (fc - RSF_fc1).^2 ;
    
    if p == 0
        RSF_mc(i) = mean( a(non_zero_index) ) /2 ; % non-zero grid 
    else
        RSF_mc(i) = mean(a)/2; % all entry
    end

    % SQR

    h = 1/2^k ; 
    
    [~, SQR_fc1] = SQR_den(X1, h, ngrid); % conducted for fixed data X1
    
    a = (fc - SQR_fc1).^2 ;
    
    if p == 0
        SQR_mc(i) = mean( a(non_zero_index) ) /2 ; % non-zero grid 
    else
        SQR_mc(i) = mean(a)/2; % all entry
    end
    
    % dirichlet
    
    h = 1/2^k ;
    
    [~, dirichlet_fc1] = AitchisonKDE(X1, h, ngrid, 1);
    
    a = (fc - dirichlet_fc1).^2 ;

    if p ==0 

        dirichlet_mc(i) = mean(  a(non_zero_index)  ) /2 ; % only non-zero grid used
    else
        dirichlet_mc(i) = mean(a) /2; % all grid used
    end

    
    % logistic normal
    
    h = 1/2^k ;
    
    [~, log_norm_fc1] = AitchisonKDE(X1, h, ngrid, 2);

    a = (fc - log_norm_fc1).^2 ;
    
    if p ==0

        log_norm_mc(i) = mean(  a(non_zero_index) ) / 2;
    else
        log_norm_mc(i) = mean(a)/2;
    end

    fprintf('%d', i)                                                                                                                                         
    
    fprintf('\n')
    
end
end