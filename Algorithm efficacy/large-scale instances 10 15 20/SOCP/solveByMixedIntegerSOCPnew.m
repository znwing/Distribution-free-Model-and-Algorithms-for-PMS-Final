function [time,xval,yval,zval,objval,obj_bound,modeltime,solvetime,gap]=solveByMixedIntegerSOCPnew(m,n,halfsigma,pi,optionsgurobi,constraint,x,y,z,objective,sigma)
%[time_GA,x_GA,obj_GA,~]=getInitialSolutionByGreedyAlgorithm(m,n,sigma,pi); 
%disp(['GA obj=',num2str(obj_GA)]);

curtime=clock;
for k=1:m
    for i=1:n
        constraint=[constraint,cone(diag(halfsigma(k,pi(k,1:i)))*z(pi(k,i),pi(k,1:i),k)',y(k,pi(k,i)))];
    end
end

%****** 2. 
%assign(x,x_GA);
assign(x,sigma);
%if double(x)==double(x_GA)
if double(x)==double(sigma)
    disp('allocated');
else
    disp('not allocated');
end

modeltime=etime(clock,curtime);
%saveampl(constraint,objective,'socpmodel.mod') %save model
curtime=clock;
sol = solvesdp(constraint,objective,optionsgurobi);
if sol.problem~=0
    disp(['there is a problem with solving SOCP'])
    sol
end

solvetime=etime(clock,curtime);
time=modeltime+solvetime;
obj_bound=double(sol.solveroutput.result.objbound);
gap=double(sol.solveroutput.result.mipgap);
xval=double(x);
yval=double(y);
zval=double(z);
objval=double(objective);
