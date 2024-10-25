clc
clear
MachineArray=[10,15,20]; %Number of machines.

% Header
% Instance = ['Instance' ; 'G_LB'; 'Val_G'; 'Gap_G'; 't_G(s)';'Val_Greedy'; 'Gap_Greedy'; 't_Greedy(s)';'Val_TPA'; 'Gap_TPA'; 't_TPA(s)';];
Instance = [cellstr('Instance') ; cellstr('Val_G'); cellstr('RGap_G'); cellstr('t_G(s)');
    cellstr('Val_Greedy');cellstr('RGap_Greedy');cellstr( 't_Greedy(s)');
    cellstr('Val_TPA'); cellstr('RGap_TPA');cellstr( 't_TPA(s)')];

% define temp variable to calculate average value
Val_G_mn = zeros(1,9);
RGap_G_mn = zeros(1,9);
t_G_mn = zeros(1,9);
Val_Greedy_mn = zeros(1,9);
RGap_Greedy_mn = zeros(1,9);
t_Greedy_mn = zeros(1,9);
Val_TPA_mn = zeros(1,9);
RGap_TPA_mn = zeros(1,9);
t_TPA_mn = zeros(1,9);
index = 1;

k=2;
for m=MachineArray
    for n=[4*m,5*m,6*m]
        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
        filename=strcat('.\SOCP\result\SOCP_m',num2str(m),'n',num2str(n),'tol',num2str(5),'.mat');
        load(filename);
        instancename = cellstr( strcat('m = ',num2str(m),',n=',num2str(n)));
        G_LB = num2cell(mean(obj_bound_SOCP,2));
        Val_G = num2cell(mean(obj_SOCP,2));
        t_G = num2cell( mean(time_SOCP,2));
        xlswrite('.\table5result.xlsx',[instancename],['Sheet',num2str(1)],['A',num2str(k)]);
        xlswrite('.\table5result.xlsx',[Val_G],['Sheet',num2str(1)],['B',num2str(k)]);
        xlswrite('.\table5result.xlsx',[t_G],['Sheet',num2str(1)],['D',num2str(k)]);
        
        filename=strcat('.\TPA\GAresult\GA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        Val_Greedy = num2cell(mean(obj_GA,2));
        t_Greedy = num2cell(mean(time_GA,2));
        xlswrite('.\table5result.xlsx',[Val_Greedy],['Sheet',num2str(1)],['E',num2str(k)]);
        xlswrite('.\table5result.xlsx',[t_Greedy],['Sheet',num2str(1)],['G',num2str(k)]);
        
        % load RHA Time and obj value
        filename=strcat('.\TPA\RHAresult\RHA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        Val_TPA = num2cell(mean(obj_RHA,2));
        t_TPA = num2cell(mean(sum_time_RHA,2));
        xlswrite('.\table5result.xlsx',[Val_TPA],['Sheet',num2str(1)],['H',num2str(k)]);
        xlswrite('.\table5result.xlsx',[t_TPA],['Sheet',num2str(1)],['J',num2str(k)]);
        
        
        minvalue = min([mean(obj_SOCP,2), mean(obj_GA,2), mean(obj_RHA,2)]);
        Gap_G = (  mean(obj_SOCP,2)- minvalue) /  minvalue;
        Gap_G = num2cell(Gap_G);
        Gap_Greedy = (mean(obj_GA,2) -minvalue)/minvalue;
        Gap_Greedy = num2cell(Gap_Greedy);
        Gap_TPA = ( mean(obj_RHA,2) - minvalue)/minvalue;
        Gap_TPA = num2cell(Gap_TPA);
        xlswrite('.\table5result.xlsx',[Gap_G],['Sheet',num2str(1)],['C',num2str(k)]);
        xlswrite('.\table5result.xlsx',[Gap_Greedy],['Sheet',num2str(1)],['F',num2str(k)]);
        xlswrite('.\table5result.xlsx',[Gap_TPA],['Sheet',num2str(1)],['I',num2str(k)]);
        
        k=k+1;
        
        
        Val_G_mn(index) = mean(obj_SOCP,2);
        RGap_G_mn(index) = (  mean(obj_SOCP,2)-minvalue ) / minvalue;
        t_G_mn(index) = mean(time_SOCP,2);
        Val_Greedy_mn(index) = mean(obj_GA,2);
        RGap_Greedy_mn(index) = (mean(obj_GA,2) - minvalue)/minvalue;
        t_Greedy_mn(index) = mean(time_GA,2);
        Val_TPA_mn(index) = mean(obj_RHA,2);
        RGap_TPA_mn(index) = ( mean(obj_RHA,2) - minvalue )/minvalue;
        t_TPA_mn(index) = mean(sum_time_RHA,2);
        index = index +1;
    end
end

xlswrite('.\table5result.xlsx',[Instance'],['Sheet',num2str(1)],['A',num2str(1)]);

%Average
Average = [cellstr('Average') ;  num2cell(mean(Val_G_mn,2));num2cell(mean(RGap_G_mn,2));num2cell(mean(t_G_mn,2));
    num2cell(mean(Val_Greedy_mn,2));num2cell(mean(RGap_Greedy_mn,2));num2cell(mean(t_Greedy_mn,2));
    num2cell(mean(Val_TPA_mn,2)); num2cell(mean(RGap_TPA_mn,2));num2cell(mean(t_TPA_mn,2))];

xlswrite('.\table5result.xlsx',[Average'],['Sheet',num2str(1)],['A',num2str(k)]);