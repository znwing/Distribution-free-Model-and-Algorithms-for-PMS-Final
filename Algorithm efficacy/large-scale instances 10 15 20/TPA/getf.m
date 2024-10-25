function [sum,ComparedMat]=getf(S,S_,n,sigma,pi)
sigma1=S.*sigma(1,:);
sigma2=S_.*sigma(2,:);
sort_sigma1=sigma1(pi(1,:));
sort_sigma2=sigma2(pi(2,:));
ComparedMat=zeros(2,n);
sum=0;

sum_sigma=0;
index=0;
for i=sort_sigma1
    index=index+1;
    if i==0
        continue
    end
    sum_sigma=sum_sigma+i;
    ComparedMat(1,index)=sum_sigma;
    sum=sum+sqrt(sum_sigma);
end

sum_sigma=0;
index=0;
for i=sort_sigma2
    index=index+1;
    if i==0
        continue
    end
    sum_sigma=sum_sigma+i;
    ComparedMat(2,index)=sum_sigma;
    sum=sum+sqrt(sum_sigma);
end
