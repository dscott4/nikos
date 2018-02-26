OX=fillmissing(OX,'linear');
figure
plot(t,OX);
title('Original Data')
xlabel('Year')
ylabel('\delta^1^8O%')
grid on
xlim([1894 2000])
OX2=movmean(OX,5);
figure
plot(t,OX2)
title('Seasonal Variations')
xlabel('Year')
ylabel('\delta^1^8O%')
grid on
xlim([1894 2000])
OX3=movmean(OX,250);
ave=mean(OX);
figure
plot(t,OX3)
hold on
plot([1894 2000], [ave ave])
title('Multi-Annual Variations')
xlabel('Year')
ylabel('\delta^1^8O%')
grid on
xlim([1894 2000])

S=fillmissing(Icecoredata21(:,3),'linear');
S1=S(1:327);
S1(109)=[];
smean=geomean(S1);
sd=std(S);
T=(smean-73.6)/(sd/sqrt(length(S)));
