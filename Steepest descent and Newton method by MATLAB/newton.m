function [f1,x,n,df,Q,alpha]=newton(f,x0,alpha)
n = 0;
r = 0.5;
c = 1e-4;
[f1(n+1),df(:,n+1),Q] = autoDQ(f,x0);
if(abs(norm(df(:,n+1)))<=1e-5)
    x = x0;
end
while abs(norm(df(:,n+1)))>=1
    x(:,n+1) = x0;
    %newton method
    p = -inv(Q)*df(:,n+1);
    %updating the X
    x(:,n+2) = x(:,n+1)+alpha*p;
    %update f1,df,Q
    x0 = x(:,n+2);
    [f1(n+2),df(:,n+2),Q] = autoDQ(f,x0);
    df(:,n+2)
     %backtracking
    while f1(n+2)>f1(n+1)+c*alpha*df(:,n+1)'*p
        alpha = r*alpha
        x(:,n+2) = x(:,n+1)+alpha*p;
        x0 = x(:,n+2);
        [f1(n+2),df(:,n+2),Q] = autoDQ(f,x0);
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