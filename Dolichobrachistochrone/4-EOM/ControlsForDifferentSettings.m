
figure(1)
text = [''];
linesty = ["r-", "g:", "b--", "c-.", "o-"];
for s = 1:3:12
    
    [problem,guess]=Dolichobrachistochrone;          % Fetch the problem definition
    options = problem.settings(s,5);          % Get options and solver settings 
    [solution,MRHistory]=solveMyProblem( problem,guess,options);
    [ tv, xv, uv ] = simulateSolution( problem, solution, 'ode113', 0.1 );
    
    plot (tv, uv,linesty((s-1)/3 + 1),'LineWidth',3)
    hold on 
  
    text = [text;sprintf('%2d segments',s)];
    
end


ylabel('Controls')
xlabel('t')
legend(text)
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1);
set(gca,'Fontname','Monospaced','FontSize',15);
grid on
xlim([2.5,3])