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
[problem,guess]=Dolichobrachistochrone;          % Fetch the problem definition
options= problem.settings(10,5);          % Get options and solver settings 
[solution,MRHistory]=solveMyProblem( problem,guess,options);
[ tv, xv, uv ] = simulateSolution( problem, solution, 'ode113', 0.01 );



figure(1)
subplot(2,3,1)
plot(tv,xv(:,1))  
ylabel('x_1')
xlabel('t')
xlim([0 10])

subplot(2,3,2)
plot (tv,xv(:,2))
ylabel('x_2')
xlabel('t')
xlim([0 10])

subplot(2,3,3)
plot(tv,xv(:,3))
ylabel('\lambda_x_1')
xlabel('t')
xlim([0 10])

subplot(2,3,4)
plot(tv,xv(:,4))
ylabel('\lambda_x_2')
xlabel('t')
xlim([0 10])

subplot(2,3,5)
plot(tv,uv)
ylabel('\beta')
xlabel('t')
xlim([0 10])

subplot(2,3,6)
plot (xv(:,1),xv(:,2))
ylabel('x_2')
xlabel('x_1')

% plot the trajectory of state
figure(2)
plot (xv(:,1),xv(:,2),'LineWidth',3)
ylabel('x')
xlabel('y')
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on

% plot the control of 1 and 2
lambda_x = xv(:,3);
lambda_y = xv(:,4);
alpha = atan(-lambda_y./lambda_x) + 0.5 * pi;

figure(3)
plot (tv, uv, 'r-','LineWidth',3)
hold on 
plot (tv, alpha, 'b--','LineWidth',3)
ylabel('Controls')
xlabel('t')
legend('\beta','\alpha');
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on

% plot the costates
figure(4)
plot(tv,xv(:,3),'r-','LineWidth',3)
hold on 
plot(tv,xv(:,4),'b--','LineWidth',3)
legend('\lambda_x','\lambda_y');
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on

%plot optimal states
figure(5)
subplot(1,2,1)
plot(tv,xv(:,1),'r-','LineWidth',3)
ylabel('x')
xlabel('t')
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on

subplot(1,2,2)
hold on
plot(tv,xv(:,2),'b-','LineWidth',3)  
ylabel('y')
xlabel('t')
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on
