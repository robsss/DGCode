
result = zeros(1,5);
for lambda_vp = -5:0.5:5
    disp(lambda_vp);
   for lambda_xp = -5:0.5:5
      for lambda_hp = -5:0.5:5
         for v_p = 0.001:10:1000
          data.lambda_vp = lambda_vp;
          data.lambda_xp = lambda_xp;
          data.lambda_hp = lambda_hp;
          data.v_p = v_p;
          gamma_p0 = -1;
          options = optimoptions('fsolve','Display','none');
          f = @(gamma_p) OptimCondition(gamma_p,data);
          [out,fval] = fsolve(f,gamma_p0,options);
          row = [lambda_vp lambda_xp lambda_hp v_p out];
          result = [result; row];       
         end  
      end
   end    
end
%Remove the first trival row.
result(1,:)=[];
sample = result(:,1:4);
lable = result(:,5);

% Solve an Input-Output Fitting problem with a Neural Network
% Script generated by NFTOOL
%
% This script assumes these variables are defined:
%
%   houseInputs - input data.
%   houseTargets - target data.
 
inputs = sample;
targets = label;
 
% Create a Fitting Network
hiddenLayerSize = 20;
net = fitnet(hiddenLayerSize);

% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
 
% Train the Network
[net,tr] = train(net,inputs,targets);
 
% Test the Network
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);
 
% View the Network
view(net)
 
% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, plotfit(targets,outputs)
% figure, plotregression(targets,outputs)
% figure, ploterrhist(errors)
