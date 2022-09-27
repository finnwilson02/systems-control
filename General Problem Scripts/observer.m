%% Design an observer 
clear all;
clc;

%% via pole placement
poles = [-2 + 1i, -2-1i];

A = [0 2; 3, -1];
B = [3;2];
C = [1 0];
D = 0;

%via poles of observer
L = place(A',C',poles);

%via poles of system
K = place(A,B,poles);
L_alt = K'; %change to L to give working based on system poles

%print working here if I have time
syms A_LC
syms L1
syms L2
syms lambda
A_LC = A - [L1;L2]*C;
characteristic = det(A_LC-lambda*eye(2));
eigenvals = eig(A_LC);

fprintf('poles of the system are: %d + %di, %d + %di\n\nwhich are equal to eigenvalues of (A-LC)\n\n',real(poles(1)),imag(poles(1)),real(poles(2)),imag(poles(2)));
fprintf('eig(A-LC) = det((A-LC)-lambda)\n\n');
fprintf('A - LC:\n');
disp(A_LC);
fprintf('Characteristic polynomial:\n');
disp(characteristic);
fprintf('Eigenvalues:\n');
disp(eigenvals);

fprintf('lambda_1 = p_1, lamda_2 = p_2\n\n');
fprintf('L1, L2 = \n\n');
disp(L);