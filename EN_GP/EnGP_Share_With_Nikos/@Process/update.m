function [ self ] = update( self )
%UPDATE

if isempty(self.inputs)
    warning('No data, cannot update process')    
else
    
    %self.kernel.hyps = self.hyps;
    self.K = self.kernel.(self.kernel.type)(self.inputs,self.inputs); 
    try
        if ( self.kernel.hyps.sn2 < 1e-6 ) % very tiny sn2 can lead to numerical trouble.
            self.R = chol(self.K); self.sl =   1;  % Cholesky factor of covariance with noise
        else
            self.R = chol(self.K/self.kernel.hyps.sn2); self.sl = self.kernel.hyps.sn2; % Cholesky factor of B
        end

        self.alpha = self.R\(self.R'\self.target)/self.sl;
    catch
        
        warning ('Cholesky failed,  regularising');
        
        self.K = self.K+eye(size(self.K))*1e-6;
        
        if ( self.kernel.hyps.sn2 < 1e-6 ) % very tiny sn2 can lead to numerical trouble.
            self.R = chol(self.K); self.sl =   1;  % Cholesky factor of covariance with noise
        else
            self.R = chol(self.K/self.kernel.hyps.sn2); self.sl = self.kernel.hyps.sn2; % Cholesky factor of B
        end

        self.alpha = self.R\(self.R'\self.target)/self.sl;
        
    end
        
    self.Q = [];
    self.nlml = self.loglike;
    self.mp = [];
    self.vp = [];
    self.nmse = [];

end
end
