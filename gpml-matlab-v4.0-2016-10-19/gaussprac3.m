
% x=dataset(trainInd,1:10);
% y=dataset(trainInd,11);
xs=X(testInd,1:10);
ys=y(testInd,1);
% xs=dataset(:,1:10);
% ys=dataset(:,11);
%x=dataset(1:500,1:10);
%y=dataset(1:500,11);
x = X;
%xs=dataset(500:731,1:10);
%ys=dataset(500:731,11);
x(:,1)=[];
xs(:,1)=[];
x(:,5:6)=[];
xs(:,5:6)=[];

% for i=1:7
% x_red=x;
% xs_red=xs;
% x_red(:,i)=[];
% xs_red(:,i)=[];
% x(:,8)=[];
% xs(:,8)=[];

% for i = 1:10
%     X_red = x;
%     X_red(:,i) = [];
    
    meanfunc=[];
    covfunc=@covSEiso;
    likfunc=@likGauss;
    hyp = struct('mean', [], 'cov', [0 0], 'lik', -1);
    hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);

    [m s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);
%     err(i)=immse(m,ys);
% end
% end

% figure
% plot(t,y)
% hold on
% plot(t,m,'y')
 err=immse(m,ys)


figure(1)
hold on;
    f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
    x = [1:length(m)];
    fill([x'; flipdim(x',1)], f, [7 7 7]/8);
    plot(ys)
    plot(m)

xlabel('Sample points')
ylabel('Second component')
legend('Confidence intervals','Actual data','Mean prediction')