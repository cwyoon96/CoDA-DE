function [samples] = rejection_sampling_piecewise(n)

max_val = 10;

% begin rejection sampling

samples = zeros(n,3);

i = 1;

while i < n+1

    x = randdirichlet(ones(1,3),1);
    
    threshold = unifrnd(0, 2*max_val);

    x_fc = piecewise_den(x);

    if threshold < x_fc

        samples(i,:) = x;

        i = i + 1;

    end


end

end