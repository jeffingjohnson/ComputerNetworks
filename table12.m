data=[glob AS_1];
file=fopen('20221001.as-rel2.txt');
Dataset=textscan(file,'%d|%d|%d|%s'); 
fclose(file);
AS_F=Dataset{1};
AS_s=Dataset{2};
degree_sorted=sortrows(data,'descend');
R=degree_sorted(:,2);
num=length(R);
S=zeros(num,1);
S(1)=R(1);
i=2;
while i<num+1
    [FF]=find(AS_F(:,1)==R(i));
    [SS]=find(AS_s(:,1)==R(i));
    set=[FF;SS];
    set=unique(set);
    n=i-1;
    for x=1:i-1
        for y=1:length(set)
            if (AS_F(set(y),1)==S(x) && AS_s(set(y),1)==R(i))
                n=n-1;
            elseif (AS_s(set(y),1)==S(x) && AS_F(set(y),1)==R(i))
                n=n-1;
            end
        end
    end
    if n<i-1
        S(i)=R(i);
    end
    i=i+1;
    FF=0;
    SS=0;
    set=0;
end
S(S==0)=[];
s=length(S)