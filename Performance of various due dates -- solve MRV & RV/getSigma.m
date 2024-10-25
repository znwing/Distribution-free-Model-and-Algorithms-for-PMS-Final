function [mu,sigma,halfsigma]=getSigma(m,n,lb,ub,l_para,u_para)

%generate a uniform distribution in the range of 10 to 100 for an m-by-n dimensional matrix.
mu=unifrnd(lb,ub,m,n);
low_mu=l_para*mu;
up_mu=u_para*mu;
sigma=unifrnd(low_mu,up_mu).^2;
halfsigma=sqrt(sigma);%standard deviation, used to generate a matrix