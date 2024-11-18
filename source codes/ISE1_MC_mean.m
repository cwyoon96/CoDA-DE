function [mean_ISE] = ISE1_MC_mean(ngrid,theta,n_iter,threshold,nc,p)

% Monte Carlo first integration for ISE  
% p =0 : non-zero grid only used, p = 1 : all grid used
% For the iln kernel, a different matrix H is needed for each theta and n_sample 
% foldername should be changed for the user

ISE_dict= dictionary;

for n_samples = [50,100,200,500,1000]

    ISE_dict{string(n_samples)} = dictionary;
    
    [RSF_mc, SQR_mc, dirichlet_mc, log_norm_mc,iln_mc] = ISE1_MC(ngrid,theta, n_iter, n_samples,threshold, nc , p);
    
    ISE_dict{string(n_samples)}{"RSF"} = RSF_mc;
    ISE_dict{string(n_samples)}{"SQR"} = SQR_mc;
    ISE_dict{string(n_samples)}{"dirichlet"} = dirichlet_mc;
    ISE_dict{string(n_samples)}{"log_norm"} = log_norm_mc;
    ISE_dict{string(n_samples)}{"iln"} = iln_mc;
end

mean_ISE = [mean(ISE_dict{'50'}{'RSF'}), mean(ISE_dict{'100'}{'RSF'}), mean(ISE_dict{'200'}{'RSF'}), mean(ISE_dict{'500'}{'RSF'}), mean(ISE_dict{'1000'}{'RSF'});
mean(ISE_dict{'50'}{'SQR'}), mean(ISE_dict{'100'}{'SQR'}), mean(ISE_dict{'200'}{'SQR'}), mean(ISE_dict{'500'}{'SQR'}), mean(ISE_dict{'1000'}{'SQR'});
mean(ISE_dict{'50'}{'dirichlet'}), mean(ISE_dict{'100'}{'dirichlet'}), mean(ISE_dict{'200'}{'dirichlet'}), mean(ISE_dict{'500'}{'dirichlet'}), mean(ISE_dict{'1000'}{'dirichlet'});
mean(ISE_dict{'50'}{'log_norm'}), mean(ISE_dict{'100'}{'log_norm'}), mean(ISE_dict{'200'}{'log_norm'}), mean(ISE_dict{'500'}{'log_norm'}), mean(ISE_dict{'1000'}{'log_norm'})
mean(ISE_dict{'50'}{'iln'}), mean(ISE_dict{'100'}{'iln'}), mean(ISE_dict{'200'}{'iln'}), mean(ISE_dict{'500'}{'iln'}), mean(ISE_dict{'1000'}{'iln'})];
