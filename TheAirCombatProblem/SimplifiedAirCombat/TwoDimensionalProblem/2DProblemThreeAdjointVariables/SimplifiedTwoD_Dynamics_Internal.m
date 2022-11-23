
function [dx] = SimplifiedTwoD_Dynamics_Internal(x,u,p,t,vdat)
% Double Integrator Dynamics - Internal
%
% Syntax:  
%          [dx] = Dynamics(x,u,p,t,vdat)	(Dynamics Only)
%          [dx,g_eq] = Dynamics(x,u,p,t,vdat)   (Dynamics and Eqaulity Path Constraints)
%          [dx,g_neq] = Dynamics(x,u,p,t,vdat)   (Dynamics and Inqaulity Path Constraints)
%          [dx,g_eq,g_neq] = Dynamics(x,u,p,t,vdat)   (Dynamics, Equality and Ineqaulity Path Constraints)
% 
% Inputs:
%    x  - state vector
%    u  - input
%    p  - parameter
%    t  - time
%    vdat - structured variable containing the values of additional data used inside
%          the function%      
% Output:
%    dx - time derivative of x
%    g_eq - constraint function for equality constraints
%    g_neq - constraint function for inequality constraints
%
% Copyright (C) 2019 Yuanbo Nie, Omar Faqir, and Eric Kerrigan. All Rights Reserved.
% The contribution of Paola Falugi, Eric Kerrigan and Eugene van Wyk for the work on ICLOCS Version 1 (2010) is kindly acknowledged.
% This code is published under the MIT License.
% Department of Aeronautics and Department of Electrical and Electronic Engineering,
% Imperial College London London  England, UK 
% ICLOCS (Imperial College London Optimal Control) Version 2.5 
% 1 Aug 2019
% iclocs@imperial.ac.uk

%
%------------- BEGIN CODE --------------
% states of pursuer
v_p = x(:,1);
x_p = x(:,2);
h_p = x(:,3);

% costates of pursuer
lambda_vp = x(:,4);
lambda_xp = x(:,5);
lambda_hp = x(:,6);

% states of evader
v_e = x(:,7);
x_e = x(:,8);
h_e = x(:,9);

% control of evader
gamma_e = u(:,1);

% Some constant of problem
C_D0 = 0.0165;
C_D0p = C_D0;
C_D0e = C_D0;
k = 0.1676;
k_p = k;
k_e = k;
rho = 1.76340e5;
S = 1.875e-5;
S_p = S;
S_e = S;
g = 8.04350e-1;
m = 1;
m_e = m;
m_p = m;
T_p =1;
T_e = 0.5;

% Load the control equations fitted by Neural Net.
load('NN_0.5.mat');
gamma_p = net([lambda_vp';lambda_xp';lambda_hp';v_p'])';

% State equations and costate equations.
dx(:,1) = (T_p-0.5.*rho.*v_p.^2.*S_p.*C_D0p-2.*k_p.*m_p.^2.*g.^2.*...
            cos(gamma_p)./rho./v_p.^2)./m_p-g.*sin(gamma_p);
dx(:,2) = v_p.*cos(gamma_p);
dx(:,3) = v_p.*sin(gamma_p);
dx(:,4) = lambda_vp./m.*(rho.*v_p.*S.*C_D0-4.*k.*m^2.*g.^2.*...
          cos(gamma_p).^2./rho./v_p.^3./S)-lambda_xp.*cos(gamma_p)-...
          lambda_hp.*sin(gamma_p);
dx(:,5) = 0;
dx(:,6) = 0;
dx(:,7) = (T_e-0.5.*rho.*v_e.^2.*S_e.*C_D0e-2.*k_e.*m_e.^2.*g.^2.*...
          cos(gamma_e)./rho./v_e.^2)./m_e-g.*sin(gamma_e);
dx(:,8) = v_e.*cos(gamma_e);
dx(:,9) = v_e.*sin(gamma_e);



%------------- END OF CODE --------------