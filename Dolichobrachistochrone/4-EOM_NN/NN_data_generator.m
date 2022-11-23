%This program can provide the data for the NN to fit the control 
%equation
clc 
clear
data = [0 0 0];
for lambda_x1 = -5:0.05:5
   for lambda_x2 = -5:0.05:5 
        alpha = atan(lambda_x2./lambda_x1)+pi;
        row = [lambda_x1 lambda_x2 alpha];
        data = [data;row];
   end
end

data(1,:) = [];
input  =  data(:,[1 2]);
output = data(:,3);
save('NN_data_generator')
