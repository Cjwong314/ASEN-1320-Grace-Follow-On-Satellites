function [Rho] = GFO_Range(x1,y1,z1,x2,y2,z2)
%This function calculates the inter-satellite range (distance) rho using
%the equation given below and returns the result as the column vector Rho
Rho = sqrt((x2-x1).^2+(y2-y1).^2+(z2-z1).^2);


end