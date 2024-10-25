function [S,S_]=solveByRHA_2(i,j,S,T,R,array,sigma_,pi_,n)
%The incoming i and j represent the two machines to be allocated
%T=x(j,:)+x(i,:);  It represents the jobs allocated on the i and j machines.
%R=T;              How many jobs have not been reallocated at the beginning
%array=T;
%sigma_=sigma([j,i],:); 
%pi_=pi([j,i],:);
% S=zeros(1,n);

while sum(R)~=0
    u=zeros(2,n);
    f_S=getf(S,array-S,n,sigma_,pi_);  %S records which jobs are allocated to i, initially set as a 0 vector representing an empty set, and adopts a filling approach.
    f_T=getf(T,array-T,n,sigma_,pi_);  %T also records which jobs are allocated to the first machine, initially set as the set of all jobs, and adopts an exclusion approach.
    for k=1:n
        if R(k)==0
            continue
        end
        S_=S;
        S_(k)=1;
        u(1,k)=getf(S_,array-S_,n,sigma_,pi_)-f_S;   %a_k
        T_=T;
        T_(k)=0;
        u(2,k)=f_T-getf(T_,array-T_,n,sigma_,pi_);   %b_k
        if u(1,k)>=0                                 %a_k>0£¬Job k is not allocated to machine i.
            T=T_;                                    %T_(k)=0;
            R(k)=0;
            f_T=getf(T,array-T,n,sigma_,pi_);
        end
        if u(2,k)<=0                                 %b_k<0£¬Job k is allocated to machine i.
            S=S_;                                    %S_(k)=1;
            R(k)=0;
            f_S=getf(S,array-S,n,sigma_,pi_);
        end
        length_R=sum(R);
        if sum(u(1,:).*R<0)==length_R&&sum(u(2,:).*R>0)==length_R
            break
        end
    end
    if sum(R)==0
        break
    end
    %job_index3=job_index3+1;
    [max1,index1]=max(-u(1,:).*R);        %Find the a_k with the largest absolute value and its corresponding k in R, which represents the unallocated jobs.
    [max2,index2]=max(u(2,:).*R);         %Find the b_k with the largest value and its corresponding k in R, which represents the unallocated jobs.
    b=max1+max2;
    a=b*rand(1,1);
    if a <= max1  
        S(index1)=1;                     
        R(index1)=0;
    else
        T(index2)=0;
        R(index2)=0;
    end
end

S_=array-S;                              %SS_ is not allocated to i, which means it is allocated to j.

