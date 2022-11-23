function F = OptimCondition(gamma_p,data)

lambda_vp = data.lambda_vp;
lambda_xp = data.lambda_xp;
lambda_hp = data.lambda_hp;
v_p = data.v_p;
k = 0.1676;
m = 1;
S = 1.875e-5;
g = 8.04350e-1;
rho = 1.7634e5;
F = lambda_vp*(2*k*m*g^2*sin(2*gamma_p)/rho/v_p^2/S-g*cos(gamma_p))-...
    lambda_xp*v_p*sin(gamma_p)+lambda_hp*v_p*cos(gamma_p);



end