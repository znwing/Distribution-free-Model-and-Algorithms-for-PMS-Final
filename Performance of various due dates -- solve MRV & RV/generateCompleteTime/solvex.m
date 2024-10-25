function [xtheta,maxg1]=solvex(theta,a)
f = @(x)4*theta^2*(1-x)*(a+x)^3-(2*a-3*a*x+x-2*x^2)^2;    %Create a function handle. The variables in the handle are not symbolic variables and do not need to be defined!
syms x exp1;    % define variables x, exp1£»
exp1 = 4*theta^2*(1-x)*(a+x)^3-(2*a-3*a*x+x-2*x^2)^2;    % Symbolic expression, containing symbolic variables. Symbolic variables must be defined in a previous line!
solx=solve(exp1 == 0, x);    %Enter a command line input a, passing in an equation containing a symbolic expression, where x is the variable being solved for
xtheta=zeros(1,4);
g1=zeros(1,4);
for i=1:4
    if (0<=double(solx(i))) && (double(solx(i))<1)
        xtheta(i)=double(solx(i));
        g1(i)=xtheta(i)*(theta+((1-xtheta(i))/(a+xtheta(i)))^0.5);
    end
end
maxg1=max(g1);
end