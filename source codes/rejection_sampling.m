function [samples] = rejection_sampling(theta,n)

% rejection sampling for compositional exponentail family

ngrid = 100;

m = simplex_grid_size(2, ngrid);
xgrid = simplex_grid_index_all(2, ngrid, m);
xgridc = xgrid'/ngrid;

[~,fs] = comp_exp_den(xgridc, theta);

max_fs = max(fs);

% begin rejection sampling

samples = zeros(n,3);

i = 1;

while i < n+1

    x = mvnrnd(zeros(3,1),eye(3));

    x = abs(x./sqrt(sum(x.^2))); % uniform sampling over first orthant
    
    threshold = unifrnd(0, 2*max_fs);

    [~,x_fs] = comp_exp_den(x, theta);

    if threshold < x_fs

        samples(i,:) = x;

        i = i + 1;

    end


end

samples = samples ./ sum(samples,2);

end