clc;
clear;
n = input('Please tell the program how many variables of this function: ');
x=sym('x',[n,1]);
f = input('Please input the function you want to optimize with variable x(1),x(2),....: ');
x0 = input('Please put the point coordinate which you prefer to start: ');
x0 = x0';
prompt = ['Please choose one method you want use' ...
    ' 1 == Steepest Descent 2 == Newton Method: '];
a = input('How large the stepsize you would like to use: ');
METHOD = input(prompt);
if(METHOD==1)
    [fS_optimized,x_optimized,n,df,Q,alpha] = steepest(f,x0,a);
elseif(METHOD==2)
    [fN_optimized,x_optimized,n,df,Q,alpha] = newton(f,x0,a);
end

%PLOT
minValue = min(min(x_optimized));
maxValue = max(max(x_optimized));
x100 = minValue-0.5:((maxValue-minValue+0.5)/100):maxValue+0.5;
x200 = minValue-0.5:((maxValue-minValue+0.5)/100):maxValue+0.5;
figure(2)
[x1,x2]=meshgrid(x100,x200);

fP = double(subs(f,[x(1),x(2)],{x1,x2}));


contour(x1,x2,fP,100);
hold on
if(METHOD == 1)
    plot3(x_optimized(1,1:end),x_optimized(2,1:end),fS_optimized(1:end),'r*-');
    plot3(x_optimized(1,end),x_optimized(2,end),fS_optimized(end),'o','MarkerFaceColor','green','MarkerSize',6);
    quiver(x_optimized(1,1:end),x_optimized(2,1:end),df(1,:),df(2,:),'b')
    hold off
    legend('Objective function','The trajectory of optimization','optimization point','The gradient of points');
    xlabel('x1');
    ylabel('x2');
    title('Steepest Descent Optimization(no backtracking) of the First Function');
elseif(METHOD == 2)
    plot3(x_optimized(1,:),x_optimized(2,:),fN_optimized(1:end),'r*-');
    plot3(x_optimized(1,end),x_optimized(2,end),fN_optimized(1,end),'o','MarkerFaceColor','green','MarkerSize',6);
    quiver(x_optimized(1,1:end),x_optimized(2,1:end),df(1,:),df(2,:),'b')

    hold off
    legend('Objective function','The trajectory of optimization','optimization point','The gradient of points');
    xlabel('x1');
    ylabel('x2');
    title('Steepest Descent Optimization(no backtracking) of the First Function');
end
