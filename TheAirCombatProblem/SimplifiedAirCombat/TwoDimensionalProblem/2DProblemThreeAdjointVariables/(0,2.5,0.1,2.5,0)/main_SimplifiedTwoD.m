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
[problem,guess]=SimplifiedTwoD;          % Fetch the problem definition
options= problem.settings(10,10);          % Get options and solver settings 
[solution,MRHistory]=solveMyProblem( problem,guess,options);
[ tv, xv, uv ] = simulateSolution( problem, solution, 'ode113', 0.01 );


t_end = 3;
%plot velocity of PE
figure(1)
plot(tv,xv(:,1),'b--',tv,xv(:,7),'r','Linewidth',3)  
ylabel('Velocity')
xlabel('t')
xlim([0 t_end])
legend('Pursuer','Evader')
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on

%plot P costate
figure(2)
plot(tv,xv(:,4),'--',tv,xv(:,5),':',tv,xv(:,6),'Linewidth',3)
ylabel('Adjoint Variables')
xlabel('t') 
xlim([0 t_end])
legend('\lambda_v_p','\lambda_x_p','\lambda_h_p')
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on

%plot state variable with time seperately
figure(3)
subplot(1,3,1)
plot(tv,xv(:,1),'b--','LineWidth',3)
hold on 
plot(tv,xv(:,7),'r-','LineWidth',3)
ylabel('x')
xlabel('t')
xlim([0 t_end])
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on
legend('Pursuer','Evader')

subplot(1,3,2)
plot(tv,xv(:,2),'b--','LineWidth',3)
hold on 
plot(tv,xv(:,8),'r-','LineWidth',3)
ylabel('y')
xlabel('t')
xlim([0 t_end])
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on


subplot(1,3,3)
plot(tv,xv(:,3),'b--','LineWidth',3)
hold on 
plot(tv,xv(:,9),'r-','LineWidth',3)
ylabel('\phi')
xlabel('t')
xlim([0 t_end])
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on
%plot costate seperately
figure(4)
subplot(1,3,1)
plot(tv,xv(:,4),'LineWidth',3)
ylabel('\lambda_{vp}')
xlabel('t')
xlim([0 t_end])
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on

subplot(1,3,2)
plot(tv,xv(:,5),'LineWidth',3)
ylabel('\lambda_{xp}')
xlabel('t')
xlim([0 t_end])
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on

subplot(1,3,3)
plot(tv,xv(:,6),'LineWidth',3)
ylabel('\lambda_{yp}')
xlabel('t')
xlim([0 t_end])
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on

load('NN_0.5.mat');
gamma_p = net([xv(:,4)';xv(:,5)';xv(:,6)';xv(:,1)'])';

%plot the control of PE
figure(9)
plot(tv,uv,'r',tv,gamma_p,'b--','Linewidth',3)
ylabel('Controls')
xlabel('t')
xlim([0 t_end])
legend('Evader','Pursuer')
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on

%plot the trajectory of PE
figure(10)
plot(xv(:,2),xv(:,3),'b--',xv(:,8),xv(:,9),'r','Linewidth',3)
ylabel('Altitude')
xlabel('Down range')
legend('Pursuer','Evader')
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on



