filename=strcat('mu10_100sigma0.1_0.25_m1n100.mat');
load(filename);
c_2=10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
normal_t=zeros(10^4,100);
gamma_t=zeros(10^4,100);
pareto_t=zeros(10^4,100);
shuangfeng_t=zeros(10^4,100);
q1_delta=zeros(9,100);
q2_delta=zeros(9,100);
p=zeros(9,100);
q=zeros(9,100);

for i=1:100
    disp(['第',num2str(i),'个工件']);
    mu_i=mu(i);
    sigma_i=sigma(i);
    halfsigma_i=halfsigma(i);
    a3=mu_i^2/halfsigma_i^2;
    b3=mu_i/halfsigma_i^2; 
    syms xmin k      
    eq1 = xmin*k/(k-1)-mu_i;
    eq2 = xmin*(k/(k-2))^0.5/(k-1)-halfsigma_i;
    A = solve(eq1,eq2,xmin,k) ;
    xmin=double(A.xmin);
    k=double(A.k);
  
    
    index=1;
    for gamma=[1/10,1/9,1/8,1/7,1/6,1/5,1/4,1/3,1/2,1,2,3,4,5,6,7,8,9,10]
        [x,fval]=solveg(gamma);
        [w,xw,c_1,min_MRV]=getxw(mu_i,halfsigma_i,c_2,gamma,x,fval);
        [delta,V]=getdelta(mu_i,halfsigma_i,x,xw,c_2,c_1); %"V" represents the MRV corresponding to a two-point distribution.
        q1_delta(index,i)=mu_i-halfsigma_i*((c_2-delta)/(c_1+delta))^0.5;
        q2_delta(index,i)=mu_i+halfsigma_i*((c_1+delta)/(c_2-delta))^0.5;
        p(index,i)=(c_1+delta)/(c_1+c_2);
        q(index,i)=1-p(index,i);
        [MRV]=getMRV(c_2,xw,xw,mu_i,halfsigma_i,gamma);
        index=index+1;
    end
    mu1_i=q1_delta(index-1,i);
    halfsigma1_i=0.175*q1_delta(index-1,i);
    mu2_i=q2_delta(index-1);
    halfsigma2_i=0.175*q1_delta(index-1,i);
    pp=p(index-1,i);
    
    %Generate random processing times following normal distribution, uniform distribution, Pareto distribution, and bimodal distribution, with 10^4 instances for each distribution.
    D1=normrnd(mu_i,halfsigma_i,[10^4,1]); %normal distrbution
    D2=gamrnd(a3,1/b3,10^4,1); %gamma distrbution
    D3=gprnd(1/k,xmin/k,xmin,10^4,1);%pareto distrbution
    D4=zeros(10^4,1);
    for j=1:10^4
        k=rand(1);
        if k<=pp
            D4(j)=normrnd(mu1_i,halfsigma1_i,1,1);
        else
            D4(j)=normrnd(mu2_i,halfsigma2_i,1,1);
        end
    end
    
    normal_t(:,i)=D1;
    gamma_t(:,i)=D2;
    pareto_t(:,i)=D3;
    shuangfeng_t(:,i)=D4;
    
    meanx=mean(shuangfeng_t(:,i));
    halfsigmax=std(shuangfeng_t(:,i));
    Y=(shuangfeng_t(:,i)-meanx)/halfsigmax;
    shuangfeng_t(:,i)=mu_i+Y*halfsigma_i;
    
    
end

%the times are not sorted
filename=strcat('normal_t.mat');
save(filename,'normal_t');
filename=strcat('gamma_t.mat');
save(filename,'gamma_t');
filename=strcat('pareto_t.mat');
save(filename,'pareto_t');
filename=strcat('shuangfeng_t.mat');
save(filename,'shuangfeng_t');


