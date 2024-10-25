function [delta,V]=getdelta(mu,halfsigma,x,xw,c_2,c_1)
delta1=x(1)*c_2;
delta2=-x(2)*c_2;

V1=delta1*(xw-mu+halfsigma*((c_2-delta1)/(c_1+delta1))^0.5);
V2=delta2*(xw-mu+halfsigma*((c_1+delta2)/(c_2-delta2))^0.5);

if V1>V2
    delta=delta1;
    V=V1;
else
    delta=delta2;
    V=V2;
end