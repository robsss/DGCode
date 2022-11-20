function res = HC_bc(ya,yb,alpha)
        
        global x10 phi10 x20 v1 v2 u1max l  t_p x1_p x2_p...
                  phi1_p y1_p y2_p thresh
        
        p3T = yb(8);
        u1T = -p3T;
        if u1T > thresh
            u1T = u1max;
        elseif u1T < -thresh
            u1T = -u1max;
        end
        cosu2= 1/sqrt(1+(yb(10)/yb(9))^2);
        sinu2= (yb(10)/yb(9))/sqrt(1+(yb(10)/yb(9))^2);
        res =  [ya(1)-x10(1);ya(2)-x10(2);
            ya(3)-phi10;
            ya(4)-x20(1);ya(5)-x20(2);
            norm(yb(1:2)-yb(4:5))-l;
            yb(6) - alpha*(yb(1)-yb(4))/norm(yb(1:2)-yb(4:5));
            yb(7) - alpha*(yb(2)-yb(5))/norm(yb(1:2)-yb(4:5));
            yb(8) - 0;
            yb(9) - alpha*(yb(4)-yb(1))/norm(yb(1:2)-yb(4:5));
            yb(10)- alpha*(yb(5)-yb(2))/norm(yb(1:2)-yb(4:5));
            yb(6)*v1*cos(yb(3))+yb(7)*v1*sin(yb(3))+yb(8)*u1T+...
            yb(9)*v2*cosu2+yb(10)*v2*sinu2+1];
end