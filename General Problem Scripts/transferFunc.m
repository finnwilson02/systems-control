%% transfer function 
clear all;
clc;

A = 4;
B = -2;
C  = 1;;
D = 0;

fprintf('G(s) = C(sI-A)^{-1}B+D\n\n');

syms sI_A
syms s
sI_A =[s-A];

syms G
G = C*inv(sI_A)*B + D;
disp(G);

%compare to inbuilt transfer function
sys = ss(A,B,C,D);
[numerator,denominator] = ss2tf(A,B,C,D)