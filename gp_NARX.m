gp = EnGP();
gp.set_data(x,y,'train');
gp.set_data(x_test_norm,ones(size(tspan))','test');
nps = 1;
gp.set_model(@NARX,nps,nps,1,1);

%gp.process.set_hyps(hyps)
gp.set_process(@GPR,Kernel('Matern32',hyps));
gp.props.optimiser = 'QPSO';

gp.optimise();
gp.predict('test')
y_pred = gp.process.mp;
y_pred = y_pred(:,1);
y_pred = sigma(:,2)*y_pred+mu(:,2);

plot(tspan(nps+1:end)',y_real(nps+1:end))
legend('NARX','Exact')
rmse = immse(y_pred,y_real(nps+1:end))
title(['GP Narx Model, rmse = ',num2str(rmse)])
xlabel('Time (s)')
ylabel('Response (m)')
hold on

lb = y_pred - 10*sqrt(var_pred);
ub = y_pred + 10*sqrt(var_pred);

p3 = plot(tspan(nps+1:end)',lb,'b--');
hold on
p4 = plot(tspan(nps+1:end)',ub,'b--');
hold on
h = fill([tspan(nps+1:end),fliplr(tspan(nps+1:end))],[lb',fliplr(ub')],'b','facealpha',0.25);
