
figure(1)
load("Init(0.5,1.5).mat")
plot (xv(:,1),xv(:,2),"r-",'LineWidth',3)
hold on

load("Init(1,1.5).mat")
plot (xv(:,1),xv(:,2),"g:",'LineWidth',3)
hold on

load("Init(1.5,1.5).mat")
plot (xv(:,1),xv(:,2),"b--",'LineWidth',3)
hold on

load("Init(3.5,1.5).mat")
plot (xv(:,1),xv(:,2),"c-.",'LineWidth',3)
hold on

load("Init(5,1.5).mat")
plot (xv(:,1),xv(:,2), "r-",'LineWidth',3)
hold on

x_trans = [1.08794, 1.72306, 2.69168];
y_trans = [1.46095, 1.885, 2.38858];

plot(x_trans,y_trans,'m','LineWidth',2)
legend("(0.5,1.5)","(1,1.5)","(1.5,1.5)","(3.5,1.5)","5,1.5)",'Transition')

% linewidth = 4;
% plot(0.5,1.5,'ro','LineWidth',linewidth)
% plot(1,1.5,'go','LineWidth',linewidth)
% plot(1.5,1.5,'bo','LineWidth',linewidth)
% plot(3.5,1.5,'co','LineWidth',linewidth)
% plot(5,1.5,'ro','LineWidth',linewidth)
xlabel("x")
ylabel('y')




set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on



