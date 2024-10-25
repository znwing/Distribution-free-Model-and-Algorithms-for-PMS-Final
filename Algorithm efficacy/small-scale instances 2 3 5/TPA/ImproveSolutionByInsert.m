%Improve the solution through an insertion search
function [flag,time,x,obj,ComparedMat,Insertdelta_num]=ImproveSolutionByInsert(x,m,n,sigma,ComparedMat,obj,pi)
curtime=clock;
origin_obj=obj;
flag=0;
Insertdelta_num=0;

for k=1:m
    for s=1:m
        if k~=s
            for i=1:n
                if x(k,pi(k,i))~=0
                    p=find(pi(s,:)==pi(k,i));   %p is the column in the sth row of pi that is equal to the ith item in the kth row of pi.
                    [delta,ComparedMat_changed,x_changed]=InsertOperation(n,i,p,k,s,sigma,ComparedMat,pi,x);
                    if delta<0
                        x=x_changed;
                        ComparedMat=ComparedMat_changed;
                        obj=obj+delta;
                        Insertdelta_num=Insertdelta_num+1;
                    end
                end
            end
        end
    end
end
if origin_obj-obj>exp(-10)
    flag=1;
end
time=etime(clock,curtime);
%disp(['Insert obj=',num2str(obj)]);
