clc;
clear
syms k1 k2;
x = [1,2,3,4]';
y = [1.05,1.25,1.55,1.59]';
for i = 1:4
y_p(i) = k1*x(i)/(1+k2*x(i));
end
r = y_p'-y;
f = 1/2*sum(r.^2);
J = jacobian(r,[k1,k2]);
%% 
k11_GN(1) = 1; 
k22_GN(1) = 1;
rr(:,1) = double(subs(r,[k1,k2],[k11_GN(1),k22_GN(1)]));
J_k1k2 = double(subs(J,[k1,k2],[k11_GN(1),k22_GN(1)]));
ff_GN(1) = double(subs(f,[k1,k2],[k11_GN(1),k22_GN(1)]));
i = 1;
%% GN
while 1
    p_GN(:,i) = -inv(J_k1k2'*J_k1k2)'*J_k1k2'*rr(:,i);
    %p_LM(:,i) = -inv(J_k1k2'*J_k1k2+eye(2))'*J_k1k2'*rr(:,i);
    k11_GN(i+1) = k11_GN(i) + p_GN(1,i);
    k22_GN(i+1) = k22_GN(i) + p_GN(2,i);
    i = i+1;
    rr(:,i) = double(subs(r,[k1,k2],[k11_GN(i),k22_GN(i)]));
    J_k1k2 = double(subs(J,[k1,k2],[k11_GN(i),k22_GN(i)]));
    ff_GN(i) = double(subs(f,[k1,k2],[k11_GN(i),k22_GN(i)]));
    if(i == 10)
        break;
    end
    
end

%% LM
% initialization
i = 1;
k11_LM(1) = 1; 
k22_LM(1) = 1;
rr(:,1) = double(subs(r,[k1,k2],[k11_LM(1),k22_LM(1)]));
J_k1k2 = double(subs(J,[k1,k2],[k11_LM(1),k22_LM(1)]));
ff_LM(1) = double(subs(f,[k1,k2],[k11_LM(1),k22_LM(1)]));
while 1
    %p_GN(:,i) = -inv(J_k1k2'*J_k1k2)'*J_k1k2'*rr(:,i);
    p_LM(:,i) = -inv(J_k1k2'*J_k1k2+eye(2))'*J_k1k2'*rr(:,i);
    k11_LM(i+1) = k11_LM(i) + p_LM(1,i);
    k22_LM(i+1) = k22_LM(i) + p_LM(2,i);
    i = i+1;
    rr(:,i) = double(subs(r,[k1,k2],[k11_LM(i),k22_LM(i)]));
    J_k1k2 = double(subs(J,[k1,k2],[k11_LM(i),k22_LM(i)]));
    ff_LM(i) = double(subs(f,[k1,k2],[k11_LM(i),k22_LM(i)]));
    if(i == 10)
        break;
    end
    
end
ff_GN
ff_LM
n = length(ff_GN);
m = length(ff_LM);
figure(1)
subplot(1,2,1)
plot(1:1:n,ff_GN,'r*-');
legend('Gauss-Newton');
xlabel('iteration numbers','FontWeight','bold');
ylabel('Objective function of least squared ','FontWeight','bold')
subplot(1,2,2)
plot(1:1:m,ff_LM,'g*-');
xlabel('iteration numbers','FontWeight','bold');
ylabel('Objective function of least squared ','FontWeight','bold')
legend('LM');
%%
k1GN_initial = k11_GN(1);
k2GN_initial = k22_GN(1);
k1GN_final = k11_GN(end);
k2GN_final = k22_GN(end);
k1LM_initial = k11_LM(1);
k2LM_initial = k22_LM(1);
k1LM_final = k11_LM(end);
k2LM_final = k22_LM(end);
syms x_p
y_pp = k1*x_p/(1+k2*x_p);
initial_GN = subs(y_pp,[k1,k2],[k1GN_initial,k2GN_initial]);
final_GN = subs(y_pp,[k1,k2],[k1GN_final,k2GN_final]);
initial_LM = subs(y_pp,[k1,k2],[k1LM_initial,k2LM_initial]);
final_LM = subs(y_pp,[k1,k2],[k1LM_final,k2LM_final]);
figure(2)
subplot(1,2,1)
plot(x,y,'.','MarkerSize',12,'color','m')
hold on
fplot(x_p,initial_GN,'g');
fplot(x_p,final_GN,'r');
ylim([0,2]);
xlim([1 4]);
legend('obversion data','The initial fitting function',...
       'fitting after using Gauss Newton');
xlabel('x','FontWeight','bold');
ylabel('y','FontWeight','bold');
title('Fitting using Gauss Newton');
hold off;

subplot(1,2,2)
plot(x,y,'.','MarkerSize',12,'color','m')
hold on
fplot(x_p,initial_LM,'g');
fplot(x_p,final_LM,'r');
ylim([0,2]);
xlim([1 4]);
legend('obversion data','The initial fitting function', ...
       'fitting after using Levenberg-Marquardt');
xlabel('x','FontWeight','bold');
ylabel('y','FontWeight','bold');
title('Fitting using Levenberg-Marquardt with lambda = 1',...
      'FontWeight','bold');

  
  %%