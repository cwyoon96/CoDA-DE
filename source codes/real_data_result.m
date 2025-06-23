function [RSF_fc, SQR_fc, dirichlet_fc, log_norm_fc,h1,h2,h3,h4] = real_data_result(ngrid,df)

% RSF
h1 = RSF_cv(df); 
[~, RSF_fc] = RSF_den(df, h1, ngrid); % estimated density

% SQR
h2 = SQR_cv(df); 
[~, SQR_fc] = SQR_den(df, h2, ngrid); % estimated density 

% dirichlet
    
h3 = Aitchison_cv(df,1);   
[~, dirichlet_fc] = AitchisonKDE(df, h3, ngrid, 1);

% log_normal

h4 = Aitchison_cv(df,2);  
[~, log_norm_fc] = AitchisonKDE(df, h4, ngrid, 2);
