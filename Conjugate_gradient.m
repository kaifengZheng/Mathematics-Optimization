clc;
clear;
x0(:,1) = [0,0]';
%% using quadrative approximation to transfer the original
%% equation to a standard quadrative function.
syms x1 x2 alpha
f = 2*x1^2+2*x1*x2+x2^2+x1-x2;
H = double(jacobian(gradient(f,[x1,x2])));
r = gradient(f,[x1,x2]);
b = -r + H*[x1;x2];
fQ = (1/2)*[x1,x2]*H*[x1;x2]-b'*[x1;x2];
r(:,1)= H*x0(:,1)-b;
p(:,1)=-r(:,1);

for i=1:10
    if (r ~= 0) | (p ~= 0)
        alpha(i) = (r(:,i)'*r(:,i))/(p(:,i)'*H*p(:,i));
        x0(:,i+1) = x0(:,i)+alpha(i)*p(:,i)
        r(:,i+1) = r(:,i)+alpha(i)*H*p(:,i);
        beta = r(:,i+1)'*r(:,i+1)/(r(:,i)'*r(:,i));
        p(:,i+1) = -r(:,i+1)+beta*p(:,i);
    else
      break;
    end
end

x1_p = -2:0.1:2;
x2_p = -2:0.1:2;
f_final = subs(fQ,[x1,x2],[x0(1,end),x0(2,end)])
[x1_p,x2_p]=meshgrid(x1_p,x2_p);
f_p = 2*x1_p.^2+2.*x1_p.*x2_p+x2_p.^2+x1_p-x2_p;
contour(x1_p,x2_p,f_p,100);
hold on;
plot(x0(1,1:end),x0(2,1:end),'r*-')
quiver(x0(1,1:end),x0(2,1:end),r(1,1:end),r(2,1:end),'b')

hold off



%%
