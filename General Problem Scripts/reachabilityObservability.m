

A = [0,1;-6,-5];
B = [0 1]';
C = [0 1];
D = 0;

size = length(A);
sys = ss(A, B, C, D);
OLpoles = eig(A);
%% Find transfer function from state space
[numerator, denominator] = ss2tf(A, B, C, D); 

%% Check Reachability & Observability
W = ctrb(cascaded.A, cascaded.B);
Wo = obsv(cascaded.A, cascaded.C);

isReach = false;
isObservable = false;
rank(W)
rank(Wo)
if size == rank(W)
    isReach = true;
end
if size == rank(Wo)
    isObservable = true;
end