function[transdata, expvar, V_sorted]=pcatom(cov, data)
             
[V,G]=eig(cov);
[m, n]=size(cov);
[G_sorted, ind] = sort(diag(G),'descend'); 
V_sorted=V(:,ind);
t=trace(G);
expvar=zeros(1,m);
for i=1:m
    expvar(i)=100*G_sorted(i,:)/t;
end
count=sum(expvar>5);
V_final=zeros(m,count);
for i=1:count
    V_final(:,i)=V_sorted(:,i);
end
transdata=data*V_final;


