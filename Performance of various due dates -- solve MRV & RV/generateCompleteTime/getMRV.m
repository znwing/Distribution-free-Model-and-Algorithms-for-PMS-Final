function [MRV]=getMRV(c_2,x,x_w,mu,sigma,gamma)
theta=(x-mu)/sigma;
if x>x_w
    [xtheta,maxg1]=solvex(theta,gamma);        %solvex is designed to calculate the MRV when x > x_w^*.
    MRV=c_2*sigma*maxg1;
%     disp(['w=0Ê±£¬x_w=',num2str(x),'£¬MRV=',num2str(MRV)]);
elseif x<=x_w
    [ytheta,maxg2]=solvey(theta,gamma);        %solvey is designed to calculate the MRV when x<x_w^*
    MRV=c_2*sigma*maxg2;
end