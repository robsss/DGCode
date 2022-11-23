
for lambda_vp = -5:0.5:5
   for lambda_xp = -5:0.5:5
      for lambda_hp = -5:0.5:5
         for v_p = -10000:100:10000
             
            k = 0.1676;
            m = 1;
            S = 1.875e-5;
            g = 8.04350e-1;
            rho = 1.7634e5;
            syms gamma_p
            eqn =  lambda_vp*(2*k*m*g^2*sin(2*gamma_p)/rho/v_p^2/S-g*cos(gamma_p))-...
                     lambda_xp*v_p*sin(gamma_p)+lambda_hp*v_p*cos(gamma_p) == 0;
            var = gamma_p;
            sol = solve(eqn,var);
              
         end  
      end
   end    
 end

