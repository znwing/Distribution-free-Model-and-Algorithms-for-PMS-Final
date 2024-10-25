function [mu,sigma,halfsigma]=getSigma(m,n,lb,ub,l_para,u_para)

mu=unifrnd(lb,ub,m,n);%%Generate a uniformly distributed random sample within the range of 10-100, with a dimension of m*n.
low_mu=l_para*mu;
up_mu=u_para*mu;
sigma=unifrnd(low_mu,up_mu).^2;
halfsigma=sqrt(sigma);%Standard deviation, used to generate a matrix.