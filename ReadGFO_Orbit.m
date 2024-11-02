function [t_dy,r, v] = ReadGFO_Orbit(Infilename)
% function to read the orbit files of GRACE-FO satellites and 
% output time, position and velocity of the satellite.
%   Author: KGF; CU Boulder; ASEN 1320 Spring 2024 


% number of header lines in the GRACE-FO orbit files from NASA JPL
HeaderLines = 148;
fileID = fopen(Infilename,'r');
% go through the header lines
for i = 1:HeaderLines
      fgetl(fileID);
end
% after the for loop, the file pointer will be placed at the end of header lines

% read the data with fscanf
GFO_Orb=fscanf(fileID, '%d %s%s %f%f%f %f%f%f %f%f%f %f%f%f %d \n',[16 Inf]);
fclose(fileID);

% transpose 
GFO_Orb = GFO_Orb';

% extract time: seconds since 01-Jan-2000 11:59:47 UTC
t_sec = GFO_Orb(:,1);
% convert to UTC 
t_date = datetime( '01-Jan-2000 11:59:47') +  seconds(t_sec);
% convert UTC to decimal year
t_dy = decyear(t_date);  % decimal year

% extract position: [x y z]
r = GFO_Orb(:,4:6);

% extract velocity: [Vx Vy Vz]
v = GFO_Orb(:,10:12);


end