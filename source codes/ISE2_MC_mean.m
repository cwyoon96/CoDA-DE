function [mean_ISE] = ISE2_MC_mean(ngrid,theta,n_iter,threshold,n_samples,nc,p)

% Second ISE experiment
% p =0 : non-zero grid only used, p = 1 : all grid used; nc = normalizing const
% threshold = 0.03 default  for non-detect case. threshold = 0 indicates original data 


ISE_dict = dictionary; 

for k = [2,3,4,5,6,7,8,9,10,10]

    ISE_dict{string(k)} = dictionary;
    
    [RSF_mc, SQR_mc, dirichlet_mc, log_norm_mc] = ISE2_MC(ngrid,theta, n_iter, n_samples,threshold , nc, k,p);
    
    ISE_dict{string(k)}{"RSF"} = RSF_mc;
    ISE_dict{string(k)}{"SQR"} = SQR_mc;
    ISE_dict{string(k)}{"dirichlet"} = dirichlet_mc;
    ISE_dict{string(k)}{"log_norm"} = log_norm_mc;

end

mean_ISE = [mean(ISE_dict{'2'}{'RSF'}),mean(ISE_dict{'3'}{'RSF'}),mean(ISE_dict{'4'}{'RSF'}), mean(ISE_dict{'5'}{'RSF'}), mean(ISE_dict{'6'}{'RSF'}), mean(ISE_dict{'7'}{'RSF'}), mean(ISE_dict{'8'}{'RSF'}),mean(ISE_dict{'9'}{'RSF'}),mean(ISE_dict{'10'}{'RSF'});
mean(ISE_dict{'2'}{'SQR'}),mean(ISE_dict{'3'}{'SQR'}),mean(ISE_dict{'4'}{'SQR'}), mean(ISE_dict{'5'}{'SQR'}), mean(ISE_dict{'6'}{'SQR'}), mean(ISE_dict{'7'}{'SQR'}), mean(ISE_dict{'8'}{'SQR'}),mean(ISE_dict{'9'}{'SQR'}),mean(ISE_dict{'10'}{'SQR'});
mean(ISE_dict{'2'}{'dirichlet'}),mean(ISE_dict{'3'}{'dirichlet'}),mean(ISE_dict{'4'}{'dirichlet'}), mean(ISE_dict{'5'}{'dirichlet'}), mean(ISE_dict{'6'}{'dirichlet'}), mean(ISE_dict{'7'}{'dirichlet'}), mean(ISE_dict{'8'}{'dirichlet'}), mean(ISE_dict{'9'}{'dirichlet'}), mean(ISE_dict{'10'}{'dirichlet'});
mean(ISE_dict{'2'}{'log_norm'}),mean(ISE_dict{'3'}{'log_norm'}),mean(ISE_dict{'4'}{'log_norm'}), mean(ISE_dict{'5'}{'log_norm'}), mean(ISE_dict{'6'}{'log_norm'}), mean(ISE_dict{'7'}{'log_norm'}), mean(ISE_dict{'8'}{'log_norm'}), mean(ISE_dict{'9'}{'log_norm'}), mean(ISE_dict{'10'}{'log_norm'})];

