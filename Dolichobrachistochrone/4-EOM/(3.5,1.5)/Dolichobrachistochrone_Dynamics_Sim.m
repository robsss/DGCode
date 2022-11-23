
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
x_1 = x(:,1);
y = x(:,2);

lambda_x = x(:,3);
lambda_y = x(:,4);

beta = u(:,1);

sinalph = -lambda_y./sqrt(lambda_x.^2+lambda_y.^2);
cosalph = -lambda_x./sqrt(lambda_x.^2+lambda_y.^2);

dx(:,1) = sqrt(y) .* cosalph + (beta + 1)./2;
dx(:,2) = sqrt(y) .* sinalph + (beta - 1)./2;

dx(:,3) = 0;
dx(:,4) = -(lambda_x.*cosalph+lambda_y.*sinalph)./(2.*sqrt(y));

%------------- END OF CODE --------------