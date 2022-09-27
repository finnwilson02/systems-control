%% Frequency Analysis
%% clear
clear all;
clc;
clf;

%% determine transfer fcn
A = [0 1; -2, -1];
B = [1;0];
C = [1 2];
D = 0;

sys = ss(A,B,C,D);
tf_1 = ss2tf(A,B,C,D);
%add shit to print working maybe

%% frequency response analysis
%uncomment to use transfer function instead of state space
sys = tf([-12000],[71383,8687,281,1]);

figure(1);
bode(sys);

figure(2);
nyquist(sys);

%% phase and gain margins
figure(3);
margin(sys);

figure(4);
step(sys);