
function [dx] = HomicidalChauffeur_Dynamics_Sim(x,u,p,t,vdat)
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

v_p = vdat.v_p;
v_e = vdat.v_e;

x_p = x(:,1);
y_p = x(:,2);
phi = x(:,3);
x_e = x(:,4);
y_e = x(:,5);
lambda_1 = x(:,6);
u_p = u(:,1);
sinpsi = lambda_1./sqrt(lambda_1.^2+1);
cospsi = 1./sqrt(lambda_1.^2+1);

dx(:,1) = v_p.*cos(phi);
dx(:,2) = v_p.*sin(phi);
dx(:,3) = u_p;
dx(:,4) = v_e.*cospsi;
dx(:,5) = v_e.*sinpsi;
dx(:,6) = 0;
%------------- END OF CODE --------------