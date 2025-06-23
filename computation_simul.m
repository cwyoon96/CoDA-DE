clear;clc;close all;

addpath('./source codes')
rng(6);

degree = 1;

time_dict = dictionary;

for p=3:10
    str_p = string(p);
    time_dict{str_p} = zeros(5,50);

    for iter = 1:50

        eval = randdirichlet(ones(1, p),1000);
        
        alpha = 1:p;
        alpha = alpha / sum(alpha.^2) + 1;
        
        X = randdirichlet(alpha,p * 300);
        
        h = 0.05;
        
        tic
        RSF_target(X,eval,h);
        time_dict{str_p}(1,iter) = toc;
        
        tic
        RSF_target_parallel(X,eval,h);
        time_dict{str_p}(2,iter) = toc;

        tic
        RSF_target_Approx(X,eval,h,degree);
        time_dict{str_p}(3,iter) = toc;
        
        tic
        Aitchison_target(X,eval,h);
        time_dict{str_p}(4,iter) = toc;
        
        tic
        Aitchison_target(X,eval,h,2);
        time_dict{str_p}(5,iter) = toc;

    end
end

save("time_comparison","time_dict")

mean_time = zeros(5,8);
std_time = zeros(5,8);

for p=3:10

    str_p = string(p);
    mean_time(:,p-2) = mean(time_dict{str_p},2);
    std_time(:,p-2) = std(time_dict{str_p},0,2);

end

x = 3:10;

figure; hold on;

errorbar(x, mean_time(1,:), std_time(1,:), 'r', 'LineWidth', 1);
errorbar(x, mean_time(2,:), std_time(2,:), 'b', 'LineWidth', 1);
errorbar(x, mean_time(3,:), std_time(3,:), 'g', 'LineWidth', 1);
errorbar(x, mean_time(4,:), std_time(4,:), 'm', 'LineWidth', 1);
errorbar(x, mean_time(5,:), std_time(5,:), 'c', 'LineWidth', 1);

xlabel('Dimension');
ylabel('Seconds');
legend({'RSF', 'RSF (Parallel)','RSF (Approx)' ,'Dirichlet', 'ALN'}, 'Location','northwest');
fontsize(16,"points")
grid on;
hold off;


%% How good is Approximation (folding approximation)


clear;clc;close all;

addpath('./source codes')
rng(6);

theta1 = [3, 0, -4, 0, -26, 12]; % parameter for comp. exp. family
theta2 = [-1,7,-2,-2,12,10];

n_sample = 500;

X1 = rejection_sampling(theta1, n_sample); % 100 sampled data from comp. exp. family
X2 = rejection_sampling(theta2, n_sample); 

h1 = RSF_cv(X1);
h2 = RSF_cv(X2);

ngrid = 100;
degree = 1;

[xgridc,fc_theta1] = RSF_den_Approx(X1,h1,ngrid,degree);
[xgridc,fc_theta2] = RSF_den_Approx(X2,h2,ngrid,degree);

writematrix(fc_theta1, strcat('./approximation/theta1/degree1_fc.csv'));
writematrix(fc_theta2, strcat('./approximation/theta2/degree1_fc.csv'));