syms x1 x2 alpha
x01 = 0;
x02 = 0;
f2 = 100*(x2-x1^2)^2+(1-x1)^2;
[fPoint,dfPoint,Q,df,Qf] = autoDQ(f2,[0;0]);
p = -inv(Q)*dfPoint;
x1 = x01 + alpha*p(1)
x2 = x02 + alpha*p(2)
f2a1 = 100*(x2-x1^2)^2+(1-x1)^2;
dfa=jacobian(f2a1);
for alpha =0:0.001:1
    x1 = x01 + alpha*p(1)
    x2 = x02 + alpha*p(2)
    dfa = [2*x1-400*x1*(-x1^2+x2)-2,-200*x1^2+200*x2];
    f2a = 100*(x2-x1^2)^2+(1-x1)^2;
    fx = 100*(x02-x01^2)^2+(1-x01)^2;
    fline = fx+0.001*alpha*dfPoint'*p;
    if fline>=f2a && dfa*p>= 0.1*dfPoint'*p
        plot(alpha,f2a,'g.-');
        hold on;
    else
        plot(alpha,f2a,'r.-');
        hold on;
    end
end
hold off
title('Exact Line Search for the first iteration');
xlabel("alpha");
ylabel("phi"); 
