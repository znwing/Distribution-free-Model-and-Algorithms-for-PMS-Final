clc
clear

%load dataset of MRV
filename=strcat('.\MRV_matrix.mat');
load(filename);

% Header of Table(MRV)
gamma = [1/10 ;1/9 ;1/8 ;1/7 ;1/6 ;1/5 ;1/4 ;1/3 ;1/2 ;1 ;2; 3 ;4; 5; 6 ;7; 8 ;9 ;10];
gamma = ['gamma' ; num2cell(gamma)];

%Average each row of MRV data
MRV_dw = ['d_w^*';num2cell(mean(MRV_dw_matrix,2))];
MRV_d0 = ['d_0';num2cell(mean(MRV_d0_matrix,2))];
MRV_d05 = ['d_{0.5}';num2cell(mean(MRV_d05_matrix,2))];
MRV_d1 = ['d_1';num2cell(mean(MRV_d1_matrix,2))];
MRV_dN = ['d_normal';num2cell(mean(MRV_dN_matrix,2))];
MRV_dG = ['d_gamma';num2cell(mean(MRV_dG_matrix,2))];
MRV_dP = ['d_pareto';num2cell(mean(MRV_dP_matrix,2))];
MRV_dS = ['d_bimodal';num2cell(mean(MRV_dS_matrix,2))];

%Write data to excel(MRV)
xlswrite('.\MRVresult.xlsx',[gamma'],['Sheet',num2str(1)],['A',num2str(1)]);
xlswrite('.\MRVresult.xlsx',[MRV_dw'],['Sheet',num2str(1)],['A',num2str(2)]);
xlswrite('.\MRVresult.xlsx',[MRV_d0'],['Sheet',num2str(1)],['A',num2str(3)]);
xlswrite('.\MRVresult.xlsx',[MRV_d05'],['Sheet',num2str(1)],['A',num2str(4)]);
xlswrite('.\MRVresult.xlsx',[MRV_d1'],['Sheet',num2str(1)],['A',num2str(5)]);
xlswrite('.\MRVresult.xlsx',[MRV_dN'],['Sheet',num2str(1)],['A',num2str(6)]);
xlswrite('.\MRVresult.xlsx',[MRV_dG'],['Sheet',num2str(1)],['A',num2str(7)]);
xlswrite('.\MRVresult.xlsx',[MRV_dP'],['Sheet',num2str(1)],['A',num2str(8)]);
xlswrite('.\MRVresult.xlsx',[MRV_dS'],['Sheet',num2str(1)],['A',num2str(9)]);



%load dataset of RV
filename=strcat('.\saveData\N_RV.mat');
load(filename);
filename=strcat('.\saveData\G_RV.mat');
load(filename);
filename=strcat('.\saveData\P_RV.mat');
load(filename);
filename=strcat('.\saveData\S_RV.mat');
load(filename);

%Header of Table(RV)
gamma2 = [1/10 ;1/9 ;1/8 ;1/7 ;1/6 ;1/5 ;1/4 ;1/3 ;1/2 ;1 ;2; 3 ;4; 5; 6 ;7; 8 ;9 ;10];
gamma2 = ['distribution';'gamma' ; num2cell(gamma2)];

%Average each row of RV data
N_RV_dw = ['Normal';'d_w^*';num2cell(mean(N_RV_dw,2))];
N_RV_d0 = ['Normal';'d_0';num2cell(mean(N_RV_d0,2))];
N_RV_d05 = ['Normal';'d_{0.5}';num2cell(mean(N_RV_d05,2))];
N_RV_d1 = ['Normal';'d_1';num2cell(mean(N_RV_d1,2))];

G_RV_dw = ['Gamma';'d_w^*';num2cell(mean(G_RV_dw,2))];
G_RV_d0 = ['Gamma';'d_0';num2cell(mean(G_RV_d0,2))];
G_RV_d05 = ['Gamma';'d_{0.5}';num2cell(mean(G_RV_d05,2))];
G_RV_d1 = ['Gamma';'d_1';num2cell(mean(G_RV_d1,2))];

P_RV_dw = ['Pareto';'d_w^*';num2cell(mean(P_RV_dw,2))];
P_RV_d0 = ['Pareto';'d_0';num2cell(mean(P_RV_d0,2))];
P_RV_d05 = ['Pareto';'d_{0.5}';num2cell(mean(P_RV_d05,2))];
P_RV_d1 = ['Pareto';'d_1';num2cell(mean(P_RV_d1,2))];

S_RV_dw = ['Bimodal';'d_w^*';num2cell(mean(S_RV_dw,2))];
S_RV_d0 = ['Bimodal';'d_0';num2cell(mean(S_RV_d0,2))];
S_RV_d05 = ['Bimodal';'d_{0.5}';num2cell(mean(S_RV_d05,2))];
S_RV_d1 = ['Bimodal';'d_1';num2cell(mean(S_RV_d1,2))];

%Write data to excel(RV)
xlswrite('.\RVresult.xlsx',[gamma2'],['Sheet',num2str(1)],['A',num2str(1)]);
xlswrite('.\RVresult.xlsx',[N_RV_dw'],['Sheet',num2str(1)],['A',num2str(2)]);
xlswrite('.\RVresult.xlsx',[N_RV_d0'],['Sheet',num2str(1)],['A',num2str(3)]);
xlswrite('.\RVresult.xlsx',[N_RV_d05'],['Sheet',num2str(1)],['A',num2str(4)]);
xlswrite('.\RVresult.xlsx',[N_RV_d1'],['Sheet',num2str(1)],['A',num2str(5)]);

xlswrite('.\RVresult.xlsx',[G_RV_dw'],['Sheet',num2str(1)],['A',num2str(6)]);
xlswrite('.\RVresult.xlsx',[G_RV_d0'],['Sheet',num2str(1)],['A',num2str(7)]);
xlswrite('.\RVresult.xlsx',[G_RV_d05'],['Sheet',num2str(1)],['A',num2str(8)]);
xlswrite('.\RVresult.xlsx',[G_RV_d1'],['Sheet',num2str(1)],['A',num2str(9)]);

xlswrite('.\RVresult.xlsx',[P_RV_dw'],['Sheet',num2str(1)],['A',num2str(10)]);
xlswrite('.\RVresult.xlsx',[P_RV_d0'],['Sheet',num2str(1)],['A',num2str(11)]);
xlswrite('.\RVresult.xlsx',[P_RV_d05'],['Sheet',num2str(1)],['A',num2str(12)]);
xlswrite('.\RVresult.xlsx',[P_RV_d1'],['Sheet',num2str(1)],['A',num2str(13)]);

xlswrite('.\RVresult.xlsx',[S_RV_dw'],['Sheet',num2str(1)],['A',num2str(14)]);
xlswrite('.\RVresult.xlsx',[S_RV_d0'],['Sheet',num2str(1)],['A',num2str(15)]);
xlswrite('.\RVresult.xlsx',[S_RV_d05'],['Sheet',num2str(1)],['A',num2str(16)]);
xlswrite('.\RVresult.xlsx',[S_RV_d1'],['Sheet',num2str(1)],['A',num2str(17)]);









