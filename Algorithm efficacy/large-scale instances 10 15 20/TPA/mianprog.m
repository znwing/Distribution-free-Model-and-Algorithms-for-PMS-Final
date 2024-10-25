%2021.8.18 chengzihan
clc
clear all
MachineArray=[20]; %number of machines
Groups=10;            %generate 10 sets of data for each group of m and n.
time_GA=zeros(1,Groups);  %store the time of GA algorithm.
obj_GA=zeros(1,Groups);   %store the obj value of GA algorithm.

totaltime_RHA=zeros(1,Groups); %store the time of RHA algorithm.(This value will be overwritten during each local search iteration.)
sum_time_RHA=zeros(1,Groups); %%store the time of RHA algorithm
obj_RHA=zeros(1,Groups);  %store the obj value of RHA algorithm


time_Insert=zeros(1,Groups); %store the time of every insertion operation 
sum_time_Insert=zeros(1,Groups); %store the total time of insertion operation 
obj_Insert=zeros(1,Groups);  %store the obj value of insertion operation 


time_Exchange=zeros(1,Groups); %store the time of every  exchange operation 
sum_time_Exchange=zeros(1,Groups); %store the total time of exchange operation 
obj_Exchange=zeros(1,Groups);  %store the obj value of exchange operation 


time=zeros(1,Groups);     %store total time
Iteration=zeros(1,Groups);     %store the number of local searches performed for each set of data


for m=MachineArray
    for n=[6*m] % JobArray=[4*MachineArray,5*MachineArray,6*MachineArray];
        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
        index=1;
        obj_Insert_matrix=zeros(Groups,1); %store the obj value after performing insertion search
        obj_Exchange_matrix=zeros(Groups,1); %store the obj value after performing exchange search
        time_Insert_matrix=zeros(Groups,1); %store the time after performing insertion search
        time_Exchange_matrix=zeros(Groups,1);%store the time after performing exchange search
        obj_RHA_matrix=zeros(Groups,1); %store the obj value after performing RHA
        Iteration_RHA_matrx=zeros(Groups,1); %store the number of times RHA has been performed
        Iteration_time_RHA_matrx=zeros(Groups,1); %store the time for each RHA execution
        
        for k=1:Groups
            disp(['k=',num2str(k)])
            % load data
            filename=strcat('.\jobdata\mu10_100\sigma0.1_0.25','_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            load(filename);
            % sorting each row of the sigma matrix to obtain sorted_sigma, sorted_sigma represents the sigma matrix after sorting, and pi represents the index of each element in the original sigma matrix after sorting.
            [sorted_sigma,pi]=sort(sigma,2);
          
            %1.obtain the initial solution x_GA for the greedy algorithm.
            [time_GA(index),x_GA,obj_GA(index),ComparedMat_GA]=getInitialSolutionByGreedyAlgorithm(m,n,sigma,pi);
            disp(['GA obj=',num2str(obj_GA(index))]);
            
            %2. perform an insertion operation on the k-th set of data for m machines and n jobs
            [flag1,time_Insert(index),x_Insert,obj_Insert(index),ComparedMat_Insert]=ImproveSolutionByInsert(x_GA,m,n,sigma,ComparedMat_GA,obj_GA(index),pi);
            disp(['Insert obj=',num2str(obj_Insert(index))])
            time_Insert_matrix(index,end+1)=time_Insert(index); %store the time for each insertion search operation.
            sum_time_Insert(index)=sum_time_Insert(index)+time_Insert(index); %store the cumulative time of insertion searches.
            obj_Insert_matrix(index,end+1)=obj_Insert(index); % store the obj value after performing an insertion search
            obj_Insert_matrix(find(obj_Insert_matrix==0))=[1000000];
            
            %3. perform an exchange operation on the k-th set of data for m machines and n jobs.
            [flag2,time_Exchange(index),x_Exchange,obj_Exchange(index),ComparedMat_Exchange]=ImproveSolutionByExchange(x_Insert,m,n,sigma,ComparedMat_Insert,obj_Insert(index),pi);
            disp(['Exchange obj=',num2str(obj_Exchange(index))])
            time_Exchange_matrix(index,end+1)=time_Exchange(index);
            sum_time_Exchange(index)=sum_time_Exchange(index)+time_Exchange(index);
            obj_Exchange_matrix(index,end+1)=obj_Exchange(index);
            obj_Exchange_matrix(find(obj_Exchange_matrix==0))=[1000000];
            
            %4.RHA with multiMachine£¬
            %RHA differs from insertion operations and exchange operations in that it requires multiple iterations during each search process. when calculating the total time taken, the duration of each iteration is recorded, and these durations are summed up to arrive at the overall time.
            [x_RHA,obj_RHA(index),ComparedMat_RHA,totaltime_RHA(index),Iteration_time,Iteration_RHA,flag_impro_RHA]=solveByRHAWithMultiM(x_Exchange,m,n,sigma,pi,obj_Exchange(index),ComparedMat_Exchange);
            disp(['RHA obj=',num2str(obj_RHA(index))])
            Iteration_RHA_matrx(index,end+1)=0;
            Iteration_RHA_matrx(index,end+1)=Iteration_RHA;
            Iteration_time_RHA_matrx(index,end+1)=0;
            q=length(Iteration_time);
            Iteration_time_RHA_matrx(index,end+1:end+q)=Iteration_time;
            sum_time_RHA(index)=sum_time_RHA(index)+totaltime_RHA(index);
            obj_RHA_matrix(index,end+1)=obj_RHA(index);
            obj_RHA_matrix(find(obj_RHA_matrix==0))=[1000000];
            
            Iteration(index)=1;
            flag=1;
            while flag==1
                disp([num2str(Iteration(index)),'-th local research']);
                %3Perform an insertion operation on the k-th set of data for m machines and n jobs.
                [flag1,time_Insert(index),x_Insert,obj_Insert(index),ComparedMat_Insert]=ImproveSolutionByInsert(x_RHA,m,n,sigma,ComparedMat_RHA,obj_RHA(index),pi);
                disp(['Insert obj=',num2str(obj_Insert(index))])
                time_Insert_matrix(index,end+1)=time_Insert(index);
                sum_time_Insert(index)=sum_time_Insert(index)+time_Insert(index);
                obj_Insert_matrix(index,end+1)=obj_Insert(index);
                
                %4Perform a excahnge operation on the k-th set of data for m machines and n jobs.
                [flag2,time_Exchange(index),x_Exchange,obj_Exchange(index),ComparedMat_Exchange]=ImproveSolutionByExchange(x_Insert,m,n,sigma,ComparedMat_Insert,obj_Insert(index),pi);
                disp(['Exchange obj=',num2str(obj_Exchange(index))])
                time_Exchange_matrix(index,end+1)=time_Exchange(index);
                sum_time_Exchange(index)=sum_time_Exchange(index)+time_Exchange(index);
                obj_Exchange_matrix(index,end+1)=obj_Exchange(index);
                
                if obj_Exchange(index)>=min( obj_RHA_matrix(index,:));
                    flag=0;
                end
                    
                % The flag identifies whether there has been an improvement in the target value after performing insertion and swap search. If there is an improvement, an RHA is performed once again.
                if flag==1
                    [x_RHA,obj_RHA(index),ComparedMat_RHA,totaltime_RHA(index),Iteration_time,Iteration_RHA,flag_impro_RHA]=solveByRHAWithMultiM(x_Exchange,m,n,sigma,pi,obj_Exchange(index),ComparedMat_Exchange);
                    disp(['RHA obj=',num2str(obj_RHA(index))])
                    Iteration_RHA_matrx(index,end+1)=0;
                    Iteration_RHA_matrx(index,end+1)=Iteration_RHA;
                    Iteration_time_RHA_matrx(index,end+1)=0;
                    q=length(Iteration_time);
                    Iteration_time_RHA_matrx(index,end+1:end+q)=Iteration_time;
                    sum_time_RHA(index)=sum_time_RHA(index)+totaltime_RHA(index);
                    obj_RHA_matrix(index,end+1)=obj_RHA(index);
                    Iteration(index)=Iteration(index)+1;
                end
            end
            obj_Exchange(index)=min( obj_Exchange_matrix(index,:));
            obj_Insert(index)=min( obj_Insert_matrix(index,:)); 
            obj_RHA(index)=min( obj_RHA_matrix(index,:)); 
            disp(['the final obj value is',num2str(obj_Exchange(index))])
            index=index+1;
        end
        
        %store the time and obj value of the GA
        filename=strcat('.\GAresult\GA_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'obj_GA','time_GA');
        load(filename);
        
        %store the time and obj value of the RHA
        filename=strcat('.\RHAresult\RHA_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'obj_RHA','obj_RHA_matrix','sum_time_RHA','Iteration_time_RHA_matrx','Iteration_RHA_matrx');
        load(filename);
        
        %store the time and obj value of the InsertExchange
        filename=strcat('.\InsertExchangeresult\InsertExchange_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'obj_Insert', 'obj_Exchange','obj_Insert_matrix','obj_Exchange_matrix','time_Insert_matrix','time_Exchange_matrix','sum_time_Insert','sum_time_Exchange');
        load(filename);
        
        
        %store the total time
        time=time_GA+sum_time_RHA+sum_time_Insert+sum_time_Exchange;
        filename=strcat('.\timeresult\total_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'time');
    end
end
