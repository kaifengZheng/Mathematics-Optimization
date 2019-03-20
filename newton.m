function [f1,x,n,df,Q,alpha]=newton(f,x0,alpha)
n = 1;
r = 0.5;
c = 1e-4;
df(:,1) = [0;0];
[f1(n),df(:,n+1),Q] = autoDQ(f,x0);
if(abs(norm(df(:,n+1)))<1e-3)
    x = x0;
end
%using the difference of gradients between two iteration to stop the
%loop
while abs(norm(df(:,n+1))-norm(df(:,n)))>=1e-3
    x(:,n) = x0;
    %newton method
    p = -inv(Q)*df(:,n+1);
    %updating the X
    x(:,n+1) = x(:,n)+alpha*p;
    %update f1,df,Q
    x0 = x(:,n+1);
    [f1(n+1),df(:,n+2),Q] = autoDQ(f,x0);
    df(:,n+2)
     %backtracking
    while f1(n+1)>f1(n)+c*alpha*df(:,n+1)'*p
        alpha = r*alpha
        x(:,n+1) = x(:,n)+alpha*p;
        x0 = x(:,n+1);
        [f1(n+1),df(:,n+2),Q] = autoDQ(f,x0);
        if alpha == 0 || n == 1000||(norm(df(:,n+1))==norm(df(:,n+2))&&norm(df(:,n+1))~=0)
           break;
        end
    end
      if alpha == 0 || n == 1000 || (norm(df(:,n+1))==norm(df(:,n+2))&&norm(df(:,n+1))~=0)
       fprintf("This function can't converge in this situation");
       break;
     end
    %counting times in loop
    n = n+1;
end
end