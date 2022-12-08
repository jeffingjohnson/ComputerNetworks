clc
clear all
file=fopen('routeviews-rv2-20221001-1200.txt');
Dataset=textscan(file,'%s %d %s'); 
fclose(file);
IP=Dataset{1};
prefix=Dataset{2};
ASes=Dataset{3};
num=length(prefix);
S=regexp(ASes,'_','split');
ASes_revise=cell(num,1);
ASes_num=cell(num,1);
prefix_plus=zeros(num,1);
j=1;
for i=1:num
    num_size=length(S{i});
    if num_size==1
        ASes_revise{i}=S{i}{1};
    elseif num_size>1
        ASes_revise{i}=S{i}{1};
        while num_size>1
            ASes_num{j}=S{i}{num_size};
            prefix_plus(j)=prefix(i);
            num_size=num_size-1;
            j=j+1;
        end
    end
end
ASes_revise=str2double(ASes_revise);
ASes_num=str2double(ASes_num);
ASes_num(isnan(ASes_num))=[];
prefix_plus(prefix_plus==0)=[];
AS=cat(1,ASes_revise,ASes_num);
prefix_connected=cat(1,prefix,prefix_plus);
n=length(prefix_connected);
prefix_sorted=zeros(n,1);
[AS,index]=sort(AS);
for i=1:n
    prefix_sorted(i)=prefix_connected(index(i));
    prefix_sorted(i)=2.^(32-prefix_sorted(i));
end
AS_num=unique(AS);
m=length(AS_num);
prefix_num=zeros(m,1);
j=1;
num_1=0;
i=1;
while i<n+1
    if AS(i)==AS_num(j)
        for a=i:n
            if AS(a)==AS_num(j)
                prefix_num(j)=prefix_num(j)+prefix_sorted(a);
                num_1=num_1+1;
            else
                break;
            end
        end
        i=i+num_1;
        j=j+1;
    else
        i=i+1;
    end
    num_1=0;
end
percent=prefix_num./(2^32);
bar_P=zeros(18,1);
for i=1:m
    if percent(i)<=2^(-27)
        bar_P(1)=bar_P(1)+1;
    elseif percent(i)>2^(-26) && percent(i)<=2^(-25)
        bar_P(2)=bar_P(2)+1;
    elseif percent(i)>2^(-25) && percent(i)<=2^(-24)
        bar_P(3)=bar_P(3)+1;
    elseif percent(i)>2^(-24) && percent(i)<=2^(-23)
        bar_P(4)=bar_P(4)+1;
    elseif percent(i)>2^(-23) && percent(i)<=2^(-22)
        bar_P(5)=bar_P(5)+1;
    elseif percent(i)>2^(-22) && percent(i)<=2^(-21)
        bar_P(6)=bar_P(6)+1;
    elseif percent(i)>2^(-21) && percent(i)<=2^(-20)
        bar_P(7)=bar_P(7)+1;
    elseif percent(i)>2^(-20) && percent(i)<=2^(-19)
        bar_P(8)=bar_P(8)+1;
    elseif percent(i)>2^(-19) && percent(i)<=2^(-18)
        bar_P(9)=bar_P(9)+1;
    elseif percent(i)>2^(-18) && percent(i)<=2^(-17)
        bar_P(10)=bar_P(10)+1;
    elseif percent(i)>2^(-17) && percent(i)<=2^(-16)
        bar_P(11)=bar_P(11)+1;
    elseif percent(i)>2^(-16) && percent(i)<=2^(-15)
        bar_P(12)=bar_P(12)+1;
    elseif percent(i)>2^(-15) && percent(i)<=2^(-14)
        bar_P(13)=bar_P(13)+1;
    elseif percent(i)>2^(-14) && percent(i)<=2^(-13)
        bar_P(14)=bar_P(14)+1;
    elseif percent(i)>2^(-13) && percent(i)<=2^(-12)
        bar_P(15)=bar_P(15)+1;
    elseif percent(i)>2^(-12) && percent(i)<=2^(-11)
        bar_P(16)=bar_P(16)+1;
    elseif percent(i)>2^(-11) && percent(i)<=2^(-10)
        bar_P(17)=bar_P(17)+1;        
    elseif percent(i)>2^(-10)
        bar_P(18)=bar_P(18)+1;
    end
end
barN=bar_P;
bar_P=(bar_P./m)*100;
b=bar(bar_P);
grid off;
set(0,'defaulttextinterpreter','latex'); % allows you to use latex math 
set(0,'defaultlinelinewidth',2); % line width is set to 2 
set(0,'DefaultLineMarkerSize',10); % marker size is set to 10 
set(0,'DefaultTextFontSize', 12); % Font size is set to 16 
set(0,'DefaultAxesFontSize',12);
set(gca,'xticklabel',{'<=2^{-27}','>2^{-26} - <=2^{-25}','>2^{-25} - <=2^{-24}','>2^{-24} - <=2^{-23}','>2^{-23} - <=2^{-22}','>2^{-22} - <=2^{-21}','>2^{-21} - <=2^{-20}','>2^{-20} - <=2^{-19}','>2^{-19} - <=2^{-18}','>2^{-18} - <=2^{-17}','>2^{-17} - <=2^{-16}','>2^{-16} - <=2^{-15}','>2^{-15} - <=2^{-14}','>2^{-14} - <=2^{-13}','>2^{-13} - <=2^{-12}','>2^{-12} - <=2^{-11}','>2^{-11} - <=2^{-10}','>2^{-10}'});
% set(b,'XTickLabel',{'1','2-5','5-100','100-200','200-1000','>1000'})
% legend('XX');
xlabel('IP Ranges')
ylabel('% of AS nodes');
title('IP space distribution');
xtips1 = b.XEndPoints;
ytips1 = b.YEndPoints;
new_data=round(b.YData,2);
labels1 = string(new_data);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','baseline');