C_L = 0:0.01:01.3;
C_D = 0.0165 + 0.1676*C_L .^2;

figure(1)
plot(C_L, C_D,'Linewidth',3)
xlabel('C_L')
ylabel('C_D')
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on