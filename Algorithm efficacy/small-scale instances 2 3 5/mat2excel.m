clc
clear
MachineArray=[2,3,5]; %Number of machines.

% Header
% Instance = ['Instance' ; 'G_LB'; 'Val_G'; 'Gap_G'; 't_G(s)';'Val_Greedy'; 'Gap_Greedy'; 't_Greedy(s)';'Val_TPA'; 'Gap_TPA'; 't_TPA(s)';];
Instance = [cellstr('Instance') ; cellstr( 'G_LB'); cellstr('Val_G'); cellstr('Gap_G'); cellstr('t_G(s)');
    cellstr('Val_Greedy');cellstr('Gap_Greedy');cellstr( 't_Greedy(s)');cellstr('Val_TPA'); cellstr('Gap_TPA');cellstr( 't_TPA(s)')];

% define temp variable to calculate average value
G_LB_mn = zeros(1,9);
Val_G_mn = zeros(1,9);
Gap_G_mn = zeros(1,9);
t_G_mn = zeros(1,9);
Val_Greedy_mn = zeros(1,9);
Gap_Greedy_mn = zeros(1,9);
t_Greedy_mn = zeros(1,9);
Val_TPA_mn = zeros(1,9);
Gap_TPA_mn = zeros(1,9);
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
        Gap_G = (  mean(obj_SOCP,2)- mean(obj_bound_SOCP,2) ) /  mean(obj_bound_SOCP,2);
        Gap_G = num2cell(Gap_G);
        t_G = num2cell( mean(time_SOCP,2));
        xlswrite('.\table4result.xlsx',[instancename],['Sheet',num2str(1)],['A',num2str(k)]);
        xlswrite('.\table4result.xlsx',[G_LB],['Sheet',num2str(1)],['B',num2str(k)]);
        xlswrite('.\table4result.xlsx',[Val_G],['Sheet',num2str(1)],['C',num2str(k)]);
        xlswrite('.\table4result.xlsx',[Gap_G],['Sheet',num2str(1)],['D',num2str(k)]);
        xlswrite('.\table4result.xlsx',[t_G],['Sheet',num2str(1)],['E',num2str(k)]);
        
        filename=strcat('.\TPA\GAresult\GA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        Val_Greedy = num2cell(mean(obj_GA,2));
        Gap_Greedy = (mean(obj_GA,2) - mean(obj_bound_SOCP,2))/mean(obj_bound_SOCP,2);
        Gap_Greedy = num2cell(Gap_Greedy);
        t_Greedy = num2cell(mean(time_GA,2));
        xlswrite('.\table4result.xlsx',[Val_Greedy],['Sheet',num2str(1)],['F',num2str(k)]);
        xlswrite('.\table4result.xlsx',[Gap_Greedy],['Sheet',num2str(1)],['G',num2str(k)]);
        xlswrite('.\table4result.xlsx',[t_Greedy],['Sheet',num2str(1)],['H',num2str(k)]);
        
        % load RHA Time and obj value
        filename=strcat('.\TPA\RHAresult\RHA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        Val_TPA = num2cell(mean(obj_RHA,2));
        Gap_TPA = ( mean(obj_RHA,2) - mean(obj_bound_SOCP,2) )/mean(obj_bound_SOCP,2);
        Gap_TPA = num2cell(Gap_TPA);
        t_TPA = num2cell(mean(sum_time_RHA,2));
        
        xlswrite('.\table4result.xlsx',[Val_TPA],['Sheet',num2str(1)],['I',num2str(k)]);
        xlswrite('.\table4result.xlsx',[Gap_TPA],['Sheet',num2str(1)],['J',num2str(k)]);
        xlswrite('.\table4result.xlsx',[t_TPA],['Sheet',num2str(1)],['K',num2str(k)]);
        
        k=k+1;
        
        G_LB_mn(index) = mean(obj_bound_SOCP,2);
        Val_G_mn(index) = mean(obj_SOCP,2);
        Gap_G_mn(index) = (  mean(obj_SOCP,2)- mean(obj_bound_SOCP,2) ) /  mean(obj_bound_SOCP,2);
        t_G_mn(index) = mean(time_SOCP,2);
        Val_Greedy_mn(index) = mean(obj_GA,2);
        Gap_Greedy_mn(index) = (mean(obj_GA,2) - mean(obj_bound_SOCP,2))/mean(obj_bound_SOCP,2);
        t_Greedy_mn(index) = mean(time_GA,2);
        Val_TPA_mn(index) = mean(obj_RHA,2);
        Gap_TPA_mn(index) = ( mean(obj_RHA,2) - mean(obj_bound_SOCP,2) )/mean(obj_bound_SOCP,2);
        t_TPA_mn(index) = mean(sum_time_RHA,2);
        index = index +1;
    end
end

xlswrite('.\table4result.xlsx',[Instance'],['Sheet',num2str(1)],['A',num2str(1)]);

%Average
Average = [cellstr('Average') ; num2cell(mean(G_LB_mn,2)); num2cell(mean(Val_G_mn,2));
    num2cell(mean(Gap_G_mn,2)); num2cell(mean(t_G_mn,2));
    num2cell(mean(Val_Greedy_mn,2));num2cell(mean(Gap_Greedy_mn,2));num2cell(mean(t_Greedy_mn,2));
    num2cell(mean(Val_TPA_mn,2)); num2cell(mean(Gap_TPA_mn,2));num2cell(mean(t_TPA_mn,2))];

xlswrite('.\table4result.xlsx',[Average'],['Sheet',num2str(1)],['A',num2str(k)]);