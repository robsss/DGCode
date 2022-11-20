function v= HC_init(tau)
        global x10 phi10 x20 v1 v2 u1max l  t_p x1_p x2_p...
                  phi1_p y1_p y2_p thresh
        
        u2g= 45*pi/180;
        phi_Tg= u2g;
        
        Tg= 2.3;
        if phi1_p < phi_Tg
            p3 = -1;
        else
            p3 = 0;
        end
        ul = -p3;
        phi1_d = ul;
        t      = tau*Tg;
        dt     = t - t_p;
        phi1   = phi1_p + dt*phi1_d;
        p1 = -1;
        p2 = 2*p1;
        p4 = -p1;
        p5 = -p2;
        cosu2   = 1/sqrt(l+(p5/p4)^2);
        sinu2   = (p5/p4)/sqrt(l+(p5/p4)^2);
        x1_d    = v1*cos(phi1);
        y1_d    = v1*sin(phi1);
        x2_d    = v2*cosu2;
        y2_d    = v2*sinu2;
        x1      = x1_p + dt*x1_d;
        y1      = y1_p + dt*y1_d;
        x2      = x2_p + dt*x2_d;
        y2      = y2_p + dt*y2_d;
        v = [x1;y1;phi1;x2;y2;p1;p2;p3;p4;p5;Tg];
        phi1_p = phi1;
        x1_p   = x1;
        y1_p   = y1;
        x2_p   = x2;
        y2_p   = y2;
        t_p    = t;
 end