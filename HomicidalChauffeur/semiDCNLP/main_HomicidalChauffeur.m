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
[problem,guess]=HomicidalChauffeur;          % Fetch the problem definition
options= problem.settings(6,16);          % Get options and solver settings 
[solution,MRHistory]=solveMyProblem( problem,guess,options);
[ tv, xv, uv ] = simulateSolution( problem, solution, 'ode113', 0.01 );

t_end = 5;

figure(1)
subplot(3,2,1)
plot(tv,xv(:,1),'LineWidth',3)  
ylabel('x_p')
xlabel('t')
xlim([0 t_end])

subplot(3,2,2)
plot (tv,xv(:,2),'LineWidth',3)
ylabel('y_p')
xlabel('t')
xlim([0 t_end])

subplot(3,2,3)
plot(tv,xv(:,3),'LineWidth',3)
ylabel('phi')
xlabel('t')
xlim([0 t_end])

subplot(3,2,4)
plot(tv,xv(:,4),'LineWidth',3)
ylabel('x_e')
xlabel('t')
xlim([0 t_end])

subplot(3,2,5)
plot(tv,xv(:,5),'LineWidth',3)
ylabel('y_e')
xlabel('t')
xlim([0 t_end])

figure(2)
plot(tv,xv(:,6),'LineWidth',3)
ylabel('\lambda')
xlabel('t')
xlim([0 t_end])
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on

lambda = xv(:,6);
u_e = atan(lambda);
figure(3)
plot(tv,uv,'b--','LineWidth',3)
hold on 
plot(tv,u_e,'r-','Linewidth',3)
ylabel('control')
xlabel('t')
ylim([-1.5,1.5])
xlim([0 t_end+1])
legend('u_p', '\psi')
legend('FontSize',20,'LineWidth',1);
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on


figure(4)
plot (xv(:,1),xv(:,2),'b--','LineWidth',3)
hold on
plot(xv(:,4),xv(:,5),'r-','LineWidth',3)
ylabel('y')
xlabel('x')
axis equal
legend('Pursuit','Evader','location','South')
legend('FontSize',20,'LineWidth',1);
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on

