function dydt = HC_ode(t,y,alpha)
        
         global x10 phi10 x20 v1 v2 u1max l  t_p x1_p x2_p...
                  phi1_p y1_p y2_p thresh
        
        % States
        x1   = y(1);    x2  = y(4);
        y1   = y(2 );   y2  = y(5);
        phi1 = y(3);
        %Costates
        p1 = y(6);  p4 = y(9);
        p2 = y(7);  p5 = y(10);
        p3 = y(8);
        % Final Time
        T  = y(11);
        
        u1 = -p3; 
        if u1 > thresh
            u1 = u1max;
        elseif u1 < -thresh
            u1 = -u1max;
        end
        cosu2  = 1/sqrt(1+(p5/p4)^2);
        sinu2  = (p5/p4)/sqrt(1+(p5/p4)^2);
        x1_d   = v1*cos(phi1);
        y1_d   = v1*sin(phi1);
        phi1_d = u1;
        x2_d   = v2*cosu2;
        y2_d   = v2*sinu2;
        p1_d   = 0;
        p2_d   = 0;
        p3_d   = p1*v1*sin(phi1) - p2*v1*cos(phi1);
        p4_d   = 0;
        p5_d   = 0;
        dt     = 0;
        dydt = T*[x1_d; y1_d; phi1_d; x2_d; y2_d; ...
            p1_d; p2_d; p3_d; p4_d; p5_d; dt];
end

