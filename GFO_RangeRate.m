function [Rho_dot] = GFO_RangeRate(r1, r2, v1, v2)

%puts the r1 values into x1, y1, and z1
x1 = r1(:,1);
y1 = r1(:,2);
z1 = r1(:,3);


%puts the r1 values into x1, y1, and z1

x2 = r2(:,1);
y2 = r2(:,2);
z2 = r2(:,3);


%This calculates the column vector for Rho in this local instance

[Rho] = GFO_Range(x1,y1,z1,x2,y2,z2);
%Finds the change in velocity
delta_v = v2-v1;
%finds the change in distance between R2 and R1
delta_r = r2-r1;

%Calculates elos which is the unit vector form Grace-Fo Satellite 1 to
%satellite 2
elos = delta_r ./ Rho;

%This is a for loop that will determine the dot product of delta and elos
%that will be assigned to individual indicies of Rho dot
for i = 1:86400
    Rho_dot(i) = dot(delta_v(i,:), elos(i,:));
end