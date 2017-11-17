function [ K ] = Matern52( self, xp, xq, hyps, idiff )
%Matern52 5/2 Matern Kernel

if nargin< 5
    idiff = 0;
end

if size(xp,2) == size(xq,2)
    D = size(xp,2);
else
    error('Input dimensionality not consistent');
end

if nargin < 4
    sf2 = self.hyps.sf2;
    ll = self.hyps.ll;
    sn2 = self.hyps.sn2;
else
    sf2 = hyps.sf2;
    ll = hyps.ll;
    sn2 = hyps.sn2;
end

if ~isempty(self.active_dims)
    xp = xp(:,self.active_dims);
    xq = xq(:,self.active_dims);
end
    

npts_p = size(xp,1);
npts_q = size(xq,1 );

if self.ARD == false
    
    
        r = pdist2(xp,xq);
        
        switch idiff
            case 0
                % K
                K = sf2*((1+(sqrt(5)*r/ll)+(5*r.^2/3/ll^2)).*exp(-(sqrt(5)*r/ll)))+sn2*eye(npts_p,npts_q);
                
            case 1
                % dK/dsf2
                K = sf2*((1+(sqrt(5)*r/ll)+(5*r.^2/3/ll^2)).*exp(-(sqrt(5)*r/ll)));
            case 2
                % dK/dll
                %K = ;
            case 3
                % dK/dsn2
                K = sn2*eye(nptsp,npts_q);
        end
        
        
    
else
    
    
%% Matern Kernel nu = 3/2 with ARD
        
        r = pdist2(bsxfun(@rdivide,xp,sqrt(ll)),bsxfun(@rdivide,xq,sqrt(ll)));
        
        switch idiff
            case 0
                % K
                K = sf2*((1+sqrt(5)*r+5*r.^2./3).*exp(-sqrt(5)*r))+sn2*eye(npts_p,npts_q);
                
            case 1
                % dK/dsf2
                %K = sf2*((1+r*sqrt(3)).*exp(-sqrt(3)*r))+sn2*eye(npts_p,npts_q);
                error('No grads for matern52 ard')
            
            case D+2
                % dK/dsn2
                %K = sn2*eye(npts_p,npts_q);
                error('No grads for matern52 ard')
                
            otherwise
                % dK/dll
                %K = sf2*((1+r*sqrt(3)).*exp(-sqrt(3)*r));
                %K = K.*(-sqrt(3)*pdist2(bsxfun(@rdivide,xp(:,idiff-1),ll(idiff-1)),bsxfun(@rdivide,xq(:,idiff-1),ll(idiff-1))));
                error('No grads for matern52 ard')
        end
    
   
    
end

end

