clc 
clear all
lambda_x1 = [0.5 1 1 1]';
lambda_x2 = [1   2 1 2]';

for i = 1:length(lambda_x1)
options = optimoptions('fsolve','Display','none');
F = @(alpha) -lambda_x1(i)*sin(alpha)+lambda_x2(i)*cos(alpha);
x0 = 2;
[alpha] = fsolve(F,x0,options);
result(i) = alpha;

end

disp(size(result))

result_1 = atan(lambda_x2./lambda_x1);