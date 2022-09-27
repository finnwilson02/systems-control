%% create tunable PID controller
clear all;
clc;

A = [0 1; -2, -1];
B = [1;0];
C = [1 2];
D = 0;

sys = ss(A,B,C,D);
[numerator,denominator] = ss2tf(A,B,C,D);

Kp = 1;
Ki = 1;
Kd = 1;

%C = pid(sys);
C = pid(Kp,Ki,Kd,[numerator;denominator]);