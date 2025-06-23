function [RSF_mc, SQR_mc, dirichlet_mc, log_norm_mc, iln_mc ] = ISE1_MC(ngrid,theta, n_iter, n_samples,threshold, nc , p)

% Monte Carlo first integration for ISE  
% p =0 : non-zero grid only used, p = 1 : all grid used
% For the iln kernel, a different matrix H is needed for each theta and n_sample 
% foldername should be changed for the user (iln kernel)

m = simplex_grid_size(2, ngrid);
xgrid = simplex_grid_index_all(2, ngrid, m);
xgridc = xgrid'/ngrid;

[fc,~] = comp_exp_den(xgridc, theta); % unnormalized density

fc = fc./nc ; % true normalized density 

RSF_mc = ones(n_iter,1); SQR_mc = ones(n_iter,1); dirichlet_mc = ones(n_iter,1);
log_norm_mc = ones(n_iter,1); iln_mc = ones(n_iter,1);

non_zero_index = all(xgridc ~= 0, 2); % logical -> takes 1 if no zero values in row ; 4851

for i = 1:n_iter

    rng(i) ;
    
    if threshold == 0
        X1 = rejection_sampling(theta, n_samples); % data on the first orthant of 3-dim sphere
    else
        X1 = rejection_sampling(theta, n_samples);
        X1 = nondetect(X1, threshold);
    end

    % RSF

    best_h = RSF_cv(X1); % obtain h for fixed data X1

    [~, RSF_fc1] = RSF_den(X1, best_h, ngrid); % conducted for fixed data X1
    
    a = (fc - RSF_fc1).^2 ;
    
    % Monte Carlo integration part : the area of the 2-dim simplex is 1/2 
    
    if p == 0
        RSF_mc(i) = mean( a(non_zero_index) ) /2 ; % non-zero grid 
    else
        RSF_mc(i) = mean(a)/2; % all entry
    end

    % SQR

    best_h = SQR_cv(X1); % obtain h for fixed data X1

    [~, SQR_fc1] = SQR_den(X1, best_h, ngrid); % conducted for fixed data X1
    
    a = (fc - SQR_fc1).^2 ;
    
    % Monte Carlo integration part : the area of the 2-dim simplex is 1/2 
    
    if p == 0
        SQR_mc(i) = mean( a(non_zero_index) ) /2 ; % non-zero grid 
    else
        SQR_mc(i) = mean(a)/2; % all entry
    end
    % dirichlet
    
    best_h = Aitchison_cv(X1,1);

    [~, dirichlet_fc1] = AitchisonKDE(X1, best_h, ngrid, 1);
    
    a = (fc - dirichlet_fc1).^2 ;
    
    if p ==0 

        dirichlet_mc(i) = mean(  a(non_zero_index)  ) /2 ; % only non-zero grid used
    else
        dirichlet_mc(i) = mean(a) /2; % all grid used
    end

    % logistic-normal
    
    best_h = Aitchison_cv(X1,2);

    [~, log_norm_fc1] = AitchisonKDE(X1, best_h, ngrid, 2);
    
    a = (fc - log_norm_fc1).^2 ;
    
    if p ==0

        log_norm_mc(i) = mean(  a(non_zero_index) ) / 2;
    else
        log_norm_mc(i) = mean(a)/2;
    end

    % iln

    if threshold == 0  % if original data used(without non-detect case)
    
        h_str = ['./iln_H/theta1/without nondetect/n_' num2str(n_samples) '/H_' num2str(i) '.csv'];
    else               % if non-detect case
        h_str = ['./iln_H/theta1/nondetect/n_'  num2str(n_samples) '/H_' num2str(i) '.csv'];
    end
         
    best_h = readmatrix(h_str);
    
    best_h(2,1) = best_h(1,2); % fix symmetry error
  
    [~, iln_fc1] = ilrKDE(X1, best_h, ngrid);
    
    a = (fc - iln_fc1).^2 ;
    
    if p == 0
        iln_mc(i) = mean( a(non_zero_index) ) / 2;
    else
        iln_mc(i) = mean(a)/2;
    end

    fprintf('%d',i)
    
    fprintf('\n')
    
end
end
