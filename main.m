clc; clear all; close all;


%GNV1B_2024-02-22_D_04.txt will be read
Infilename = "GNV1B_2024-02-22_D_04.txt";

%Calls the function that will be reading the file.
[t_dy,r, v] = ReadGFO_Orbit(Infilename);

%Puts all of the r and v values into one matrix called r1 and v1
r1 = r;
v1 = v;

%puts the r1 values into x1, y1, and z1
x1 = r1(:,1);
y1 = r1(:,2);
z1 = r1(:,3);

%GNV1B_2024-02-22_C_04-1.txt will be read
Infilename = "GNV1B_2024-02-22_C_04-1.txt";

%%
%Calls the function that will be reading the file.
[t_dy,r, v] = ReadGFO_Orbit(Infilename);

%%
%Puts all of the r and v values into one matrix called r2 and v2
r2 = r;
v2 = v;

%puts the r1 values into x2, y2, and z2
x2 = r2(:,1);
y2 = r2(:,2);
z2 = r2(:,3);

%This function calculates the inter-satellite range (distance) rho using
%the equation given below and returns the result as the column vector Rho
[Rho] = GFO_Range(x1,y1,z1,x2,y2,z2);

%%
%This eqautoons calculates the dot product of the change in velocity and
%elos
[Rho_dot] = GFO_RangeRate(r1, r2, v1, v2);


%%
%This is the time that will be used as an increment being 1
dt = 1;

%This calculates Rho_dot_ND which is the inter satellite range rate and tho
%dot diff which is the difference between Rho_dot_ND and Rho_dot

[Rho_dot_ND, Rho_dot_diff] = GFO_NUmDiff(dt,Rho,Rho_dot);

%%
%This specifies the location of the ground station
rG = [1130714.219, -4831369.903, 3994085.962];

%This calculates for el and the index_vis which is for when the elevation
%angle is greater than 10 degrees.
[el, index_vis] = SatVisibility(rG,r1);
%%
%This writes the data of t_dy, Rho, and Rho_dot to GFO_file.csv
writeGFO_CSV("GFO_file.csv", t_dy, Rho, Rho_dot);



%%
%This begins to do the various plots. This first plot is the code for the
%path of the first Satellite

figure;

lla = ecef2lla(r1);
geoplot(lla(:,1),lla(:,2));
geobasemap topographic;

hold on 

%plots the location of SLR station in Maryland
lla = ecef2lla(rG);
geoplot(lla(:,1),lla(:,2), '^', 'MarkerSize', 10, 'MarkerFaceColor', 'k');

hold on


% Initialize arrays to store latitude and longitude of visible points
lla_visible = [];

% Loop to store latitude and longitude of visible points
for i = 1:86400
    if index_vis(i) ~= 0
        lla_point = ecef2lla(r1(i,:));
        lla_visible = [lla_visible; lla_point];
    end
end

% Plot the visible points in red
geoplot(lla_visible(:,1), lla_visible(:,2), "r.");
print('Global Satellite Plot','-dpng','-r300')
%%
%This creates the 3 sublots that display Rho, Rho_dot, and el with respect
%to time as given by the hours on 22 February


% Change the time series on t_dy
to = 365*24*(t_dy-t_dy(1)); %convert from decimal year to hours

figure;
%plots Rho with respect to time
subplot(3,1,1)
plot(to,Rho)

grid on
xlabel('time [hours in 22 Feb. 2024]','FontWeight','bold')
ylabel('range [km]','FontWeight','bold')

%plots t_dy with respect to time
subplot(3,1,2)
plot(to,Rho_dot)

grid on
xlabel('time [hours in 22 Feb. 2024]','FontWeight','bold')
ylabel('range-rate [m/s]','FontWeight','bold')


%plots el with respect to time and overlays index_vis for the values of
%t_dy that are greater than 10

subplot(3,1,3)
plot(to,el, "b")
hold on

%Allows for the plot of all the angle measures that are greater than 10l
index_vis(index_vis==0)=NaN; %convert 0 to NaNs
plot(to,index_vis, "r")

grid on
xlabel('time [hours in 22 Feb. 2024]','FontWeight','bold')
ylabel('elevation angle [deg]','FontWeight','bold')

print('Rho, Rho_dot, and el with respect to time','-dpng','-r300')
hold off

