MachineArray=1;
m=1;n=100;
l_paraArray=[0.1];
u_paraArray=[0.25];
lbArray=[10]; 
ubArray=[100]; 

for lb=lbArray
    for ub=ubArray
        for l_para=l_paraArray
            for u_para=u_paraArray
                disp(['mean distribution range£º',num2str(lb),'-',num2str(ub),';standard deviation error distribution£º',num2str(l_para),'mu','-',num2str(u_para),'mu'])
                index=1;
                %save sigma and mu
                [mu,sigma,halfsigma]=getSigma(m,n,lb,ub,l_para,u_para);
                filename=strcat('mu',num2str(lb),'_',num2str(ub),'sigma',num2str(l_para),'_',num2str(u_para),'_m',num2str(m),'n',num2str(n),'.mat');
                save(filename,'mu','sigma','halfsigma'); 
            end
        end
    end
end
