tspan=[0:0.01:100];
F=0+1.*randn(1,10001);
Ft=tspan;

y0=[0;0;0;0];
[t y] = ode45(@(t,y) dof_sim_2d(t,y,Ft,F),tspan,y0);


%displaysment
y1=y(:,1);
y2=y(:,3);


%velocity
ydot1=y(:,2);
ydot2=y(:,4);

y_2dof=[y1,y2]';
 data=y_2dof';    

X =data;             
[n,m]=size(X);
Xmean=mean(X);
Xstd=std(X);
ZZ=(X-repmat(Xmean,[n 1]));
Q=repmat(Xstd, [n,1]);
C=ZZ./Q;
E=cov(C);
[V,G]=eig(E);
[G_sorted, ind] = sort(diag(G),'descend'); 
V_sorted=V(:,ind);
t=trace(G);
expvar=zeros(1,2);
for i=1:2
    expvar(i)=100*G_sorted(i,:)/t;
end
count=sum(expvar>5);
V_final=zeros(2,count);
for i=1:count
    V_final(:,i)=V_sorted(:,i);
end
transdata=C*V_final;

 pxxstore=zeros(2049,2);
 for i=1:2
    
 [pxx,f] = pwelch(transdata(1:end,i),[],[],[],100);
 [qtr ztr] = size(pxx);
minpn=0;
maxpn=1;
mina1= repmat(min(pxx',[],2),1,ztr);
maxa1= repmat(max(pxx',[],2),1,ztr);
pxx= minpn +(maxpn-minpn).*(pxx-mina1)./(maxa1-mina1);
pxxstore(:,i)=pxx;
 figure (1)
title('Normal')
    subplot(1,2,i);
    plot(f,pxx,'LineWidth',3,'color','black');
    xlim([0 10])
    ylabel('Power spectral density','FontSize',30);
    xlabel('Frequency','FontSize',30);
 end
 
  pxxstore2=zeros(2049,2);
 for i=1:2
    
 [pxx2,f] = pwelch(data(1:end,i),[],[],[],100);
 [qtr ztr] = size(pxx2);
minpn=0;
maxpn=1;
mina1= repmat(min(pxx2',[],2),1,ztr);
maxa1= repmat(max(pxx2',[],2),1,ztr);
pxx2= minpn +(maxpn-minpn).*(pxx2-mina1)./(maxa1-mina1);
pxxstore(:,i)=pxx2;
 figure (2)
title('Normal')
    subplot(1,2,i);
    plot(f,pxx2,'LineWidth',3,'color','black');
    xlim([0 10])
    ylabel('Power spectral density','FontSize',30);
    xlabel('Frequency','FontSize',30);
 end


