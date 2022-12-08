clc
close all
clear
% Reading input file
% read file from 20161001as-rel2.txt
file=fopen('20221001.as-rel2.txt');
Dataset=textscan(file,'%d|%d|%d|%s'); 
fclose(file);
ASes_F=Dataset{1};
ASes_S=Dataset{2};
Link=Dataset{3};
AS_1=unique(ASes_F);
AS_2=unique(ASes_S);
AS_comb=cat(1,AS_1,AS_2);
AS=unique(AS_comb);
m=length(AS);
n=length(Link);
p1=zeros(m,1);
c1=zeros(m,1);
pr1=zeros(m,1);
glob=zeros(m,1);
j=1;
for i=1:m
    peers=0;
    customer=0;
    provider=0;
    j=1;
    for j=1:n
        if(Link(j)==-1 && ASes_F(j)==AS(i))
            customer=customer+1;  
        elseif(Link(j)==-1 && ASes_S(j)==AS(i))
            provider=provider+1;
        elseif(Link(j)==0)
            if(ASes_F(j)==AS(i)|| ASes_S(j)==AS(i))
                peers=peers+1;
            end
        end
    end
    p1(i)=peers;
    c1(i)=customer;
    pr1(i)=provider;
    glob(i)=peers+customer+provider;
end

nm=length(glob);
bar_P=zeros(7,1);
for i=1:nm
    if glob(i)==0
        bar_P(1)=bar_P(1)+1;
    elseif glob(i)==1
        bar_P(2)=bar_P(2)+1;
    elseif glob(i)>1 && glob(i)<6
        bar_P(3)=bar_P(3)+1;
    elseif glob(i)>5 && glob(i)<101
        bar_P(4)=bar_P(4)+1;
    elseif glob(i)>100 && glob(i)<201
        bar_P(5)=bar_P(5)+1;
    elseif glob(i)>200 && glob(i)<1001
        bar_P(6)=bar_P(6)+1;
    elseif glob(i)>1000
        bar_P(7)=bar_P(7)+1;
    end
end
%bar_P(1)=0;
y=bar_P(1)+bar_P(2)+bar_P(3)+bar_P(4)+bar_P(5)+bar_P(6)+bar_P(7);
bar_P(1)=(bar_P(1)/y)*100;
bar_P(2)=(bar_P(2)/y)*100;
bar_P(3)=(bar_P(3)/y)*100;
bar_P(4)=(bar_P(4)/y)*100;
bar_P(5)=(bar_P(5)/y)*100;
bar_P(6)=(bar_P(6)/y)*100;
bar_P(7)=(bar_P(7)/y)*100;
%bar_N=bar_P'/nm;
%label=categorical({'0','1','2-5','6-100','101-200','201-1000','>1000'});
b=bar(bar_P);
grid on;
set(0,'defaulttextinterpreter','latex'); % allows you to use latex math 
set(0,'defaultlinelinewidth',2); % line width is set to 2 
set(0,'DefaultLineMarkerSize',10); % marker size is set to 10 
set(0,'DefaultTextFontSize', 8); % Font size is set to 16 
set(0,'DefaultAxesFontSize',6); % font size for the axes is set to 16
set(gca,'xticklabel',{'0','1','2-5','6-100','101-200','201-1000','>1000'});
ylabel('% of AS nodes');
xlabel('Range of Global degrees');
title('AS Global node degree distribution');
xtips1 = b.XEndPoints;
ytips1 = b.YEndPoints;
new_data=round(b.YData,2);
labels1 = string(new_data);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','baseline');
