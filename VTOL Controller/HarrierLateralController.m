% Lateral controller
clear;
clc;

%% System parameters (all in SI units)
m = 22471;				% mass of aircraft
J = 0.0475;			% inertia around pitch axis
r = 6.97;			% distance to center of force
g = 9.8;			% gravitational constant
c = 0.05;	 		% damping factor (estimated)
WS = 11;            % wingspan (m)

%% System model
A = [0, 0, 1, 0;
     0, 0, 0, 1;
     0, -g, -c/m, 0;
     0, 0, 0, 0];

B = [0;  
     0; 
     1/m; 
     r/J];

C = [1, 0, 0, 0];

D = 0;

%% Pole Placement
characteristic = charpoly(A);
eigA = eig(A);

Atilde = [-characteristic(2:5);1,0,0,0;0,1,0,0;0,0,1,0];
Btilde = [characteristic(1);0;0;0];

Ktilde = [62.8;1413.97;13439.6;45800.6];

W = [B, A*B, A^2*B, A^3*B];
Wtilde = [Btilde, Atilde*Btilde, Atilde^2*Btilde, Atilde^3*Btilde];

T = Wtilde*inv(W);
K_poles = Ktilde'*T;

%% %% LQR, Cost function
Qz = eye(4);
rho = 10^8; % density
Qv = rho;

[K, S, e] = lqr(A, B, Qz, Qv);
%r = [20, 0, 0, 0];
r = 0;

ki = [0 0 0 0];
L = K';
K = [0.8,1,1,1].*K;
rhopoles = eig(A-B*K)

plot(rhopoles,'rx', 'MarkerSize',20,'LineWidth', 2);
grid on;
grid minor;
xlabel('real component');
ylabel('imaginary component');
xline(0);
yline(0);
axis([-1 1 -1 1]);

%% Reachable Canonical Form
% scale = 100;
% roots = eig(A-B*K);
% roots_scaled = [1; 1; scale; scale;].*real(roots) + i*imag(roots);
% K = place(A,B,roots_scaled);
% L = place(A',C',roots_scaled)';
% 
% poles = eig(A-B*K);
% Kplace = place(A,B,poles);
%K = K_poles;
kr = 1/(C*inv(A-B*K)*B);
%kr = 1;