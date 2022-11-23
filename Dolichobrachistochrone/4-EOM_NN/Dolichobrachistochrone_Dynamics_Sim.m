
function [dx] = Dolichobrachistochrone_Dynamics_Sim(x,u,p,t,vdat)
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

x_1 = x(:,1);x_2 = x(:,2);lambda_x1 = x(:,3);lambda_x2 = x(:,4);
beta = u(:,1);
% sinalph = -lambda_x2./sqrt(lambda_x1.^2+lambda_x2.^2);
% cosalph = -lambda_x1./sqrt(lambda_x1.^2+lambda_x2.^2);

% alpha = atan(lambda_x2./lambda_x1)+pi;


load('NN_data_generator');

alpha = net([lambda_x1';lambda_x2'])';
sinalph = sin(alpha);
cosalph = cos(alpha);


dx(:,1) = sqrt(x_2) .* cosalph + (beta + 1)./2;
dx(:,2) = sqrt(x_2) .* sinalph + (beta - 1)./2;
dx(:,3) = 0;
dx(:,4) = -(lambda_x1.*cosalph+lambda_x2.*sinalph)./(2.*sqrt(x_2));
%------------- END OF CODE --------------