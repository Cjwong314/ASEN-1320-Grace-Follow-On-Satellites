function [el, index_vis] = SatVisibility(rG,r1)
 
%Assigns x1, y1, and z1 to the specific columns found in r1
x1 = r1(:,1);
y1 = r1(:,2);
z1 = r1(:,3);

%Describes the specific indicies of rG
xg = rG(1,1);
yg = rG(1,2);
zg = rG(1,3);

%calculates the distance 
d = sqrt((x1-xg).^2+(y1-yg).^2+(z1-zg).^2);

%Commputes the elevation angle using arc sin and stores the result in
%degrees
el  = asind((z1-zg)./d);


index_vis = zeros(size(el));

%determines the values of el that are greater than 10 and assigns them to
%index_vis
    for i = 1:86400
        if el(i) > 10
            index_vis(i) = el(i);
        end
    end
end
