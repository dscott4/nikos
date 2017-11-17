
gp = EnGP();
gp.set_data(uEst,yEst,'train');
gp.set_model(@NARX,40,40,1,1);

hyps.sf2 = 20;
%hyps.ll = repmat(100,1,40);
hyps.ll = 20*randn(1,80)+100;
hyps.sn2 = 0.1;

gp.set_process(@GPR,Kernel('Matern52',hyps,1));
%gp.set_model(@Static_GP)

gp.props.optimiser = 'QPSO';

gp.optimise();
% hyps.sf2 = 103.9545;
% hyps.ll = 31.4868;
% hyps.sn2 = 0.0025;
% gp.process.set_hyps(hyps);

gp.set_data(uVal,yVal,'test');

options.pred_type = 'osa';
% 
% gp.predict('train',options);
% gp.props.plot_type = 'output';
% gp.plot;
% gp.process.nmse

gp.predict('test',options);
gp.props.plot_type = 'output';
figure
gp.plot;
gp.process.nmse

