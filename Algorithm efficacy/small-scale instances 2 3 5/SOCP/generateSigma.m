MachineArray=[2,3,5];
l_paraArray=[0.1];
u_paraArray=[0.25];%u_paramu represents the upper bound of the standard deviation distribution, while the lower bound of the standard deviation distribution is taken as 0.1mu.
lbArray=[10];%The lower bound of the uniform distribution.  
ubArray=[100];%The upper bound of the uniform distribution.  
Groups=10;

for lb=lbArray
    for ub=ubArray
        sheetname=[num2str(lb),'-',num2str(ub)];
        location1=1;
        for l_para=l_paraArray
            for u_para=u_paraArray
                
                disp(['The range of mean distribution£º',num2str(lb),'-',num2str(ub),';The distribution of standard deviation£º',num2str(l_para),'mu','-',num2str(u_para),'mu'])
                for m=MachineArray
                    for n=[4*m,5*m,6*m]
                        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
                        index=1;
                        for k=1:Groups
                            disp(['k=',num2str(k)])
                            %[sigma,halfsigma,sorted_sigma,pi]=getSigma(m,n,lb,ub,l_para,u_para);
                            
                            %store sigma
                            [mu,sigma,halfsigma]=getSigma(m,n,lb,ub,l_para,u_para);
                            filename=strcat('.\jobdata\mu',num2str(lb),'_',num2str(ub),'\sigma',num2str(l_para),'_',num2str(u_para),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
                            save(filename,'sigma');
                        end
                    end
                end
            end
        end
    end
end




