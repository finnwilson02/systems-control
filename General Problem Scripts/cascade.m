clear;
clc;
A1 = [0 2; 3, -1];
B1 = [3;2];
C1 = [2 1];
D1 = 0;
sys_1 = ss(A1, B1, C1, D1);
A2 = 4;
B2 = -2;
C2  = 1;
sys_2 = ss(A2, B2, C2, D1);

sys = series(sys_1, sys_2);
[num,den] = ss2tf(sys.A, sys.B, sys.C, sys.D); %matlab way
disp(num);
disp(den);

syms s
G = sys.C*inv(s*eye(3) - sys.A)*sys.B; %formula way
disp(G);

fprintf('y1(t) = G1(s)u1(t),      y2(t) = G2(s)u2(t)\n\n');
fprintf('y2(t) = G2(s)(G1(s)u1(t)\n\nG(s) = G2(s)G1(s)\n\n');

[num1,den1] = ss2tf(A1, B1, C1, D1);  %Gp*Gc way
[num2,den2] = ss2tf(A2, B2, C2, D1);

fprintf('G1(s), G2(s) = \n\n');
disp([num1;den1]);
disp([num2;den2]);