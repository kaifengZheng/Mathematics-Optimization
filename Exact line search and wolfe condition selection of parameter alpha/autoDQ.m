%%
%This function is used to caculate the gradients and Hessian matrix
%%
%This function is used to caculate the gradients and Hessian matrix
%based on a known point. 
%@param fun: a symbolic function
%       you need first use:     
%                           x=[x1,x2,...]
%                           fun =x1+x2+......
%       before you utilize this function.
%@param valueList: coordinate of a point, we will use this point further to 
%       caculate the gradient vector and the Hessian matrix.
%@return fPoint:  the function value on the point.  
%@return dfPoint: the gradient vector on the point.
%@return QPoint:  the Hessian matrix on the point.
%producer: Kaifeng Zheng

function [fPoint,dfPoint,QPoint,df,Q] = autoDQ(fun,valueList)
n = length(valueList);
x = sym('x',[n,1]);
fsyms = fun;
df = jacobian(fsyms);
Q = jacobian(df);
fPoint = double(subs(fsyms,x,valueList));
dfPoint = double(subs(df,x,valueList));
dfPoint = dfPoint';
QPoint = double(subs(Q,x,valueList));
end



