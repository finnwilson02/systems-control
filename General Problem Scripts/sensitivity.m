clear all;
clc;

P = tf([1],[1,3,5]);
C = tf([1,2],[1,0]);
loops = loopsens(P,C);

sensitivityFunc = loops.Si;
sensitivityComp = loops.Ti;
transfer = loops.Li;

[sens_num, sens_den] = ss2tf(sensitivityFunc.A,sensitivityFunc.B,sensitivityFunc.C,sensitivityFunc.D);
[comp_nums,comp_dens] = ss2tf(sensitivityComp.A,sensitivityComp.B,sensitivityComp.C,sensitivityComp.D);

sensitivity2 = 1/(1+P*C);
complementary2 = P*C/(1+P*C);

fprintf('sensitivity function:\n\n');
disp(cell2mat(sensitivity2.numerator));
disp(cell2mat(sensitivity2.denominator));

fprintf('complementary sensitivity function:\n\n');
disp(cell2mat(complementary2.numerator));
disp(cell2mat(complementary2.denominator));

L = P*C;

fprintf('Loop transfer function:\n\n');
disp(cell2mat(L.numerator));
disp(cell2mat(L.denominator));
bode(L);