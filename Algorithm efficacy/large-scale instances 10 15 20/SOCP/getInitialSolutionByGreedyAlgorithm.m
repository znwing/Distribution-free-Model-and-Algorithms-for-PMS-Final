function [time,x,obj,ComparedMat]=getInitialSolutionByGreedyAlgorithm(m,n,sigma,pi) 
curtime=clock;
%m
%n
%sigma
%pi
x=zeros(m,n);
sum_sigma=zeros(1,m);
d=zeros(1,n);
obj=0;
p=ones(1,m);
ComparedMat=zeros(m,n); %under pi sorting, ComparedMat(k,i) stores the sum of variances in the first i columns of the kth row
%Used for comparing functions in the improve function and after exchange/insert

%[sorted_sigma,pi]=sort(sigma,2); 
% [obj,index]=min(  sqrt(  sort_sigma(1:m,1)  )  );
% x(index,sigma_index(index,1))=1;
% ComparedMat(index,1)=obj;
% sum_sigma(index)=sort_sigma(index,1);
increment=zeros(1,m);
%i_index=zeros(1,m);

while sum(d)~=n
    for k=1:m
        while d(pi(k,p(k)))==1                                         %Check if the p(k)th job on the kth machine has been assigned.
            p(k)=p(k)+1;                                               %p(k) is used to record how many jobs have been assigned to the kth machine. If the p(k)th job has already been assigned, it is necessary to check a job on the kth machine.
        end                                                            %Note that after sorting, each machine actually has n jobs, but the order is different, so the first job on the kth machine is likely to be arranged on another machine.
        increment(1,k)=sum_sigma(k)+sigma(k,pi(k,p(k)));               %we need to directly look at the next one on the kth machine.
    end
    [min_increment,index]=min(increment);                              %min_increment records the minimum value of increment, and index records the column number of the smallest increment, which determines which machine to process on.
    x(index,pi(index,p(index)))=1;                                     %p=ones(1,m), where p(index) is used to record how many jobs have been assigned to the indexth machine, i.e., this job is the p(index)th job on the indexth machine. pi should be of size m*n.
    d(  pi(index,p(index)) )=1;                                        %d=zeros(1,n); pi should be of size m*n. Look at which job is the p(index)th job on the indexth machine, and set it to 1 in d. Later, if other machines need to process the same job, skip it.
    ComparedMat(index,p(index))=min_increment;                         %Record the increment at each step, ComparedMat=zeros(m,n); % In the case of pi sorting, ComparedMat(k,i) stores the sum of variances in the first i columns of the kth row % The sum of variances in the first p(index) columns of the indexth row
    sum_sigma(index)=sum_sigma(index)+sigma(index,pi(index,p(index))); %Record the target value on the indexth machine.
    p(index)=p(index)+1;                                               %The next one should be checked on the indexth machine.
    obj=obj+sqrt(min_increment);                                       %Record the total target value.
end 

time=etime(clock,curtime);
