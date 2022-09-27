clear all;
clc;

%% Pole Placement for State Feedback
% INPUT-----
poles = [-2 + 1i, -2-1i];
%-----------
A = [0,2;3,-1];
B = [3;2];
K = place(A, B, poles);
size = length(A);

eigs = eig(A);
a = poly(eigs);
p = poly(poles);
Abar = [-a(2:end); eye(size)];
Abar = Abar(1:(end - 1), :);
Bbar = zeros(size, 1);
Bbar(1) = 1;
Kbar = p(2:end) - a(2:end);
Wbar = ctrb(Abar, Bbar);
W = ctrb(A,B);
T = Wbar*inv(W);
K2 = Kbar*T;
fprintf('Pole Placement:\n')
fprintf('OL pole: %f \n', eigs)
fprintf('Abar:\n')
disp(Abar);
fprintf('Bbar:\n')
disp(Bbar);
fprintf('W:\n')
disp(W);
fprintf('Wbar:\n')
disp(Wbar);
fprintf('T:\n')
disp(T);
fprintf('a_i:\n');
disp(a(2:end));
fprintf('p_i:\n');
disp(p(2:end));
fprintf('k_i = p_i - a_i:\n');
disp(Kbar);
fprintf('K = Kbar*T\n')
disp(K);