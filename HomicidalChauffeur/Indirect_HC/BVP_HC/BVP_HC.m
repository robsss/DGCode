tic

% function BVP_HC
clc
close all
clear all
%%% Initial Conditions
%Pursuer
global x10 phi10 x20 v1 v2 u1max l  t_p x1_p x2_p...
          phi1_p y1_p y2_p thresh
x10     = [0;0];
phi10   = pi/2;
% Evader
x20     = [0;-1];
% Parameters
v1      = 1;
v2      = 0.1;
u1max   = 1;
l       = 1;
% Initializing variables for the initial guess
t_p     = 0;         phi1_p    = phi10;
x1_p    = x10(1);    y1_p      = x10(2);
x2_p    = x20(1);    y2_p      = x20(2);
% Initial guess for lagrange multiplier of terminal cond.
% It is very important to provide good guess for thr init
% guess for lagrange multiplier

alpha0  = -0.6;
% Threshold for p3 below which p3 = 0
thresh  = 0.01;
N       = 100;
mesh    = linspace(0,1,N);
% Create initial guess for state and costate
solinit = bvpinit(mesh,@HC_init,alpha0);
% Run BVP Solver
options = bvpset('stats','on');
sol = bvp4c(@HC_ode,@HC_bc,solinit,options);
alpha = sol.parameters;
max = size(sol.y,2);
tf = sol.y(11,max);
% Plot Results
if 1
    figure(1)
    hold on
    Pstate = sol.y(1:2,:);
    Estate = sol.y(4:5,:);
    plot(Estate(1, :),Estate(2,:),'r-','linewidth',3);
    plot(Pstate(1, :),Pstate(2,:) ,'b--','Linewidth',3);
    plot(x20(1),x20(2),'rx','LineWidth',3,'MarkerSize',10);
    plot(x10(1),x10(2),'bd','LineWidth',3,'MarkerSize',6);
    legend('逃方路径','追方路径','逃方初始位置', ...
        '追方初始位置 ','location','South');
    axis equal
    xlabel('x', 'FontSize',14);
    ylabel('y', 'FontSize',14);
    set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
    set(gca,'Fontname','Monospaced','FontSize',15);
    grid on
    shg
    hold off
    figure(2)
    lambda_xp = sol.y(6,:);
    lambda_yp = sol.y(7,:);
    lambda_phi = sol.y(8,:);
    lambda_xe = sol.y(9,:);
    lambda_ye = sol.y(10,:);
    tout = tf*sol.x;
    
    plot(tout, lambda_xp, 'r--', 'Linewidth',3);
    hold on
    plot(tout, lambda_yp, 'g--' , 'Linewidth',3);
    hold on
    plot(tout, lambda_phi, 'b--', 'Linewidth',3);
    hold on
    plot(tout, lambda_xe, 'r-', 'Linewidth',3);
    hold on
    plot(tout, lambda_ye, 'g-','Linewidth',3);
    legend('\lambda_{x_p}', '\lambda_{y_p}', '\lambda_{\phi}',...
        '\lambda_{x_e}', '\lambda_{y_e}','location','eastoutside')
    xlim([0, 3])
    set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
    set(gca,'Fontname','Monospaced','FontSize',15);
    grid on
end

toc
disp(['运行时间: ',num2str(toc)]);

