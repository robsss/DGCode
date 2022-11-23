
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

result(1,:)=[];
sample = result(:,1:4);
lable = result(:,5);


