function [ fmin, xmin ] = cg_netlab( gpobj, varargin )
%CG_NETLAB

[hyps,size_matrix,hypnames] = Optimiser.unwrap_hyps(gpobj.process.hyps);
x = log(hyps);

options = foptions();
[x, options ] = conjgrad(@(x) Optimiser.assess_loglike(gpobj,x,size_matrix,hypnames) , x, options);



fmin = options(8);
xmin = x;

fprintf('Miniumum %.6e found in %i evaluations\n',fmin,options(10))

end

