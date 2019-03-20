%%
% The goal of this program is to solve optimization problem using
% Steepest descent and Newton method so far. A self-definied function
% will be allow in this program. 
% Firstly, you need put in how many variables in you function.
% Secondly, The function expression.   Note, x1,x2 needs write as
% x(1),x(2),...
%              e.g:  100*(x(2)-x(1)^2)^2+(1-x(1)^2)
% Then, giving initial point eg: [0,0] and stepsize to the program. 
% Newton, steepest descent applied backtracking to choose a fit stepsize.
% Some errors which will happen when you use this program.
% 1. if you try to use a function which doesn't have minima point, after
%    1000 iteration, it prompts the function can't converge in this time.
% 2. if the initial point is not good, the program will be stoped. The
%    function you put in doesn't have any difinition in the range
%    of the neignborhood, it will prompt some error.
% This program is specially to do with 3-D optimization problem(2 variables).
% Principally, it may have ability to do with more complex mutivariable
% problem, but unfortunately, I can't plot the figure so far.
% producer : Kaifeng Zheng
% Some problems happens in the program please contact me and I can fix it.

clc;
clear;
%%
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
meanValue = (maxValue+minValue)/2;
x100 = minValue-meanValue:meanValue/50:maxValue+meanValue;
x200 = minValue-meanValue:meanValue/50:maxValue+meanValue;
figure(2)
[x1,x2]=meshgrid(x100,x200);
fP = double(subs(f,[x(1),x(2)],{x1,x2}));
contour(x1,x2,fP,100);
hold on
if(METHOD == 1)
    plot3(x_optimized(1,1:end),x_optimized(2,1:end),fS_optimized(1:end),'r*-');
    plot3(x_optimized(1,end),x_optimized(2,end),fS_optimized(end),'o','MarkerFaceColor','green','MarkerSize',6);
    quiver(x_optimized(1,1:end),x_optimized(2,1:end),df(1,2:end),df(2,2:end),'b')
    hold off
    legend('Objective function','The trajectory of optimization','optimization point','The gradient of points');
    xlabel('x1');
    ylabel('x2');
    title('Steepest Descent Optimization(no backtracking) of the First Function');
elseif(METHOD == 2)
    plot3(x_optimized(1,:),x_optimized(2,:),fN_optimized(1:end),'r*-');
    plot3(x_optimized(1,end),x_optimized(2,end),fN_optimized(1,end),'o','MarkerFaceColor','green','MarkerSize',6);
    quiver(x_optimized(1,1:end),x_optimized(2,1:end),df(1,2:end),df(2,2:end),'b')

    hold off
    legend('Objective function','The trajectory of optimization','optimization point','The gradient of points');
    xlabel('x1');
    ylabel('x2');
    title('Steepest Descent Optimization(no backtracking) of the First Function');
end
