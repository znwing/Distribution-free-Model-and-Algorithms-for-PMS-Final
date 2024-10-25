clc
clear all

mu=90;
sigma=12;

gxy1=zeros(1,10);
xy1 = zeros(10,2);
theta_e1=zeros(1,10);
w1=zeros(1,10);
x_w1=zeros(1,10);
min_MRV1=zeros(1,10);

index=1;
for a=1:10 
    %In the paper, "a" corresponds to the gamma, which is also represented as beta/alpha. 
    % The minimum value between alpha and beta is alpha, i.e., min{alpha, beta} = alpha.
    [x,fval]=solveg(a);
    gxy1(index)=-fval;
    xy1(index,1)=x(1); % corresponds to the x in paper 
    xy1(index,2)=x(2); % corresponds to the y in paper 
    theta_e1(index)=(x(2)*((a-x(2))/(1+x(2)))^0.5-x(1)*((1-x(1))/(a+x(1)))^0.5)/(x(1)+x(2));
    w1(index)=2/(1+a)*(1+(theta_e1(index))^2+((theta_e1(index))^2*(1+(theta_e1(index))^2))^0.5);
    x_w1(index)=mu+sigma*theta_e1(index); %theta_e1  corresponds to \bar{theta} in paper 
%     min_MRV1(index)=sigma*c_2*gxy1(index);
    index=index+1;
end


gxy=zeros(1,11);
xy = zeros(11,2);
theta_e=zeros(1,11);
w=zeros(1,11);
x_w=zeros(1,11);
min_MRV=zeros(1,11);

index=1;
for a=0:0.1:1%In the paper, "a" corresponds to the gamma, which is also represented as beta/alpha. 
    % The minimum value between alpha and beta is alpha, i.e., min{alpha, beta} = alpha.
    [x,fval]=solveg(a);
    gxy(index)=-fval;
    xy(index,1)=x(1);
    xy(index,2)=x(2);
    theta_e(index)=(x(2)*((a-x(2))/(1+x(2)))^0.5-x(1)*((1-x(1))/(a+x(1)))^0.5)/  (x(1)+x(2));
    w(index)=(2*a)/(1+a)*(1+(theta_e(index))^2+((theta_e(index))^2*(1+(theta_e(index))^2))^0.5);
    x_w(index)=mu+sigma*theta_e(index);
%     min_MRV(index)=sigma*c_2*gxy(index);
    index=index+1;
end
disp(theta_e)


%%%%%%%%%%%%%%%%%%%%%%%%%draws Figue 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u=0.1:0.1:0.9;
w(11)=[];
x_w(1)=0;
x_w(11)=[];
t=1:10;
ut=[u,t];
ww=[w,w1];
xww=[x_w,x_w1];
ind=0:19;
y1=ww;
y2=xww;
yyaxis left
plot(ind(2:19),y1(2:19),'ks-');
set(gca,'YColor','k');
ylabel('w^{*}');
ylim([0.3 1.1]);
hold on;
yyaxis right
plot(ind(2:19),y2(2:19),'kd-');
ylim([40 120]);
ylabel('d_w^{*}');
set(gca,'YColor','k');
set(gca,'XTick',ind);
xlabel('\gamma');
legend('w^*','d_w^{*}','Location','best');
set(gca,'XTickLabel',{'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1','2','3','4','5','6','7','8','9','10'});

