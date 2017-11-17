format long
load y_real
preprocessing2

bcps = 4;

hyps.sf2 = 5;
hyps.ll = 5;
hyps.sn2 = 0.01;
gp = EnGP();
gp.set_data(X,y);
X_pred = vertcat(X((end-bcps):end,:),X_pred);
gp.set_data(X_pred,zeros(length(X_pred),1),'test');
gp.set_model(@NARX,bcps,bcps,1,1);
gp.set_process(@GPR,Kernel('Matern52',hyps));
gp.props.optimiser = 'QPSO';
gp.optimise();
gp.predict('test');
gp.process.mp;
gp.process.vp;

gp.process.nmse;
m = gp.process.mp;
m = m(:,2);
m = (m*sigma(:,11))+mu(:,11);

figure
plot(m)
hold on
plot(y_real)
err = mae(y_real,m(2:end,:));
