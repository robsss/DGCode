% main_BangBang - Main script to solve the Optimal Control Problem
%
% BangBang Control (Double Integrator Minimum Time Repositioning) Problem
%
% The problem was adapted from Example 4.11 from
% J. Betts, "Practical Methods for Optimal Control and Estimation 
%   Using Nonlinear Programming: Second Edition," Advances in Design and 
%   Control, Society for Industrial and Applied Mathematics, 2010.
%
% Copyright (C) 2019 Yuanbo Nie, Omar Faqir, and Eric Kerrigan. All Rights Reserved.
% The contribution of Paola Falugi, Eric Kerrigan and Eugene van Wyk 
%   for the work on ICLOCS Version 1 (2010) is kindly acknowledged.
% This code is published under the MIT License.
% Department of Aeronautics and Department of Electrical and 
%   Electronic Engineering,
% Imperial College London London  England, UK 
% ICLOCS (Imperial College London Optimal Control) Version 2.5 
% 1 Aug 2019
% iclocs@imperial.ac.uk


%--------------------------------------------------------




%% Solve with mesh refinement
clear all;close all;format compact;
global init_psi_e
init_psi_e = pi/3;
[problem,guess]=TwoDPE_GTCCU;          % Fetch the problem definition
options= problem.settings(5,20);          % Get options and solver settings 
[solution,MRHistory]=solveMyProblem( problem,guess,options);
[ tv, xv, uv ] = simulateSolution( problem, solution, 'ode113', 0.01 );


 LineWidth = 3;
 t_end = 90;
% figure(1)
% plot(tv,xv(:,1),'LineWidth',LineWidth)  
% hold on
% plot(tv,xv(:,4),'LineWidth',LineWidth)
% ylabel('x')
% xlabel('t')
% grid on
% xlim([0 50])
% legend('Pursuer','Evader')
% legend('Fontname','Monospaced','FontSize',15,'LineWidth',1);
% set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
% set(gca,'Fontname','Monospaced','FontSize',15);
% 
% 
% figure(2)
% plot (tv,xv(:,2),'LineWidth',LineWidth)
% hold on
% plot(tv,xv(:,5),'LineWidth',LineWidth)
% ylabel('y')
% xlabel('t')
% grid on
% xlim([0 50])
% legend('Pursuer','Evader')
% legend('FontSize',15,'LineWidth',1);
% set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
% set(gca,'Fontname','Monospaced','FontSize',15);
% 
% figure(3)
% plot(tv,xv(:,3),'LineWidth',LineWidth)
% hold on 
% plot(tv,xv(:,6),'LineWidth',LineWidth)
% grid on
% ylabel('psi')
% xlabel('t')
% xlim([0 50])
% legend('Pursuer','Evader')
% legend('FontSize',15,'LineWidth',1);
% set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
% set(gca,'Fontname','Monospaced','FontSize',15);


figure(4)
plot(xv(:,1),xv(:,2),'b--','LineWidth',LineWidth)
hold on 
plot(xv(:,4),xv(:,5),'r','LineWidth',LineWidth)
ylabel('y')
xlabel('x')
grid on
legend('Pursuer','Evader')
legend('FontSize',15,'LineWidth',1);
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);


figure(5)
plot(tv,xv(:,7),'b--','LineWidth',LineWidth)
hold on
plot(tv,xv(:,8),'r-','LineWidth',LineWidth)
hold on
plot(tv,xv(:,9),'m-.','LineWidth',LineWidth)
grid on
xlabel('t')
legend('\lambda_{e1}', '\lambda_{e2}', '\lambda_{e3}')
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);



lambda_psip = xv(:,9);
K_P = 100;
omega_p = -lambda_psip./(2.*K_P);
figure(51)
plot(tv,uv,'r-','LineWidth',LineWidth)
hold on
plot(tv,omega_p,'b--','LineWidth',LineWidth)
xlabel('t(s)')
ylabel('控制变量')
grid on
legend('逃方控制\omega_e', '追方控制\omega_p')
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
xlim([0 t_end])

figure(6)
subplot(1,3,1)
plot(tv,xv(:,1),'b--','LineWidth',LineWidth)  
hold on
plot(tv,xv(:,4),'r-','LineWidth',LineWidth)
ylabel('crossrange x(km)')
xlabel('time t(s)')
grid on
xlim([0 t_end])
legend('Pursuer','Evader')
legend('Fontname','Monospaced','FontSize',15,'LineWidth',1);
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);

subplot(1,3,2)
plot (tv,xv(:,2),'b--','LineWidth',LineWidth)
hold on
plot(tv,xv(:,5),'r-','LineWidth',LineWidth)
ylabel('Height y(km)')
xlabel('Time t(s)')
grid on
xlim([0 t_end])
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);


subplot(1,3,3)
plot(tv,xv(:,3),'b--','LineWidth',LineWidth)
hold on 
plot(tv,xv(:,6),'r-','LineWidth',LineWidth)
grid on
ylabel('\psi(rad)')
xlabel('time t(s)')
xlim([0 t_end])
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);

dist = sqrt((xv(:,1)-xv(:,4)).^2+(xv(:,2)-xv(:,5)).^2);
figure(7)
plot(tv,dist,'LineWidth',LineWidth)
legend('瞬时相对距离')
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on
xlabel('时间t(s)')
ylabel('攻防对抗双方相对距离(km)')
xlim([0 t_end])

lagrange_p = uv.^2;
u_e = -xv(:,9)./200;
lagrange_e = u_e.^2;
integral_p = 100*cumtrapz(tv,lagrange_p);
integral_e = 100*cumtrapz(tv,lagrange_e);
J_p = dist./2 + integral_p;
J_e = -dist./2 + integral_e;
sum = J_p + J_e;

figure(8)
plot(tv,J_p,'b--','LineWidth',LineWidth)
hold on 
plot(tv,J_e,'r-','LineWidth',LineWidth)
hold on
plot(tv,sum,'k-.','LineWidth',LineWidth)
grid on
ylabel('代价函数')
xlabel('时间t(s)')
legend('追方代价函数','逃方代价函数','双方代价函数之和')
xlim([0 t_end])
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
