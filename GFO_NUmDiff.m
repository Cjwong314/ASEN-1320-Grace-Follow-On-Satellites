function [Rho_dot_ND, Rho_dot_diff] = GFO_NUmDiff(dt,Rho,Rho_dot)

%Pre allocating for speed
N = 86400;

Rho_dot_ND = zeros(1,N);
Rho_dot_diff = zeros(1,N);
    
    %This calculates each part of Rho_dot_ND which is Rho(i)-Rho(i-1)/dt

    for i = 2:N
        Rho_dot_ND(i) = (Rho(i)-Rho(i-1))/dt;
    end
    %this calculates the difference between RHo_dot_ND and Rho
    for i = 1:N
        Rho_dot_diff(i) = Rho_dot_ND(i) - Rho(i);
    end

end