function [x,obj,ComparedMat]=ifupdateX(i,j,x,S,S_,ComparedMat,sigma,pi,obj,array,n)
x1=x; %temporarily store the newly found solution using x1, and subsequently determine whether to update it.
x1(j,:)=S;
x1(i,:)=S_;
temp_machine=sum(sqrt(ComparedMat([i,j],:)),2);
[sum1,temp_ComparedMat]=getf(S,array-S,n,sigma([j,i],:),pi([j,i],:));% calculate the target value sum1 for the newly found solution
if sum(temp_machine)-sum1>10^(-6)  %if the obj value sum1 of the newly found solution is smaller, then update the solution
    obj=obj+sum1-sum(temp_machine);
    x=x1;
    ComparedMat(j,:)=temp_ComparedMat(1,:);
    ComparedMat(i,:)=temp_ComparedMat(2,:);
end