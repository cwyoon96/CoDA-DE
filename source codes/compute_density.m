function [dens] = compute_density(x, C, kernel, h, Sigma)

n = size(C,1);
dens = 0;

if kernel == 1
   
    dens = sum(dirichlet_kernel(x, C,h));

end
        
if kernel == 2

    dens = sum(normal_kernel(x, C, h, Sigma));
        
end

dens = dens / n;
