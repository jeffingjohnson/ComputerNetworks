clc
close all
clear 

file=fopen('20210401.as2types.txt');
Dataset=textscan(file,'%d %s %s');
fclose(file);
sequence=Dataset{1};
model=Dataset{3};
T='Transit/Access';
C='Content';
E='Enterprise';
bar_P=zeros(3,1);
for i=1:71665
    t=strcmp(model(i),T);
    c=strcmp(model(i),C);
    e=strcmp(model(i),E);
    if t==1
        bar_P(1)=bar_P(1)+1;
    elseif c==1
        bar_P(2)=bar_P(2)+1;
    elseif e==1
        bar_P(3)=bar_P(3)+1;
    end
end
bar_P(1)=(bar_P(1)/71665)*100;
bar_P(2)=(bar_P(2)/71665)*100;
bar_P(3)=(bar_P(3)/71665)*100;
label=categorical({'Transit','Content','Enterprise'});
b=bar(label,bar_P);
grid on;
set(0,'defaulttextinterpreter','latex'); % allows you to use latex math 
set(0,'defaultlinelinewidth',2); % line width is set to 2 
set(0,'DefaultLineMarkerSize',10); % marker size is set to 10 
set(0,'DefaultTextFontSize',12); % Font size is set to 16 
set(0,'DefaultAxesFontSize',12); % font size for the axes is set to 16
ylabel('% distribution of ASes');
xlabel('Class of AS');
title('AS Classification for 2021')
xtips1 = b.XEndPoints;
ytips1 = b.YEndPoints;
labels1 = string(b.YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','baseline');