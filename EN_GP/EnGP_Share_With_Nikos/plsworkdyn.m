% x = (-5:0.1:5)';
hyps.sf2 = 4;
hyps.ll = 4;
hyps.sn2 = 0.01;
% kern = Kernel('Matern32',hyps);
% K = kern.Matern32(x,x);
% y = mvnrnd(zeros(length(x),1),K)';
% figure
% plot(,y)
% xlabel('X')
% ylabel('Y')
% title('Target Function Drawn from GP')#
Y_pred=zeros(length(X_pred),1);
gp = EnGP();
gp.set_data(X,y);
% gp.predict_on(X_pred);
gp.set_data(X_pred,Y_pred,'test');
% gp.set_model(@Static);
gp.set_model(@NARX,7,7,1,1);
gp.set_process(@GPR,Kernel('Matern52',hyps));
gp.props.optimiser = 'QPSO';
gp.optimise();
gp.predict('test')
gp.process.mp;
gp.process.vp
m=gp.process.mp;
m(:,1)=[];
% figure
% gp.process.nmse
% repmu=repmat(mu(:,11),[184,2]);
% repsigma=repmat(sigma(:,11),[184,2]);
% m=gp.process.mp;
% m2=repsigma.*m;
% m3=m2+repmu;
% figure
% plot(m3(:,2))
% hold on
% plot(y_real)
% err=mae(m3(:,2),y_real)