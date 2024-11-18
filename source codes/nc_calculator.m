function [int] = nc_calculator(theta)

leb = getLebedevSphere(5810);

y = [leb.x, leb.y, leb.z];

y4 = y.^4;

y2 = y.^2;

dens = sum((theta([1,2,3]).* y4),2) + theta(4).*y2(:,1).*y2(:,2) + theta(5).*y2(:,1).*y2(:,3) + theta(6).*y2(:,2).*y2(:,3); 

v = exp(dens);

int = sum(v.*leb.w) / 8; 