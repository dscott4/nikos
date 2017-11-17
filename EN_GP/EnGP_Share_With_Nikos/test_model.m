
gp = EnGP();
x = linspace(0,100,1000)';
y = 3*x.^2+2+randn(1000,1);

gp.set_data([atr,vtr],ftr);
gp.set_data([at,vt],ft,'test');
gp.set_model(@NARX,10,10,1,1);
%gp.set_model(@Static)

hyps.sf2 = 2;
hyps.ll = repmat(1,1,30);
hyps.sn2 = 0.1;

gp.props.lims = [-1 repmat(-5,1,30) -8; 4 repmat(4,1,30) 2];

gp.set_process(@GPR,Kernel('Matern52',hyps,1));
gp.process.kernel.p = 3;

gp.props.optimiser = 'QPSO';
gp.optimise()
% gp.predict('Train')

xp = linspace(-50,150,1000)';
%options.pred_type = 'osa';
data.inputs = [xp];
%data.target = y;
gp.predict('test');
gp.props.plot_type = 'output';
gp.plot();

% figure
% plot(x,y)
% hold on
% plot(x,gp.process.mp)
% plot(x,gp.process.mp+3*sqrt(gp.process.vp))
% plot(x,gp.process.mp-3*sqrt(gp.process.vp))
