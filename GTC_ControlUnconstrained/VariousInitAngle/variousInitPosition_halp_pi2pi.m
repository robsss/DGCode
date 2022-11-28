
clear all;close all;format compact;
init_psi_e_s = [2/3*pi 3/4*pi 5/6*pi];
global init_psi_e;
figure(1)
linestys = ["r-","b:","g--","m-","c:","k--","y:"];
for i=1:3
    global init_psi_e;
    init_psi_e = init_psi_e_s(i);
%     disp(ini_psi_e)
%     pause(2);
    [problem,guess]=TwoDPE_GTCCU;          % Fetch the problem definition
    options= problem.settings(5,20);          % Get options and solver settings 
    [solution,MRHistory]=solveMyProblem( problem,guess,options);
    [ tv, xv, uv ] = simulateSolution( problem, solution, 'ode113', 0.01 );

    linesty = linestys(i);
    LineWidth = 3;
    plot(xv(:,1),xv(:,2),linesty,'LineWidth',LineWidth)
    hold on 
    plot(xv(:,4),xv(:,5),linesty,'LineWidth',LineWidth,'HandleVisibility','off')
    hold on
end


ylabel('y')
xlabel('x')
legend("\psi_{e0}=2/3\pi","\psi_{e0}=3/4\pi","\psi_{e0}=5/6\pi")
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on
