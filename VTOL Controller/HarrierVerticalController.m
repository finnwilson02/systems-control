% Lateral controller
clear;
clc;

%% System parameters (all in SI units)
m = 22471;				% mass of aircraft
J = 0.0475;			% inertia around roll axis
r = 0.25;			% distance to center of force
g = 9.8;			% gravitational constant
c = 0.05;	 		% damping factor (estimated)
WS = 11;            % wingspan (m)

%% System model
A = [0, 0, 1, 0;
     0, 0, 0, 1;
     0, 0, -c/m, 0;
     0, 0, 0, 0];

B = [0; 
     0;  
     1/m; 
     0];

C = [1, 0, 0, 0, 0, 0;
     0, 1, 0, 0, 0, 0];

D = 0;

characteristic = charpoly(A);
eigA = eig(A);

Atilde = [-characteristic(2:5);1,0,0,0;0,1,0,0;0,0,1,0];
Btilde = [characteristic(1);0;0;0];


%% %% LQR, Cost function
Qz = eye(4);
rho = 1; % density
Qv = rho;

[K, S, e] = lqr(A, B, Qz, Qv);
r = [5*WS, 0, 0, 0];

ki = [0 0 0 0];

%% Reachable Canonical Form
scale = 1;
roots = eig(A-B*K);
roots_scaled = [1; 1; scale; scale; scale; scale].*real(roots) + i*imag(roots);
K = place(A,B,roots_scaled);
L = place(A',C',roots_scaled)';

poles = eig(A-B*K);
Kplace = place(A,B,poles);
kr = 1./(C*inv(A-B*Kplace)*B);
kr = kr(1,1);