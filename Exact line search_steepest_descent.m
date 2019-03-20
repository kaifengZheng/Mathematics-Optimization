clc;
clear;
x1 = -3:0.1:3;
x2 = -3:0.1:3;
[x1,x2]=meshgrid(x1,x2);
f = 2*x1.^2+2.*x1.*x2+x2.^2+x1-x2;
contour(x1,x2,f);
hold on;
%%
%% Steepest Descent with exact line search

%% Calculate the best step size using exact line search
syms x1 x2 alpha
f = 2*x1^2+2*x1*x2+x2^2+x1-x2;
g1 = gradient(f,x1);
g2 = gradient(f,x2);
H = jacobian(gradient(f,[x1,x2]));
x12 = x1-alpha*g1;
x22 = x2-alpha*g2;
phi = subs(f,[x1,x2],[x12,x22]);
phi_g = gradient(phi,alpha);
alpha_best=solve(phi_g==0,alpha);
%% steepest descent
x1_vall(1) = 0;
x2_vall(1) = 0;
obj_vall(1) = subs(f,[x1,x2],[x1_vall(1),x2_vall(1)]);
for n = 1:1:4
    g1_0(n) = subs(g1,[x1,x2],[x1_vall(n),x2_vall(n)]);
    g2_0(n) = subs(g2,[x1,x2],[x1_vall(n),x2_vall(n)]); 
    alpha_0(n) = subs(alpha_best,[x1,x2],[x1_vall(n),x2_vall(n)]);
    x1_vall(n+1) = x1_vall(n) - alpha_0(n)*g1_0(n);
    x2_vall(n+1) = x2_vall(n) - alpha_0(n)*g2_0(n);
    obj_vall(n+1)=subs(f,[x1,x2],[x1_vall(n+1),x2_vall(n+1)]);

end
gg = double([g1_0;g2_0]);
obj_vall=double(obj_vall);
plot(x1_vall,x2_vall,'r*-')


%%

