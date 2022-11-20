
function [dx] = TwoDPE_ZBCU_Dynamics_Sim(x,u,p,t,vdat)
%Double Integrator Dynamics for Simulation
%
% Syntax:  
%          [dx] = Dynamics(x,u,p,t,vdat)
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
%
% Copyright (C) 2019 Yuanbo Nie, Omar Faqir, and Eric Kerrigan. All Rights Reserved.
% The contribution of Paola Falugi, Eric Kerrigan and Eugene van Wyk for 
%           the work on ICLOCS Version 1 (2010) is kindly acknowledged.
% This code is published under the MIT License.
% Department of Aeronautics and Department of Electrical and Electronic Engineering,
% Imperial College London London  England, UK 
% ICLOCS (Imperial College London Optimal Control) Version 2.5 
% 1 Aug 2019
% iclocs@imperial.ac.uk
%
%------------- BEGIN CODE --------------

% x_1 = x(:,1);x_2 = x(:,2);lambda_x1 = x(:,3);lambda_x2 = x(:,4);
% beta = u(:,1);
% sinalph =- lambda_x2./sqrt(lambda_x1.^2+lambda_x2.^2);
% cosalph = -lambda_x1./sqrt(lambda_x1.^2+lambda_x2.^2);
% 
% dx(:,1) = sqrt(2) .* cosalph + (beta + 1)./2;
% dx(:,2) = sqrt(2) .* sinalph + (beta - 1)./2;
% dx(:,3) = 0;
% dx(:,4) = -(lambda_x1.*cosalph+lambda_x2.*sinalph)./(2.*sqrt(x_2));

K_P = vdat.K_P;
v_p = vdat.v_p;
v_e = vdat.v_e;
x_p = x(:,1);y_p = x(:,2);psi_p = x(:,3);
x_e = x(:,4);y_e = x(:,5);psi_e = x(:,6);
lambda_xp = x(:,7);lambda_yp = x(:,8);lambda_psip = x(:,9);
omega_e = u(:,1);
omega_p = -lambda_psip./(2.*K_P);

dx(:,1) = v_p.*cos(psi_p);
dx(:,2) = v_p.*sin(psi_p);
dx(:,3) = omega_p;
dx(:,4) = v_e.*cos(psi_e);
dx(:,5) = v_e.*sin(psi_e);
dx(:,6) = omega_e;
dx(:,7) = 0;
dx(:,8) = 0;
dx(:,9) = lambda_xp.*v_p.*sin(psi_p)-lambda_yp.*v_p.*cos(psi_p);

%------------- END OF CODE --------------