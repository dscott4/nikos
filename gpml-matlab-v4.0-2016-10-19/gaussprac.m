% i=1:6:990;
% t=(1:1:1097);
% t2=(1:0.25:1097);
A=transdata';
x=A(1:2:end,:);
t=1:2:1097;
ts=2:2:1096;
y=XX(1:2:end,1);
xs=A(2:2:end,:);
ys=XX(2:2:end,1);
meanfunc=[];
covfunc=@covSEiso;
likfunc=@likGauss;
hyp = struct('mean', [], 'cov', [0 0], 'lik', 0);
hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);

[m s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);

% figure
% plot(t,y)
% hold on
% plot(t,m,'y')
%err=immse(m,ys);
