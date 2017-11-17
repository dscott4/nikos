function [ F, DF ] = loglike( self )
%LOGLIKE

npts = size(self.inputs,1);

if isempty(self.K)
    self.K = self.kernel.(self.kernel.type)(self.inputs,self.inputs);
end



if isempty(self.alpha)
    if isempty(self.R) || isempty(self.sl)
        if ( self.kernel.hyps.sn2 < 1) % very tiny sn2 can lead to numerical trouble.
            self.R = chol(self.K); self.sl =   1;  % Cholesky factor of covariance with noise
        else
            if self.kernel.hyps.sn2==0, error('Cannot support sn2=0 parameter');end
            self.R = chol(self.K/self.kernel.hyps.sn2); self.sl = self.kernel.hyps.sn2; % Cholesky factor of B
        end
    end
    %self.alpha = self.R\(self.R'\self.target)/self.sl;
    self.alpha = solve_chol(self.R,self.target)/self.sl;
end

F = (self.target')*self.alpha/2 + sum(log(diag(self.R))) + npts*log(2*pi*self.sl)/2;

if nargout>1
    
    DF = zeros(1,self.kernel.nhyp);
    if isempty(self.Q)
        self.Q = solve_chol(self.R,eye(npts))/self.sl - self.alpha*self.alpha';   % Precompute for convenience.
    end
    
    % Derivative WRT sf2.
    for idiff = 1:self.kernel.nhyp
        dK  = self.kernel.(self.kernel.type)(self.inputs,self.inputs,self.hyps,idiff);
        DF(idiff) = (1/2)*sum(sum(self.Q.*dK)); % = trace(Q*K)/2;
    end
    
end

end

