function [ f,df ] = assess_loglike( gpobj, hyps, size_matrix, hypnames )
%ASSESS_LOGLIKE 

% Pass in log hyperparameters

hyps = Optimiser.wrap_hyps(exp(hyps),size_matrix,hypnames);
gpobj.process.set_hyps(hyps);
gpobj.process.update();

if nargout <= 1
    f = gpobj.process.nlml;
elseif nargout == 2
    [f,df] = gpobj.process.loglike;
else
    error('Wrong number of outputs specified');
end


end

