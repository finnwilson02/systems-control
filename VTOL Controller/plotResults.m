clear all;
clc;
clf;

poleplacement = importdata('poleplacement.mat');

rho_4 = importdata('rho10^4.mat');
rho6 = importdata('rho10^6.mat');
rho8 = importdata('rho10^8.mat');
rho10 = importdata('rho10^10.mat');

r10 = importdata('r10.mat');
r20 = importdata('r20.mat');
r30 = importdata('r30.mat');
r50 = importdata('r50.mat');
r70 = importdata('r70.mat');

multi = importdata('multi_input.mat');

observer = importdata('observer.mat');

wind = importdata('windDisturb2.mat');
missiles = importdata('missiles.mat');

%% Pole placement
x_poles = poleplacement.x;
theta_poles = poleplacement.theta;
t_poles = poleplacement.tout;
figure(1);
yyaxis left
plot(t_poles,x_poles,'color','#1338be');
ylabel('lateral position (m)');
hold on;
yyaxis right
plot(t_poles,theta_poles,'color','#e05a00');
grid on;
grid minor;
ylabel('roll angle (^o)');
xlabel('time (s)');

%% Compare x inputs
x1_rho = r10.x;
x2_rho = r20.x;
x3_rho = r30.x;
x4_rho = r50.x;
x5_rho = r70.x;
t1_rho = r10.tout;
t2_rho = r20.tout;
t3_rho = r30.tout;
t4_rho = r50.tout;
t5_rho = r70.tout;

figure(2);
plot(t1_rho,x1_rho);
hold on;
plot(t2_rho,x2_rho);
plot(t3_rho,x3_rho);
plot(t4_rho,x4_rho);
plot(t5_rho,x5_rho);
grid on;
grid minor;
xlabel('time (s)');
ylabel('lateral position (m)');
legend('r = 10m','r = 20m','r = 30m','r = 50m','r = 70m','location','Northwest');
axis([0 30 0 80]);

%% Compare theta inputs
theta1_rho = r10.theta;
theta2_rho = r20.theta;
theta3_rho = r30.theta;
theta4_rho = r50.theta;
theta5_rho = r70.theta;

figure(3);
plot(t1_rho,theta1_rho);
hold on;
plot(t2_rho,theta2_rho);
plot(t3_rho,theta3_rho);
plot(t4_rho,theta4_rho);
plot(t5_rho,theta5_rho);
grid on;
grid minor;
xlabel('time (s)');
ylabel('roll angle (^o)');
legend('r = 10m','r = 20m','r = 30m','r = 50m','r = 70m','location','Northeast');
axis([0 30 -20 15]);

%% Compare rho inputs for x
rho1 = rho_4.x;
rho2 = rho6.x;
rho3 = rho8.x;
rho4 = rho10.x;
t_rho1 = rho_4.tout;
t_rho2 = rho6.tout;
t_rho3 = rho8.tout;
t_rho4 = rho10.tout;

figure(4);
plot(t_rho1,rho1);
hold on;
plot(t_rho2,rho2);
plot(t_rho3,rho3);
plot(t_rho4,rho4);
grid on;
grid minor;
xlabel('time (s)');
ylabel('lateral position (m)');
legend('\rho = 10^4','\rho = 10^6','\rho = 10^8','\rho = 10^{10}','location','Northwest');
axis([0 30 0 80]);

%% Compare rho inputs for theta
rho1_theta = rho_4.theta;
rho2_theta = rho6.theta;
rho3_theta = rho8.theta;
rho4_theta = rho10.theta;

figure(5);
plot(t_rho1,rho1_theta);
hold on;
plot(t_rho2,rho2_theta);
plot(t_rho3,rho3_theta);
plot(t_rho4,rho4_theta);
grid on;
grid minor;
xlabel('time (s)');
ylabel('roll angle (^o)');
legend('\rho = 10^4','\rho = 10^6','\rho = 10^8','\rho = 10^{10}','location','Northeast');
%axis([0 30 -20 15]);

%% Compare observer to not
O_x = -observer.x;
O_theta = -observer.theta;
O_time = observer.tout;

figure(6);
plot(O_time, O_x);
hold on;
plot(t2_rho,x2_rho);
grid on;
grid minor;
xlabel('time (s)');
ylabel('lateral position (m)');
legend('observer','no observer');

figure(7);
plot(O_time, O_theta);
hold on;
plot(t2_rho,theta2_rho);
grid on;
grid minor;
xlabel('time (s)');
ylabel('roll angle (^o)');
legend('observer','no observer');

%% Multi input
multi_x = multi.x;
multi_theta = multi.theta;
multi_t = multi.tout;
multi_v = multi.v;
multi_w = multi.omega;
multi_r = multi.input(:,1);
multi_a = multi.a;

figure(8);
yyaxis left
plot(multi_t,multi_x);
ylabel('lateral position (m)');
hold on;
plot(multi_t,multi_r,'--k');
yyaxis right
plot(multi_t,multi_v);
grid on;
grid minor;
xlabel('time (s)');
ylabel('lateral velocity (m/s)');

figure(9);
yyaxis left
plot(multi_t,multi_theta);
ylabel('roll angle (^o)');
hold on;
yyaxis right
plot(multi_t,multi_w);
grid on;
grid minor;
xlabel('time (s)');
ylabel('angular velocity (^o/sec)');

figure(13);
plot(multi_t,multi_a);
grid on;
grid minor;
xlabel('time (s)');
ylabel('lateral acceleration (m/s^2)');

%% Disturbances
d_x1 = wind.x;
d_x2 = -missiles.x;
d_theta1 = wind.theta;
d_theta2 = -missiles.theta;
d_t1 = wind.tout;
d_t2 = missiles.tout;
d_u2 = missiles.u1;
d_u1 = wind.u1;

figure(10);
plot(d_t1, d_x1);
hold on;
plot(d_t2,d_x2);
grid on;
grid minor;
xlabel('time (s)');
ylabel('lateral position (m)');
legend('wind disturbance','missile launch','location','Southeast');
axis([0 50 -1.5 0.5]);

figure(11);
plot(d_t1,d_theta1);
hold on;
plot(d_t2,d_theta2);
grid on;
grid minor;
xlabel('time (s)');
ylabel('roll angle (^o)');
legend('wind disturbance','missile launch');
axis([0 50 -1.5 2]);


figure(12);
plot(d_t1,d_u1);
hold on;
%plot(d_t2,d_u2);
grid on;
grid minor;
xlabel('time (s)');
ylabel('system response u_1');
%legend('wind disturbance','missile launch');